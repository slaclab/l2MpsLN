addBsa("C0_I0",       "int32")
addBsa("C1_I0",       "int32")
addBsa("C2_I0",       "int32")
addBsa("C3_I0",       "int32")
addBsa("C4_I0",       "int32")
addBsa("C5_I0",       "int32")

bsaAsynDriverConfigure("bsaPort", "mmio/AmcCarrierCore/AmcCarrierBsa","strm/AmcCarrierDRAM/dram")
listBsa()
bsssAssociateBsaChannels("bsaPort")
bsssAsynDriverConfigure("bsssPort", "mmio/AmcCarrierCore/AmcCarrierBsa/Bsss")
dbLoadRecords("db/bsssCtrl.db", "DEV=${TPR},PORT=bsssPort")