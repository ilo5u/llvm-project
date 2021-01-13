# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+ygjk %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+ygjk %s \
# RUN:        | llvm-objdump -d --mattr=+ygjk - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+ygjk %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

ygjkexecu t0, t1, t2
# CHECK-INST: ygjkexecu t0, t1, t2
# CHECK-ENCODING: [0x8B,0x72,0x73,0x00]
# CHECK-ERROR: instruction requires the following: 'YGJK' (YGJK RoCC Extended Instructions)
# CHECK-UNKNOWN: 8B 72 73 00 <unknown>

ygjkquiry t0
# CHECK-INST: ygjkquiry t0
# CHECK-ENCODING: [0x8B,0x72,0x00,0x02]
# CHECK-ERROR: instruction requires the following: 'YGJK' (YGJK RoCC Extended Instructions)
# CHECK-UNKNOWN: 8B 72 00 02 <unknown>