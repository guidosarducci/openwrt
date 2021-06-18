ARCH:=mips
CPU_TYPE:=mips32r6
SUBTARGET:=be32r6
BOARDNAME:=Big Endian (32-bit R6)

define Target/Description
	Build BE firmware images for MIPS Malta CoreLV board running in
	32-bit big-endian mode using MIPS R6 ISA.
endef
