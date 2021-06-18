ARCH:=mips64
CPU_TYPE:=mips64r6
SUBTARGET:=be64r6
FEATURES+=source-only
BOARDNAME:=Big Endian (64-bits R6)

define Target/Description
	Build BE firmware images for MIPS Malta CoreLV board running in
	64-bit big-endian mode using MIPS R6 ISA.
endef
