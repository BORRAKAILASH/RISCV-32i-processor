RISCV-32i-processor
This project presents the design and implementation of a 32-bit RISC-V RV32I single-cycle processor using Verilog Hardware Description Language (HDL). The processor follows the open-standard RISC-V Instruction Set Architecture (ISA) and supports arithmetic, logical, memory access, and branch instructions. 

The design demonstrates the complete datapath including:
a)Instruction Fetch
b)Instruction Decode
c)Execute
d)Memory Access
e)Write Back
The processor has been functionally verified using ModelSim.

It Support Instruction Set operations such as: (RV32I Base)
a)Arithmetic & Logical: ADD,SUB,ADDI,AND,OR,XOR,SLL,SRL,SRA.
b)Memory Operations: LW (Load Word),SW (Store Word).
c)Branch: BEQ (Branch if Equal).

The processor follows a single-cycle architecture, meaning each instruction completes in one clock cycle. Major Modules in this processor are:
1)Program Counter (PC)
2)Instruction Memory
3)Control Unit
4)Register File (32 × 32-bit)
5)Immediate Generator
6)ALU Control
7)Arithmetic Logic Unit (ALU)
8)Data Memory
9)Writeback Multiplexer
10)Branch & Next PC Logic
