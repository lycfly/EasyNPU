import spinal.core._
import spinal.lib._
import breeze.numerics.log2

case class NPUConfig(
    // Sram config
                WDTCM_SIZE: Int = 256,
                WDTCM_WD:   Int = 128,

                FDTCM_SIZE: Int = 400,
                FDTCM_WD:   Int = 128,
    // PE unit config
                PE_WEIGHT_WD: Int = 8,
                PE_FMAP_WD:  Int = 8,
                PE_BIAS_WD:   Int = 32,
                PE_PSUM_WD :  Int = 32,
                PE_PSUM_NUM:  Int = 128,
                PE_SCALE_WD:  Int = 8,
                PE_USE_BOOTH: Boolean = false,
                PE_MUL_Vender: Mulvendor = SimpleMulVendor,   //SimpleMulVendor, MultiplierIPVendor
    // PE array config
                ARRAY_COL_NUM: Int = 16,
                CLUSTER_LINE_NUM: Int = 4,   
    // IFmap scratch pad config
                IFSCP_SIZE:   Int = 64,
    // Weight scratch pad config
                WESCP_SIZE:   Int = 16,
                SCALE_SIZE:   Int = 16,
    // Flow params config
                MAX_BATCHSIZE : Int = 256,
                MAX_HEIGHT:     Int = 256,
                MAX_WIDTH :     Int = 256,
                MAX_CHANNEL:    Int = 256,
                MAX_KERNEL_H :  Int = 256,
                MAX_KERNEL_W :  Int = 256,

                MAX_STRIDE: Int = 16,
                MAX_PADDING: Int = 16,
                MAX_DILATION: Int = 16,
                SizePOWin: Array[Int] = Array(1,20,15)

){
    val WDTCM_ADDRWD : Int = log2Up(WDTCM_SIZE)
    val FDTCM_ADDRWD : Int = log2Up(FDTCM_SIZE)
    val IFSCP_BUS_WD: Int = FDTCM_WD
    val WESCP_BUS_WD: Int = WDTCM_WD

    val BIAS_BYTE_NUM : Int = (PE_BIAS_WD/PE_WEIGHT_WD).toInt
    val PE_PSUM_ADDRWD: Int = log2Up(PE_PSUM_NUM)
    val IFSCP_ADDRWD: Int = log2Up(IFSCP_SIZE)
    val WESCP_ADDRWD: Int = log2Up(WESCP_SIZE)

    val BATCH_WD :    Int = log2Up(MAX_BATCHSIZE)
    val HEIGHT_WD :   Int = log2Up(MAX_HEIGHT)
    val WIDTH_WD :    Int = log2Up(MAX_WIDTH)
    val KERNEL_H_WD : Int = log2Up(MAX_KERNEL_H)
    val KERNEL_W_WD : Int = log2Up(MAX_KERNEL_W)
    val CHANNEL_WD:   Int = log2Up(MAX_CHANNEL)

    val MAX_SUB_HEIGHT: Int = IFSCP_SIZE
    val MAX_SUB_WIDTH:  Int = IFSCP_SIZE
    val MAX_SUB_OCH:    Int = WESCP_SIZE
    val MAX_SUB_ICH:    Int = ARRAY_COL_NUM
    val SUBH_WD:      Int = log2Up(MAX_SUB_HEIGHT)  
    val SUBW_WD:      Int = log2Up(MAX_SUB_WIDTH)  
    val SUBOCH_WD:    Int = log2Up(MAX_SUB_OCH)  
    val SUBICH_WD:    Int = log2Up(MAX_SUB_ICH)
    val STRIDE_WD:    Int = log2Up(MAX_STRIDE)  
    val PADDING_WD:   Int = log2Up(MAX_PADDING)  
    val DILATION_WD:  Int = log2Up(MAX_DILATION) 
}