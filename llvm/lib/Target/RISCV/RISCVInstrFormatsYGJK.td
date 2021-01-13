//===-- RISCVInstrFormatsYGJK.td - RISCV YGJK RoCC Instruction Formats --*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//  This file describes the RISC-V YGJK RoCC extension instruction formats.
//  Reference to RISCVInstrFormatsV.td
//
//===----------------------------------------------------------------------===//

class RISCVYGJKFunct<bits<7> funct> {
    bits<7> Value = funct;
}
def FUNCTWithIns : RISCVYGJKFunct<0b0000000>;
def FUNCTWithoutIns : RISCVYGJKFunct<0b0000001>;

class RISCVYGJKOpcode<bits<7> opcode> {
    bits<7> Value = opcode;
}
def OPEXECU : RISCVYGJKOpcode<0b0001011>;
def OPQUIRY : RISCVYGJKOpcode<0b0001011>;

class RVInstYGJKWithIns<RISCVYGJKFunct funct, RISCVYGJKOpcode opcode, bits<3> x, dag outs,
              dag ins, list<dag> pattern, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, pattern, InstFormatYGJK> {
    bits<5> rs2;
    bits<5> rs1;
    bits<5> rd;

    let Inst{31-25} = funct.Value;
    let Inst{24-20} = rs2;
    let Inst{19-15} = rs1;
    let Inst{14-12} = x;
    let Inst{11-7} = rd;
    let Inst{6-0} = opcode.Value;
}

class RVInstYGJKWithoutIns<RISCVYGJKFunct funct, RISCVYGJKOpcode opcode, bits<3> x, dag outs,
                dag ins, list<dag> pattern, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, pattern, InstFormatYGJK> {
    bits<5> rd;

    let Inst{31-25} = funct.Value;
    let Inst{24-20} = 0b00000;
    let Inst{19-15} = 0b00000;
    let Inst{14-12} = x;
    let Inst{11-7} = rd;
    let Inst{6-0} = opcode.Value;
}