# Single Cycle RISC-V CPU

A single-cycle RISC-V CPU implemented in SystemVerilog and verified using ModelSim.

## Current Progress

- [x] ALU
- [x] Register File
- [x] Immediate Generator
- [ ] Control Unit
- [ ] Program Counter
- [ ] Instruction Memory
- [ ] Data Memory
- [ ] Datapath
- [ ] Top-Level CPU Integration

---

# ALU

## Features

- ADD
- SUB
- AND
- OR
- XOR
- Shift Left Logical (SLL)
- Shift Right Logical (SRL)

## Files

- `src/alu.sv`
- `tb/alu_tb.sv`

## Simulation Results

### Transcript

![ALU Transcript](docs/alu_pass_transcript.png)

### Waveform

![ALU Waveform](docs/alu_waveform.png)

---

# Register File

## Features

- 32 general-purpose registers
- Dual read ports
- Single write port
- Register x0 hardwired to zero

## Files

- `src/reg_file.sv`
- `tb/reg_file_tb.sv`

## Simulation Results

### Transcript

![Register File Transcript](docs/reg_file_pass_transcript.png)

### Waveform

![Register File Waveform](docs/reg_file_waveform.png)

---

# Immediate Generator

## Features

- I-type immediate extraction
- Load immediate extraction
- Store immediate extraction
- Branch immediate extraction
- Sign extension to 32 bits

## Files

- `src/imm_gen.sv`
- `tb/imm_gen_tb.sv`

## Simulation Results

### Transcript

![Immediate Generator Transcript](docs/imm_gen_pass_transcript.png)

### Waveform

![Immediate Generator Waveform](docs/imm_gen_waveform.png)

---

## Tools Used

- SystemVerilog
- ModelSim Intel FPGA Edition
- Git
- GitHub
- VS Code