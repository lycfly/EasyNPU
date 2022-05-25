# EasyNPU
[TOC]
## 整体架构

<center>
<img src="/docs/images/Array.drawio.svg" width = "700" height = "300" alt="EasyNPU架构"/>
</center>

## 计算单元PE
+ 只利用乘累加单元，可以实现卷积，全连接
+ BN需要将参数合并成乘数和加数
+ 非线性激活函数可以通过线性插值，转换为ax+b的分段形式，内部提供一个分段查找表，将分段系数填入，根据x值获得对应的a和b，输入MAC进行计算
<center>
<img src="/docs/images/PE.drawio.svg" width = "600" height = "500" alt="PE结构"/>
</center>

PE单元只负责实现基本的运算，有如下控制信号负责控制PE的行为，进而组合成需要的计算功能:

<center>

| Name  | Width  | Function  |
|:--|:--|:--|
| Pe_ps_addr  | 6  | Psum Regfile addr  |
| Pe_ps_outer_en  | 1  | 外部Psum使能, 用于累加Bias |
| Pe_ps_back_en  | 1  | Psum结果回环使能，控制Psum经定点化后是否送到到乘法器输入 |
| Pe_ps_shift_scale  | 8  | Psum量化参数，通过编译器计算得到  |
| Pe_maxpool_en  |  1 | Maxpool模式使能开关  |
| Pe_byp_mul_en  |  1 | 乘法器旁路使能开关  |

</center>

### 卷积算子
+ **Pe_ps_addr**信号选择Psum输出到对应的RegFile地址。
+ **Pe_ps_outer_en**,**Pe_ps_back_en**,均保持默认值（0）。

### 全连接算子
+ **Pe_ps_addr**信号选择Psum输出到对应的RegFile地址。
+ **Pe_ps_outer_en**,**Pe_ps_back_en**均保持默认值（0）。
  
### BN算子
  BN算子用于计算BatchNormal操作。BN一般都位于卷积算子之后，因此可以直接对PE内部卷积计算完成的Psum进行BN操作，过程如下：
1. **Pe_ps_addr**信号选择Psum对应的RegFile地址。
2. 配置**Pe_ps_outer_en** = 1, 选择加法器一端输入为pe_bias_in。
3. 配置**Pe_ps_shift_scale**，选择BN输入数据的量化参数。
4. 配置**Pe_ps_back_en**=1, 选择乘法器一端输入为定点量化之后的Psum。
5. pe_weight_in端口输入数据为BN对应的乘数。

目前PE实现BN操作需要软件将$\beta,\gamma,\mu,\sigma$参数转换成一个乘数(multiplier)和一个加数（bias)的形式。

### Short_cut算子
本加速器PE支持算子融合模式计算下图所示的short_cut。
<center>
<img src="/docs/images/short_cut.drawio.svg" width = "300" height = "300" alt="PE结构"/>
</center>
这种类型的short_cut特点是跳远连接只跨越一个卷积/全连接层。
在PE内部只需要将Psum中的内容跟输入的Ifmap进行累加即可获得跳远连接累加后的输出。也就是将卷积层与Add层进行了融合。此时控制信号：

1. **Pe_ps_addr**信号选择Psum对应的RegFile地址。
2. **Pe_ps_outer_en** 保持默认值0。
3. **Pe_ps_shift_scale**输入量化参数。
4. 配置**Pe_ps_back_en**=1, 选择乘法器一端输入为定点量化之后的Psum。
5. pe_weight_in端口输入数据为short cut的乘数系数（如果需要的话）。

这种本地计算short cut的add操作可以减少ifmap的重复读入，但是限制是short cut只能跳一个层，限制还是比较大的。如果跳跃了多个层，还是需要将Psum存回外部存储，之后再当作ifmap导入到需要进行Add操作的层。因此对于这种更一般的情况，控制信号为:
1. **Pe_ps_addr**信号选择Psum对应的RegFile地址。
2. 配置**Pe_ps_outer_en,Pe_ps_back_en** = 0, 选择加法器一端输入为内部Psum。
3. pe_ifmap_in端口输入数据为跳远连接的原始tensor。

### AvgPool算子
为了减少控制逻辑设计难度，平均值池化需要在编译器阶段转换为卷积的形式，只不过卷积核的参数都是固定的。例如下图中的2*2大小的均值池化:
<center>
<img src="/docs/images/avgpool.drawio.svg" width = "300" height = "300" alt="PE结构"/>
</center>
对应的等效卷积核大小为2*2，Weight均为1/4。卷积形式为Depthwise卷积，因此可以复用卷积的计算通路。

### MaxPool算子
与AvgPool类似，MaxPool也可以转化为等效地卷积形式，但是需要注意的是，MaxPool模式下的等效卷积核没有Weight参数,且计算逻辑中的累加也需要替换成“>”符号，因此需要控制**pe_maxpool_en**信号来切换相关逻辑以及bypass掉乘法器逻辑。

