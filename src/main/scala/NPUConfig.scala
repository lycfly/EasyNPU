case class NPUConfig(
    // PE unit config
                   PE_WEIGHT_WD: Int = 8,
                   PE_FMAP_WD:  Int = 8,
                   PE_BIAS_WD:   Int = 32,
                   PE_SCALE_WD:  Int = 16,
                   PE_PSUM_WD :  Int = 32,
                   PE_PSUM_NUM:  Int = 128,
                   PE_USE_BOOTH: Boolean = false,
                   PE_MUL_Vender: Mulvendor = SimpleMulVendor,
                   SizePCMin: Array[Int] = Array(1,16,15),
                   SizeFFTin: Array[Int] = Array(1,20,15),
                   SizePOWin: Array[Int] = Array(1,20,15)

)