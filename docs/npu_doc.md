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
<img src="/docs/images/PE.drawio.svg" width = "500" height = "400" alt="PE结构"/>
</center>

PE单元只负责实现基本的运算，有如下控制信号负责控制PE的行为，进而组合成需要的计算功能:

<center>

| Name  | Width  | Function  |
|:--|:--|:--|
| Pe_ps_addr  | 6  | Psum Regfile addr  |
| Pe_ps_outer_en  | 1  | 外部Psum使能, 用于累加Bias |
| Pe_ps_back_en  | 1  | Psum结果回环使能，控制Psum经定点化后是否送到到乘法器输入 |
| Pe_ps_fix_typ  | ?  | Psum定点化类型选择，当Pe_ps_back_en有效时得到的乘加结果可选不同的定点化参数  |
| Pe_maxpool_en  |  1 | Maxpool模式使能开关  |
</center>

### 卷积算子
+ **Pe_ps_addr**信号选择Psum输出到对应的RegFile地址。
+ **Pe_ps_outer_en**,**Pe_ps_back_en**,**Pe_ps_fix_typ**均保持默认值（0）。

### 全连接算子
+ **Pe_ps_addr**信号选择Psum输出到对应的RegFile地址。
+ **Pe_ps_outer_en**,**Pe_ps_back_en**,**Pe_ps_fix_typ**均保持默认值（0）。
  
### BN算子
  BN算子用于计算BatchNormal操作。BN一般都位于卷积算子之后，因此可以直接对PE内部卷积计算完成的Psum进行BN操作，过程如下：
1. **Pe_ps_addr**信号选择Psum对应的RegFile地址。
2. 配置**Pe_ps_outer_en** = 1, 选择加法器一端输入为pe_bias_in。
3. 配置**Pe_ps_fix_typ**，选择BN输入数据的量化参数。
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
2. **Pe_ps_outer_en，Pe_ps_fix_typ** 保持默认值0。
3. 配置**Pe_ps_back_en**=1, 选择乘法器一端输入为定点量化之后的Psum。
4. pe_weight_in端口输入数据为short cut的乘数系数（如果需要的话）。

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

## SIMD PE控制器

```C++
for(i = 0; i < B; i += b)               // Batch tiling
  for(oz = 0; oz < Wo; oz += z)         // Output Channel tiling
    for(oy = 0; oy < Wy; oy += y)       // Output Row tiling
      for(ox = 0; ox < Wx; ox += x){    // Output column tiling
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

首先可以根据输出图的大小[Wo,Ho]计算卷积Runtime时的输入图大小[Wi',Hi']:
$$
(Wi' + pw*2 - (Wk + dw*(Wk-1))) // sw = Wo \\
(Hi' + ph*2 - (Hk + dh*(Hk-1))) // sh = Ho 
$$
对于一个部分卷积结果Ofmap[oz:oz+z-1][oy:oy+y-1][ox:ox+x-1], 可以计算其对应的输入Ifmap的相关参数为：

$$
(x' - (Wk + dw*(Wk-1))) // sw = x   \\
$$
可以得到：
$$
x' = sw * x +  (dw+1）*(Wk-1) + 1  \tag{1}
$$
同理：
$$
y' = sh * y +  (dh+1）*(Hk-1) + 1  \tag{2}
$$
公式1,2给出了分块卷积时的输入图大小。

## 存储

+ 对于魔改的BC-resnet来说，最大的层是第一层卷积之后，大小为[16,20,61], 数据位宽为8的话就有20KB的大小。
+ 由于很多网络结构都包含跳远连接，所以最好做一个pingpang buffer，有跳远连接时将输出层存在另一块SRAM中，这样输入层就留在了原先的SRAM中，后面跳远链接就可以获取这部分数据。因此中间层存储至少要20KB + 20KB = 40KB。
+ 权重，包括BN的mul+bias，总共约24KB,