### Activation算子
激活函数也可以复用卷积通路，方法是需要将激活函数在软件层面进行线性插值，将插值表写为Ax+B的形式，保持A和B，作为PE的Weight和Bias输入, 即可进行近似的Activation计算。

## Scratch Pad
### Ifmap暂存器
PE内部不设置单独的寄存器存储Ifmap，而是将所有scratch pad移到外部，充当片上的Ifmap缓存。
+ 16个等大小的Ifmap pad，每个Pad有64个条目，每个pad数据位宽为8bit。
+ 每个pad的64个条目存储一张单通道的ifmap子图。
+ 通过一个hw_addr地址寄存器索引所有pad的64个条目，该寄存器实际上控制了卷积的滑动。
+ 通过一个ch_addr地址寄存器选择广播模式时将16个pad中的哪一个广播到所有PE，用于控制卷积的通道方向。
+ 通过cast_mode寄存器可以切换当前的PE计算采用多播ifmap还是广播ifmap的形式。当采用多播模式时，16个scratch pad的输出被分别接到16个PE上；当采用广播模式时，每个PE的ifmap均接到由ch_addr选择的那个pad上。
+ 为了提高读写带宽，if_bus总线位宽为128bit，对应16个8bit ifmap数据。
+ ifmap总线位宽决定了DTCM存储器的数据位宽，有很多实验证明，从Sram中单次读出N个m Byte的数据比读N次每次读出m Byte数据的总功耗更低。因此if_bus采用较大的位宽。


<center>
<img src="/docs/images/scratch_pad_ifmap.drawio.svg" width = "500" height = "300" alt="PE结构"/>
</center>

**广播模式：**
普通卷积和全连接算子均采用广播模式，相当于各个PE复用同一块ifmap pad中的条目。此时剩下的ifmap pad只是充当数据暂存的作用；当运算完当前pad中的ifmap数据后，ch_addr切换通道选择下一个Pad送到PE中。
通过这种广播ifmap的方式，利用了卷积以及全连接层的输入复用特性，每次计算都能得到16个输出通道数据。

**多播模式：**
多播模式主要是为了支持数据复用特性较弱的一些算子，例如Depthwise，Pooling等算子。
以Depthwise卷积为例，当ifmap pad的数据按通道填入后，由于depthwise卷积的输入通道固定是1，所以没办法像普通卷积那样，将一个Ifmap pad的数据广播给所有PE。除非对该算子单独设计一个控制逻辑，将每个PE的weight都连接到相同的卷积核，然后所有PE共同完成这一个通道的Depthwise卷积。
为了简化设计EasyNPU并不打算采用这种方式，而是与普通卷积保持一致，让每个PE各司其职地负责一个输出通道的map计算。因此每个PE都需要各自的ifmap，这也是设置16个ifmap pad的原因之一。

实际上，多播模式是专门为逐通道计算模式设计的，因此只要是具有逐通道计算特性的算子都可以使用该模式，下表列出了一些具有逐通道计算特性的算子：

<center>

| Name    | 
|:--|
| Depthwise卷积层  |    
| Pooling层  |  
| BatchNorm/SSN层  | 
| Activation层  | 

</center>

### Weight暂存器
Weight的scratch pad与Ifmap类似，同样分成16组，只不过每组的条目只有16个。

<center>
<img src="/docs/images/scratch_pad_weight.drawio.svg" width = "500" height = "300" alt="weight scratch pad"/>
</center>

+ Weight Bus位宽为128，对应16个8bit数，表示16个output channal数据。
+ 每次Weight Bus取出128bit数，按照16份分别送入16组weight pad。
+ 每次取出的16组weight在out channel方向是连续的
+ 每个weight pad连接到一个PE上，PE所取的weight元素由寄存器weight_och_group_cnt控制。
+ 每次计算时，16个PE计算连续的16个out channel，当算完时，weight_och_group_cnt将加一，切换到下一组16个out channel， 因此每个PE计算的out channel是不连续的，间隔为16。
+ 当算完一组16个out channel时，除了将och group cnt加一，进行下一组的计算，W-Bus需要将下一批weight预取到weight pad中数据用完的位置。
+ Bias 的数据可以复用weight的通路，利用PE中bias in与乘法器的数据打拍延迟
**TBD**

## PE控制器
### PE控制流程模型

```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Co; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Ho; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wo; ox += x){    // Output column tiling
        for(kz = 0; kz < Ci; kz += k){  // Inner tiling
          IBuf=IFMAP[i:i+b-1][kz:kz+k-1][oy:oy+y+Hk-1][ox:ox+x+Wk-1]
          WBuf=KERNEL[oz:oz+z-1][kz:kz+k-1][:Hk-1][:Wk-1]
          OUT[i:i+b-1][oz:oz+z-1][oy:oy+y-1][ox:ox+x-1] += IBuf conv WBuf
        }
      }
```

