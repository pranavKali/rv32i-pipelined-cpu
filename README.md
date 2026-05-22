# Single-Cycle RISC-V CPU

Single-cycle RISC-V CPU implemented in SystemVerilog.

---

## Current Progress

- [x] 32-bit ALU
- [ ] Register File
- [ ] Immediate Generator
- [ ] Control Unit
- [ ] Datapath
- [ ] Top-Level CPU

---

## ALU

Implemented a 32-bit ALU supporting:

- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL

The ALU was verified using a self-checking SystemVerilog testbench in ModelSim.

---

## Simulation Results

Simulation screenshots and waveform captures are located in the `docs/` directory.

Files included:
- `alu_waveform.png`
- `alu_pass_transcript.png`

---

## Tools Used

- SystemVerilog
- ModelSim Intel FPGA Edition
- Git
- GitHub
- VS Code