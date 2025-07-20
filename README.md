# Custom-Processor
A modular 8-bit processor in Verilog, supporting several instructions including arithmetic, logic, branch, and return. Features include ALU, instruction decoder, register file, and program counter. Fully testbench-validated with waveform analysis. Ideal for learning custom CPU architecture and control flow


## Components

- ALU with CB and EXT flag support
- Instruction Decoder for control signal generation
- Register File for data storage
- Program Counter with branch/return support
- Instruction Memory with customizable flow

## Folder Structure

```
Custom-Processor/       # Verilog modules and testbench and waveforms
│   ├── alu.v
│   ├── register_file.v
│   ├── program_counter.v
│   ├── instruction_decoder.v
│   ├── instruction_memory.v
│   └── tiny_processor.v
│   └── tiny_processor_tb.v
│   └── tiny_processor_tb.vcd
```
# Navigate to simulation folder
cd sim

# Compile using Icarus Verilog
iverilog -o processor_tb tiny_processor_tb.v ../rtl/*.v

# Run the simulation
vvp processor_tb

# View waveform output
gtkwave tiny_processor_tb.vcd

```

## Highlights

- Testbench-driven design with VCD output
- Verifies MOV, ADD, SUB, XOR, BRANCH, RET, HALT, etc.
- Ideal for learning and customizing processor behavior
- Demonstrates hardware-software co-design principles

---

Created with precision and curiosity by [Priyanshi Shah](https://github.com/Priyanshi1947)
```



