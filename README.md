# 4-bit Counter for TinyTapeout

A minimal 4-bit synchronous counter designed for the TinyTapeout shuttle program.  
This project demonstrates a complete digital design flow from Verilog to GDSII-ready layout.

 📌 Project Overview



- **Function**: 4-bit counter with asynchronous active-low reset (`rst_n`)
- **Technology**: SkyWater 130nm (via TinyTapeout shuttle)
- **Area**: ~0.01 mm² (fits in 1 shuttle tile)
- **Cell count**: 10 standard cells after synthesis
- **Clock frequency**: Tested up to 50 MHz in simulation

 🔌 Pinout



| Pin | Direction | Description |
|-----|-----------|-------------|
| `clk` | Input | Clock signal (10–50 MHz recommended) |
| `rst_n` | Input | Active-low asynchronous reset |
| `io_out[3:0]` | Output | Counter value (bits 3..0) |
| `io_out[7:4]` | Output | Unused (tied to 0) |
| `io_in[7:0]` | Input | Unused (high-Z) |



 🧪 Verification


Simulation (using Icarus Verilog)

iverilog src/counter.v rtl/user_project_wrapper.v tb_counter.v -o sim

vvp sim

gtkwave counter.vcd

View waveform

Synthesis (Yosys via OpenLane container)

docker run --rm -v $(pwd):/work efabless/openlane:rc6 sh -c "

  cd /work &&

  yosys -p 'read_verilog src/counter.v; read_verilog rtl/user_project_wrapper.v; synth -top user_project_wrapper; stat'

"



Expected result: 10 cells (4× DFF with async reset + 6× logic gates).


📦 Shuttle Submission

Shuttle: sky130 (ChipFoundry)
Design type: digital
Tiles required: 1
Author: Galayuda
Repository: https://github.com/Galayuda/tt-counter

📚 Documentation

Full pin description and usage examples:

→ docs/datasheet.md

📄 License

Apache License 2.0 — see LICENSE


