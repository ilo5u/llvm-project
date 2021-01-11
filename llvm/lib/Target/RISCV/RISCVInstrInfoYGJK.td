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

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
// op rd, rs1, rs2
class YGJKRoCC<RISCVYGJKFunct funct, RISCVYGJKOpcode opcode, bits<3> x, string opcodestr>
    : RVInstYGJK<funct, opcode, x, (outs GPR:$rd),
                    (ins GPR:$rs2, GPR:$rs1),
                    opcodestr, "$rd, $rs1, $rs2">;
} // hasSideEffects = 0, mayLoad = 0, mayStore = 0

//===----------------------------------------------------------------------===//
// Combination of instruction classes.
// Use these multiclasses to define instructions more easily.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

let Predicates = [HasStdExtYGJK] in {
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
def YGJKSTART : RVInstYGJK<FUNCTSTART, OPSTART, 0b111, "ygjkstart">;
def YGJKQUIRY : RVInstYGJK<FUNCTQUIRY, OPQUIRY, 0b100, "ygjkquiry">;
}
} // Predicates = [HasStdExtYGJK]