import spinal.core._
import spinal.lib._
import breeze.numerics.log2

case class NPUConfig(
    // PE unit config
                PE_WEIGHT_WD: Int = 8,
                PE_FMAP_WD:  Int = 8,
                PE_BIAS_WD:   Int = 32,
                PE_PSUM_WD :  Int = 32,
                PE_PSUM_NUM:  Int = 128,
                PE_USE_BOOTH: Boolean = true,
                PE_MUL_Vender: Mulvendor = SimpleMulVendor,   //SimpleMulVendor, MultiplierIPVendor
    // PE array config
                ARRAY_COL_NUM: Int = 16,
    // IFmap scratch pad config
                IFSCP_BUS_WD: Int = 128,
                IFSCP_SIZE:   Int = 64,
    // Weight scratch pad config
                WESCP_BUS_WD: Int = 128,
                WESCP_SIZE:   Int = 16,

    // Flow params config
                MAX_BATCHSIZE : Int = 256,
                MAX_HEIGHT:     Int = 256,
                MAX_WIDTH :     Int = 256,
                MAX_CHANNEL:    Int = 256,
                MAX_KERNEL_H :  Int = 256,
                MAX_KERNEL_W :  Int = 256,

                MAX_SUB_HEIGHT: Int = 64,
                MAX_SUB_WIDTH: Int = 64,
                MAX_SUB_OCH: Int = 64,
                MAX_STRIDE: Int = 16,
                MAX_PADDING: Int = 16,
                MAX_DILATION: Int = 16,
                SizePOWin: Array[Int] = Array(1,20,15)

){
    val PE_SCALE_WD:  Int = log2Up(PE_BIAS_WD)
    val IFSCP_ADDRWD: Int = log2Up(IFSCP_SIZE)
    val WESCP_ADDRWD: Int = log2Up(WESCP_SIZE)

    val BATCH_WD :    Int = log2Up(MAX_BATCHSIZE)
    val HEIGHT_WD :   Int = log2Up(MAX_HEIGHT)
    val WIDTH_WD :    Int = log2Up(MAX_WIDTH)
    val KERNEL_H_WD : Int = log2Up(MAX_KERNEL_H)
    val KERNEL_W_WD : Int = log2Up(MAX_KERNEL_W)
    val CHANNEL_WD:   Int = log2Up(MAX_CHANNEL)

    val SUBH_WD:      Int = log2Up(MAX_SUB_HEIGHT)  
    val SUBW_WD:      Int = log2Up(MAX_SUB_WIDTH)  
    val SUBOCH_WD:    Int = log2Up(MAX_SUB_OCH)  
    val STRIDE_WD:    Int = log2Up(MAX_STRIDE)  
    val PADDING_WD:   Int = log2Up(MAX_PADDING)  
    val DILATION_WD:  Int = log2Up(MAX_DILATION) 
}