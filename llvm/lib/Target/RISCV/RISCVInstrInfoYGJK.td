//===-- RISCVInstrInfoYGJK.td - RISC-V 'YGJK' extended RoCC instructions -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// This file describes the RISC-V instructions from the standard YGJK RoCC extension
/// Reference to RISCVInstrInfoV.td
///
//===----------------------------------------------------------------------===//

include "RISCVInstrFormatsYGJK.td"

//===----------------------------------------------------------------------===//
// Operand and SDNode transformation definitions.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction class templates
//===----------------------------------------------------------------------===//

// Pattern used for Load/Store
// If not, set the following params exactly
// let hasSideEffects = 0, mayStore = 0, mayLoad = 0 in {
// op rd, rs1, rs2
class YGJKRoCCWithInsII<RISCVYGJKFunct funct, RISCVYGJKOpcode opcode, bits<3> x, string opcodestr>
    : RVInstYGJKWithIns<funct, opcode, x, (outs GPR:$rd),
                    (ins GPR:$rs1, GPR:$rs2),
                    [(set GPR:$rd, (int_riscv_ygjk_rrrii GPR:$rs1, GPR:$rs2))],
                    opcodestr, "$rd, $rs1, $rs2">;

class YGJKRoCCWithoutIns<RISCVYGJKFunct funct, RISCVYGJKOpcode opcode, bits<3> x, string opcodestr>
    : RVInstYGJKWithoutIns<funct, opcode, x, (outs GPR:$rd),
                    (ins),
                    [(set GPR:$rd, (int_riscv_ygjk_rrr))],
                    opcodestr, "$rd">;

class YGJKRoCCWithInsPP<RISCVYGJKFunct funct, RISCVYGJKOpcode opcode, bits<3> x, string opcodestr>
    : RVInstYGJKWithIns<funct, opcode, x, (outs GPR:$rd),
                    (ins GPR:$rs1, GPR:$rs2),
                    [(set GPR:$rd, (int_riscv_ygjk_rrrpp GPR:$rs1, GPR:$rs2))],
                    opcodestr, "$rd, $rs1, $rs2">;
// }

//===----------------------------------------------------------------------===//
// Combination of instruction classes.
// Use these multiclasses to define instructions more easily.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// Predicates definition in RISCVSubtarget.h
let Predicates = [HasStdExtYGJK] in {
// let hasSideEffects = 0, mayStore = 0, mayLoad = 0 in {
def YGJKSTART : YGJKRoCCWithInsII<FUNCTWithIns, OPEXECU, 0b111, "ygjkstart">;
def YGJKEXECU : YGJKRoCCWithInsPP<FUNCTWithIns, OPEXECU, 0b111, "ygjkexecu">;
def YGJKQUIRY : YGJKRoCCWithoutIns<FUNCTWithoutIns, OPQUIRY, 0b111, "ygjkquiry">;
// }
} // Predicates = [HasStdExtYGJK]