+ EasyNPU为了简洁的原则，固定k和z为16。也就是说每次都固定从Ifmap中取出16个Input Channel的数据，并计算出16个Output Channel的结果。
+ 对于某些简单的推理任务，例如串行的音频流数据，Batch Size通常可以直接取1。因此上面的卷积循环可以忽略最外层的Batch循环。

外层的四层循环我们将其交给Scheduler完成，PE控制器主要负责内层的循环，也就是计算下图所示的部分卷积：

此处设定如下卷积参数：
<center>

| Name    | Abbrev | Describe    | 
|:--|:--|:--|
| stride_h  | sh | 卷积步长(H方向)|    
| stride_w  | sw |卷积步长(W方向)|    
| padding_h  | ph | 卷积填充(H方向)|   
| padding_w  | pw | 卷积填充(W方向)|    
| dilation_h | dh | 卷积膨胀因子(H方向)|  
| dilation_w | dw |卷积膨胀因子(W方向)|    
</center>


对于一个部分卷积结果Ofmap[oz:oz+z-1][oy:oy+y-1][ox:ox+x-1], 可以计算其对应的输入Ifmap的相关参数为：

$$
(x' - (Wk + dw*(Wk-1))) // sw = x   \\
$$
可以得到：
$$
x' = sw * x +  (dw+1)*(Wk-1) + 1  \tag{1}
$$
同理：
$$
y' = sh * y +  (dh+1)*(Hk-1) + 1  \tag{2}
$$
公式1,2给出了分块卷积时的输入图大小。
输入图的导入交给Scheduler模块完成，因此PE控制器需要解决的问题是：
+ 给定一张输入图[x',y',k]，计算出输出图[x,y,z].

EasyNPU的假定输入图通过If_Bus已经分批送入了Ifmap_scratch_pad中，且k固定为16。在ifmap分批送入时，相应的weight也分批被送入了weight_scratch_pad。
以下图为例说明PE控制器控制PE进行一个普通卷积的过程。假设卷积的输入图大小为5\*5， 卷积核大小3\*3，步长为1, 输出通道z为4, 每个PE处理的输出通道数zs为2:

<center>
<img src="/docs/images/pe_ctrl.drawio.svg" width = "500" height = "900" alt="weight scratch pad"/>
</center>

1. **Pass 0**: Ifmap的第一个元素广播到PE中，与不同输出通道的卷积核的第一个元素在PE内进行计算，结果存在PE内部的Psum中。
2. **Pass 1-8**: 各个PE的Weight输入保持不变，变更Ifmap输入，依次计算各输出图的部分卷积。Pass 8结束后PE内实际存储了9\*2个元素，对应两张输出图，但输出图中的每一个元素仅仅是单次卷积计算中的一次乘累加结果。
3. **Pass 9**: 调度器在Pass 9之前需要导入第三和第四个输出通道的卷积核参数，然后Ifmap又回到第一个元素。另外，由于第一，二个输出通道的卷积核已经算完，可以预取下一批次的一，二通道卷积核进入Weight Pad。
4. **Pass 10-17**，计算过程与Pass 1-8相同，只是计算的通道不同。计算完后就完成了所有输出图的卷积乘累加的第一次部分结果。
5. **Pass n**: 后续的Pass实际就是在重复上面的0-17，区别在于Weight Pad中的数据在不断被替换，直到卷积核被完全覆盖。
6. 当计算完一张ifmap后，对应普通卷积来说还需要计算其余输入通道，此时需要将Ifmap Pad切换到下一个通道的Ifmap，再重复上述过程。
7. 对于具有逐通道计算特性的卷积，例如depthwise，pooling等操作，需要将ifmap Pad的输出方式改为多播，每个Pad连接一个PE。

对上述过程稍加拆解，即可发现PE控制器需要实现的就是将Weight scratch pad中的一组weight（16个）失效前所要完成的功能。也就是上面Pass0-8的过程。在这个过程中，需要控制的信号有：
<center>

| Name  | Width  | Function  |
|:--|:--|:--|
| Pe_ps_addr  |  6  | Psum Regfile addr  |
| if_hw_addr  |  6  | ifmap pad addr  |
| if_ch_addr  |  4  | ifmap pad input channel addr  |
| w_och_gcnt  |  4  | weight pad output channel group cnt  |

</center>

首先，计如下几个参数：
<center>

| Name  |  Function  |
|:--|:--|
| zs  |  每个pe计算的输出通道数  |
| zp  |  z/zs, 参与运算的pe个数，通常为16，除非Co<16，或者分组的最后一组z<16  |
| gp  |  卷积的group参数  |
| gc  |  卷积每个group包含的channel数  |

</center>

<center>
<img src="/docs/images/pe_pass_ctrl.drawio.svg" width = "600" height = "400" alt="ifmap ctrl"/>
</center>

PE控制器完成普通卷积的流程用伪代码表示如下：
```C++
for(kzi = 0; kzi < k; kzi ++)           // Inner input channel tiling
  for(hki = 0; hki < Hk; hki ++)        // Inner Kernel Row tiling 
    for(wki = 0; wki < Wk; wki ++)      // Inner Kernel Column tiling 
      
      for(ozi = 0; ozi < zs; ozi ++)        // Inner Output Channel tiling 
        for(oyi = 0; oyi < y; oyi ++)       // Inner Output Row tiling
          for(oxi = 0; oxi < x; oxi ++){    // Inner Output column tiling
            // Every PE's behavior is same
            PEs_ifmap_in=IF_PAD[kzi][sh*oyi][sw*oxi]
            PEs_weight_in=W_PAD[ozi]
            Psum_PADs[ozi][oyi][oxi] += PEs_ifmap_in * PEs_weight_in
      }
Psum_PADs[:z][:y][:x] transfer to DTCM
```
上面的循环中输出通道循环次数只有zs次，这是因为有zp(16)个PE，因此只需要循环一次就可以获得zp个输出，zs次循环就能算完z个输出通道。
### GroupConv的支持（TBD）
实际上，普通卷积和Depthwise卷积应该都是GroupConv的一个特例。普通卷积对应group=Ci, 而Depthwise卷积对应group=1。因此NPU应该实现更一般的GroupConv，通过指定Group参数来实现其他类型的卷积。
对Group的支持只需要将PE控制器伪代码最外层的k循环的上限换成gc即可。


### Scratch Pad的预取
对于逐通道的操作，上述流程代码仍然适用，只需要将最外层的k循环移除即可。
对于Weight Pad的预取，上文已经提到，在每次利用完一组zp(16)个输出通道的weight后就可以导入下一批次的weight了。
对于Ifmap Pad的预取，主要分两种情况：
1. 多播模式： 此时对应逐通道模式，每个pad的数据会同时输出给PE。在kernel Row的最后一次循环中，每次算完k（16）个ifmap可以依次覆盖k个通道数据到Ifmap Pad中。
2. 广播模式： 广播模式每次只有一个Pad连接到PE上，其他pad的数据则作为缓冲池保持静止，因此需要等到k循环的最后一次循环，也就是最有一个Pad接入PE计算时，算完一个Ifmap数据直接覆盖整个Ifmap对应位置的k（16）个数据。

上述预取操作均只对PE控制器可见（只有PE控制器知道内层循环进展到哪里），因此由PE控制器发出预取请求给调度器。

### 层融合
#### 硬件层融合
通常来说，卷积层后面会紧跟一个BN层或者Activation层，有时还会伴随一个Pooling层。
对于一个SubConv来说，输出图x\*y\*z求得后需要输出会DTCM，等待下一层计算时再被取出。而如果下一层是BN，激活或者池化层，实际上可以在算完一副SubConv后在PE内部完成上述层。

层融合的顺序可以是BN+ACT，也可以是ACT+BN,因此可以通过一个寄存器控制这两层的顺序，另一个2bit寄存器控制是否存在BN层和ACT层。
#### 软件层融合
实际上目前NN训练和推理引擎对层融合的支持已经不错了。例如在Pytorch中的ConvBNRelu层，可以直接把这三层合并为一层，相应的权重和bias也会做合并，硬件看到的实际上就是一个类卷积层。
在Pytorch导出模型到ONNX时，也会做上述图优化。最常见的就是把卷积后的BN层融入卷积中，这样只要网络中的BN之前都是卷积或全连接，导出ONNX后图中就不存在BN层，可以极大简化硬件实现难度。当然，需要在设计网络时就注意这些Tricks。
#### 融合层硬件实现
由于BN层可以通过软件优化到卷积中，因此硬件不做特殊处理，在实际硬件计算时可以进行融合层包括：激活层,池化层，reshape层，Elementwise操作层。
+ Pool层在PE内部的实现较为复杂，因此不予支持。而是导出到DTCM后当作一个新的等效卷积层进行计算。
+ 实现Activation层需要在PE内部维护一个线性插值的查找表，在这个融合的层开始之前需要从DTCM中读入。
+ Reshape算子本身不包含任何计算逻辑，而是将输入图按照一定顺序进行重组，因此可以在某一层计算完后，导出ofmap时进行。
+ Elementwise层需要接受两个等大小的Ifmap，进行逐元素计算。如果是逐元素乘，需要将psum通过feedback送回乘法器，另一张图从bias输入口进入乘法器另一端进行计算。如果是进行加法，则还需要对乘法器进行bypass。




## Scheduler调度器
PE控制器设计中提到，Scheduler调度器主要负责如下几个外层的循环：
```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Co; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Ho; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wo; ox += x){    // Output column tiling
        for(kz = 0; kz < Ci; kz += k){  // Inner tiling
          IBuf=IFMAP[i:i+b-1][kz:kz+k-1][oy:oy+y+Hk-1][ox:ox+x+Wk-1]
          WBuf=KERNEL[oz:oz+z-1][kz:kz+k-1][:Hk-1][:Wk-1]
          OUT[i:i+b-1][oz:oz+z-1][oy:oy+y-1][ox:ox+x-1] += IBuf conv WBuf
        }
      }
```
在设计调度器之前，需要首先明确的一点是Ifmap和Weight在 DTCM中是如何排布的。
由于本设计具有16个数据的输出并行度，因此考虑将ifmap和weight均按照16个输出通道为一组进行存放，具体如下：

<center>
<img src="/docs/images/data_dist.drawio.svg" width = "500" height = "800" alt="DTCM data allocate"/>
</center>

+ Fmap的存放按照[Hi,Wi,Ci]的矩阵形式存储，最内层存放通道维度。对通道维度进行折叠，每16个一组存放到一个DTCM地址，由于Fmap数据位宽是8bit，因此DTCM存储位宽为128bit。
+ Weight的存放按照[Ci,Hk,Wk,Co]的形式存放，最内层为输出通道维度。对输出通道维度进行折叠，每16个一组存放到一个DTCM地址，同样地，Weight DTCM存储位宽为128bit。
+ 如果按照16折叠的最后一组数据不到16个，则其余数据补零。



### Ifmap 调度器
首先可以根据输出图的大小[Wo,Ho]计算卷积Runtime时的输入图大小[Wi',Hi']:
$$
(Wi' + pw*2 - (Wk + dw*(Wk-1))) // sw = Wo \\
(Hi' + ph*2 - (Hk + dh*(Hk-1))) // sh = Ho 
$$
外层循环，也就是调度器中记录了当前subconv的输出子图在整张输出图中的位置(ox,oy), 再结合下面两个公式：
$$
x' = sw * x +  (dw+1)*(Wk-1) + 1  \\
y' = sh * y +  (dh+1)*(Hk-1) + 1  
$$
就可以获得该subconv所需要的输入子图信息。
实际上确定一张输入子图只需要子图左上角顶点的坐标(ixc,iyc)，以及子图的长宽x',y'即可。子图长宽根据上式已经得到，而顶点坐标的换算公式为：
$$
ixc = sw * ox \\
iyc = sh * oy 
$$
有了左上角顶点坐标和图的长宽，就可以导入Ifmap了。但是还有一个需要注意的问题，就是Ifmap的Padding问题。由于Padding的存在，在计算输出图外圈元素时会取到Padding的数据,因此需要判断所取坐标(ix,iy)是否满足：
$$
pw < ix < Wi' - pw ,\\
ph < iy < Hi' - ph 
$$
如果不满足，则表示索引的数据为Padding值，不需要从DTCM取数据，而是直接返回Padding值。另外，访问DTCM时的Ifmap坐标应该减去padding参数，也就是(ix-pw, iy-ph).
最终，Ifmap 调度器应该实现的功能如下伪代码所示：
```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Co; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Ho; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wo; ox += x){    // Output column tiling
        for(kz = 0; kz < Ci; kz += k)   // Input Channel tiling

          for(iyi = 0; iyi < y'; iyi += 1)      // Input subconv Row tiling
            for(ixi = 0; ixi < x'; ixi += 1){   // Input subconv Column tiling
              iy = sh * oy + iyi
              ix = sw * ox + ixi
              Ifmap_bus = FMAP_DTCM[i][iy][ix][kz:kz+k-1]
          }
```
### Ofmap 调度器
输出图调度器负责将PE阵列的计算结果送回DTCM存储器中。与Ifmap调度器不同的是，Ofmap的调度需要接收PE控制器中内层循环的信息：
```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Co; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Ho; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wo; ox += x){    // Output column tiling
        for(kz = 0; kz < Ci; kz += k)   // Input Channel tiling
          if(kz == Ci-1){
            oyi = PE_Ctrl_oyi
            oxi = PE_Ctrl_oxi
            ozi = PE_Ctrl_ozi  // iterator of zs tiling                     
            FMAP_DTCM[i][oy+oyi][ox+oxi][oz+ozi*zp:oz+(ozi+1)*zp-1] 
              = Ofmap_bus             
          }
```
Ifmap_bus和Ofmap_bus理论上是有可能同时工作的，为了复用同一块存储，EasyNPU将Ifmap和Ofmap Bus实现为同一条总线，内部进行简单的仲裁（总是让Ofmap的写请求胜出），从而简化硬件设计。

#### Reshape算子
Reshape算子不包含计算逻辑，但是会对数据的排列进行修改。对排列的修改需要在数据存放时对地址进行重新计算。由于重新计算后的地址很有可能与还未使用过的Ifmap数据冲突，因此在Reshape算子与其他层融合时，输出ofmap到DTCM中会经过一个地址转换，而这个转换需要保证不会覆盖掉还未使用的数据。
一种简单的办法是乒乓存储，即开辟两块存储区，一块负责输入，一块负责接受输出，之后不断调换两者的角色。但是这样的作法需要开辟的存储就是最大中间存储量的两倍。
一种折中方式是使用一块存储，为了让输入输出完全错开，输入从地址0开始向下写入，而输出数据则从最大地址开始向上写入。这样只要保证存储器每次都能容纳两层的中间结果即可。
这种方式换来的好处是:
1. 当存在reshape操作时，可以支持reshape与其他层的融合。
2. 当存在reshape操作时，减少了使用乒乓逻辑带来的额外SRAM外围电路开销。
3. 当不存在reshape操作时，中间结果存储的容量更大。

相应的代价是需要一定的地址解码逻辑。

对reshape操作进一步分析可知，一般reshape操作都是将某些维度进行对换，或者是将某一维度切分后拼接到另一个维度。对于维度对换，如果输入是4维Tensor，则最多有$A_4^4=24$种情况，只需要一个查找表将4维的迭代参数重排即可。
对于切分的情况,需要为每个维度分配一个切分参数和一个叠加参数。被切分的维度会被“摞到”被叠加的维度上。这个过程有点像摞麻将牌。例如有一堆麻将牌，长宽高分别为[6,4,2]。现在我们想要将其在长方向切分一半，在高度方向扩展一倍，也就是reshape为[3,4,6]。这一个过程其实就是把麻将牌在长度方向分成两份，在将第二份摞到第一份上。
上面的是将高维度的切分给低维度，直接切分即可。但是当低维度切分给高维度时，则不是简单的拼接。例如长宽高[2,4,6]，需要reshape为[4,4,3]，也就是将高方向切一半分给长度。此时的过程是先将其拦腰切一半得到两份，之后将上面那一份"插入"下面那一份中，而不是直接拿下来放在下面那堆牌旁边。

**特殊情况：**
当reshape之前的map需要进行skip处理，也就是需要先暂存一下时，我们便不能简单地将ofmap的地址修改为reshape之后的了。而是需要保留两份地址，一份是按照原来的顺序存放的地址，一份是reshape之后转义的地址。

### Weight 调度器
PE控制器完整地负责x\*y\*z大小的输出图计算，但是在计算过程中，weight和ifmap scratch pad都需要预取数据保证PE阵列能够满负荷运作。预取的时机在pe控制器中已经进行了说明。
对于Weight数据的调度，实际上PE控制器已经负责了大部分工作。PE控制器的内部循环可以覆盖k,Wk,Hk,z循环，需要Weight调度器负责的就是将z和k转换到Weight DTCM中，需要加上通道方向的历史数据(oz,kz）来索引DTCM中的Fmap和Weight，对应的控制伪代码如下：
```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Co; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Ho; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wo; ox += x)     // Output column tiling
        for(kz = 0; kz < Ci; kz += k){  // Input Channel tiling
            kxi = PE_Ctrl_kxi
            hki = PE_Ctrl_hki
            wki = PE_Ctrl_wki
            oyi = PE_Ctrl_oyi
            oxi = PE_Ctrl_oxi
            ozi = PE_Ctrl_ozi  // iterator of zs tiling                     
            weight_bus =
             Weight_DTCM[kz+kzi][hki][wki][oz+ozi*zp:oz+(ozi+1)*zp-1] 
        }   
```
## 总控制器


对于一次卷积映射，所需要确认的参数有：
<center>

| Name    | Abbrev |Width| Describe    | 
|:--|:--|:--|:--|
| y | - |6 |SubConv输出图高度|    
| x | - |6 |SubConv输出图宽度|    
| y' | - |6 |SubConv输入图高度|    
| x' | - |6 |SubConv输入图宽度|    
| Hk | - |8 |卷积核高度|    
| Wk | - |8 |卷积核宽度|   
| Ho | - |8 |输出图高度|    
| Wo | - |8 |输出图宽度| 
| Co | - |8 |输出通道数| 
| Ci | - |8 |输入通道数| 
| zs | - |6 |每个PE处理的输出通道数| 
| stride_h  | sh | 4 | 卷积步长(H方向)|    
| stride_w  | sw | 4 | 卷积步长(W方向)|    
| padding_h  | ph |4 |  卷积填充(H方向)|   
| padding_w  | pw |4 | 卷积填充(W方向)|    
| dilation_h | dh |4 | 卷积膨胀因子(H方向)|  
| dilation_w | dw |4 |卷积膨胀因子(W方向)| 
</center>

总共102bit数据。
除此之外，还需要将每一层的operator进行编码，各个op在EasyNPU中主要有两种实现方式：
<center>

| Name   | Describe    | 
|:--|:--|
| BasicConv | 卷积类，可以实现全连接|    
| ChannelWise | 逐层运算类，包括DepthWise, Pooling, BN, Tensor-Add, Tensor-Mul等|
| FusedLayer | 融合层，可以实现其他层和激活层的融合层|    

</center>

这两个操作的数据流基本是相同的，不同之处在于
1. 卷积的输入通道需要累加，对应通道Router采取的是广播方式；而逐通道计算的输入通道是多播到各个PE的，不需要在通道方向进行累加。
2. 逐通道计算不需要等所有输入通道数据都导入计算后才输出结果，而是每次遍历完一次卷积核大小就输出一次。

这里列出支持的op:

<center>

|Opcode| Name     |Category| Describe    | 
|:--|:--|:--|:--|
|000_000_00 | 普通卷积 | BasicConv | 普通卷积 |  
|000_000_00 | 全连接 | BasicConv | 全连接，等效为卷积（Hk=Wk=1)|    
|000_001_00 | 带relu的卷积 | BasicConv | 带relu的卷积 |    
|000_000_01 | DepthWise卷积 | ChannelWise | 逐通道卷积|    
|000_000_10 | Batchnorm | ChannelWise | BN层，等效逐通道卷积（Hk=Wk=1），需要bias接口|  
|000_001_10 |Relu | ChannelWise | relu激活层，等效逐通道卷积（Hk=Wk=1） |  
|000_010_10 |Activation | ChannelWise | 查表激活层，等效逐通道卷积（Hk=Wk=1），需要bias接口, |  
|000_011_10 |MaxPooling | ChannelWise | Pooling,等效逐通道卷积, 无Weight参数 |  
|000_100_10 |AvgPooling | ChannelWise | Pooling,等效逐通道卷积，有等效Weight参数|  
|000_101_10 |Tensor-Add | ChannelWise | 两个张量相加，等效逐通道卷积（Hk=Wk=1），需要bias接口|  
|000_110_10 |Tensor-Mul | ChannelWise | 两个张量相加，等效逐通道卷积（Hk=Wk=1），需要bias接口| 
|100_000_00 |Reshape    | Reshape     | Reshape操作 | 
|001\_???\_?? |Fused layer| Fused  | 指示该层与下一层进行融合 |  
|01?\_???\_?? |stored layer| Fused  | 指示该层需要缓存起来（跳远连接） |  


</center>

上表中比较特殊的是融合层和跳远连接层。对于融合bit位为高的层，需要将下一层的指令也读取出来。这样的层需要在卷积计算将要输出结果之前，额外再遍历一轮x,y,z循环，进行对应的激活/Element/Reshape操作，之后再输出结果。
+ Opcode中的前两bit编码了基本的操作形式，00表示卷积，01表示Depthwise卷积，10表示等效的逐通道操作。
+ 其中10编码的逐通道操作分为若干类，由bit2-4编码。

EasyNPU的控制流的粒度是非常粗的，直接以一层为一条指令，相比于CPU和GPU而言这么做的好处是可以减少编译器的设计难度和复杂度，缺点是单条指令长度需要操作的寄存器非常多。指令长度也较长（~128bit)。
EasyNPU的指令格式为：
<center>
<img src="/docs/images/wavedrom_opcode.png" alt="opcode"/>
</center>

整个EasyNPU的控制逻辑可以抽象为如下的伪代码：
```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Co; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Ho; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wo; ox += x)     // Output column tiling
        for(kz = 0; kz < Ci; kz += k){  // Input Channel tiling
          // Scheduler
          for(iyi = 0; iyi < y'; iyi += 1)        // Input subconv Row tiling
            for(ixi = 0; ixi < x'; ixi += 1){     // Input subconv Column tiling
              iy = sh * oy + iyi
              ix = sw * ox + ixi
              if(pw < ix < Wi' - pw && ph < iy < Hi' - ph)
                Ifmap_bus = FMAP_DTCM[i][iy][ix][kz:kz+k-1]
              else
                Ifmap_bus = Padding_value(0)
          // PE Ctrl
          for(kzi = 0; kzi < k; kzi ++)           // Inner input channel tiling
            for(hki = 0; hki < Hk; hki ++)        // Inner Kernel Row tiling 
              for(wki = 0; wki < Wk; wki ++)      // Inner Kernel Column tiling 
                
                for(fi=0; fi < fuse_n; fi ++)     // layer fusion loop
                  for(ozi = 0; ozi < zs; ozi ++)        // Inner Output Channel tiling 
                    for(oyi = 0; oyi < y; oyi ++)       // Inner Output Row tiling
                      for(oxi = 0; oxi < x; oxi ++){    // Inner Output column tiling
                        // Every PE's behavior is same
                        if(fi == 0){ // Conv/MLP
                          weight_bus = Weight_DTCM[kz+kzi][hki][wki][oz+ozi*zp:oz+(ozi+1)*zp-1] 

                          PEs_ifmap_in=IF_PAD[kzi][sh*oyi][sw*oxi]
                          PEs_weight_in=W_PAD[ozi]
                          Psum_PADs[ozi][oyi][oxi] += PEs_ifmap_in * PEs_weight_in
                        }
                        else{        // Fused BN or Act
                          weight_bus = BN or ACT weights or None
                          PEs_weight_in=W_PAD[ozi] or ACT_ROM or None
                          PEs_ifmap_in=Psum[ozi][oyi][oxi]
                          PEs_bias_in = Bias_PAD[ozi] or ACT_ROM or Another-DTCM
                          Psum_PADs[ozi][oyi][oxi] = PEs_ifmap_in * PEs_weight_in + PEs_bias_in
                        }

                        if((kz == Ci-1 && BasicConv_mode) || (hki == Hk-1 && wki == Wk-1 && ChannelWise_mode)){
                          if(fi == fuse_n-1){
                            Ofmap_bus = Psum_PADs[ozi][oyi][oxi]
                            FMAP_DTCM[i][oy+oyi][ox+oxi][oz+ozi*zp:oz+(ozi+1)*zp-1] = Ofmap_bus 
                          }
                        }
                }
        }   
```

特别地，为了适配融合层，在PE控制器内部需要增加一个融合层的Loop，其大小受融合层包含的层数决定。需要注意的是，当融合层包含Tensor操作时，需要从另一个DTCM中读取对应位置的数据放到PE的bias in接口，而读取DTCM数据的地址实际就是Ofmap Bus输出的地址，所以这种情况需要将bias接口接入DTCM读总线。

总控制器负责从ITCM中取出指令，并对其进行解码后赋值Scheduler和PE控制器所需的寄存器。因此总控制器负责更宏观的控制（层级别）。

## 存储
Ifmap_bus和Ofmap_bus理论上是有可能同时工作的, 如果追求高带宽，可以设置乒乓两个DTCM，一个负责读一个负责写，实现Ifmap和Ofmap能够同时读写。但是代价较高（两倍存储）。
+ 事实上，如果是从通用性角度出发，应该设置乒乓DTCM，因为上面的循环中输出通道实际也是分块计算的，也就是说算完一组z通道的Ofmap后，还有其他组的Ofmap，而这些Ofmap的计算也需要复用同样的Ifmap，如果不对Ifmap进行备份，而是直接用新的Ofmap覆盖，那么剩下的Ofmap计算就丢失了Ifmap信息，这显然是无法接受的。
+ 但是为了节省硬件开销以及功耗，EasyNPU假定:**z = Co**, 也就是说输出通道只映射一次，最大限度地将Ifmap进行重用。而代价是PE阵列需要完整地容纳所有输出通道，这就对部署的网络做了一个限定，每个PE中的Psum Pad容量有限，如果网络的通道数较大，每个PE计算的输出通道数zs就会较大，也限制了PE计算的Subconv的大小。
+ 此外，很多网络都包含跳远连接，当一个层需要跳跃连接到另外一个层时，该层不能被下一层覆盖，因此需要额外再开辟一块DTCM用来存储这部分数据。
+ EasyNPU在上述几点设计难点上做了取舍，**保留两块DTCM，一块用来进行正常的推理，并且Ofmap和Ifmap的Bus复用同一条。另一块DTCM用来做跳远连接所需的备份存储**。


+ 对于魔改的BC-resnet来说，最大的层是第一层卷积之后，大小为[16,20,61], 数据位宽为8的话就有20KB的大小。
+ 由于很多网络结构都包含跳远连接，所以最好做一个pingpang buffer，有跳远连接时将输出层存在另一块SRAM中，这样输入层就留在了原先的SRAM中，后面跳远链接就可以获取这部分数据。因此中间层存储至少要20KB + 20KB = 40KB。
+ 权重，包括BN的mul+bias，总共约24KB,


## TODO
- [ ] 扩展PE阵列，考虑将单个PE完成一张x*y大小的输出图改成完成部分，例如设置4行PE阵列，将x\*y大小的图分成四份给四个PE，代价是ifmap pad需要四份译码逻辑。（因为每行PE所需的ifmap数据不同）  