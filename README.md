# 16-Bit ALU in VHDL

This repository contains the VHDL design for a 16-bit Arithmetic Logic Unit (ALU). The design utilizes a Structural Architecture, dividing the ALU into four distinct functional components to distribute operations efficiently. The entire unit is controlled by a 4-bit selector signal.

## Architecture


The design consists of a top-level `ALU` entity that interconnects four main sub-components:

1. **`partA` (Arithmetic Unit):**
   - Built using a Ripple Carry Adder and a custom `my_FA` (Full Adder) component.
   - Handles arithmetic operations such as addition, subtraction, and operations with carry.
2. **`partB` (Logic Unit):**
   - Performs basic bitwise logical operations: `AND`, `OR`, `XOR`, and `NOT`.
3. **`partC` (Shift Right Unit):**
   - Handles right shift operations: Logical Shift Right (LSR), Rotate Right (ROR), Rotate Right through Carry (RRC), and Arithmetic Shift Right (ASR).
4. **`partD` (Shift Left Unit):**
   - Handles left shift operations: Logical Shift Left (LSL), Rotate Left (ROL), Rotate Left through Carry (RLC), and setting the output to zero.

## Ports Description

| Port Name | Direction | Size | Description |
| :--- | :--- | :--- | :--- |
| `A` | Input | 16 bits | First operand |
| `B` | Input | 16 bits | Second operand |
| `Cin` | Input | 1 bit | Carry-in signal |
| `S` | Input | 4 bits | Selector signal to control the operation |
| `F` | Output | 16 bits | Final result output |
| `Cout` | Output | 1 bit | Carry-out signal |

## Control Signal S(3 downto 0)

The 4-bit selector signal `S` dictates the behavior of the ALU:

- **Upper Bits `S(3)` and `S(2)`:** Determine which sub-component is routed to the output.
  - `00` -> Selects `partA` (Arithmetic)
  - `01` -> Selects `partB` (Logic)
  - `10` -> Selects `partC` (Shift Right)
  - `11` -> Selects `partD` (Shift Left)
- **Lower Bits `S(1)` and `S(0)`:** Determine the specific operation to be executed within the selected sub-component.

## Usage and Simulation

This code is written using standard `IEEE.STD_LOGIC_1164` libraries. It can be simulated and synthesized using any standard VHDL development environment, such as:

- ModelSim / QuestaSim
- Xilinx Vivado
- GHDL / GTKWave

**Steps to run:**
1. Create a new project in your preferred EDA tool.
2. Add all the provided VHDL files to the project. 
3. Ensure the compilation order is correct: compile the custom full adder (`my_FA`) and the sub-components (`partA`, `partB`, `partC`, `partD`) before compiling the top-level `ALU` file.
4. A `simulate.do` script is provided to automate the simulation process. You can run this script in ModelSim/QuestaSim to automatically compile the files, force input stimuli, and generate the waveform for visual verification, eliminating the need for a separate VHDL testbench.
# "simulate.do" waveform : 

**testing all operations :**

<img width="1918" height="747" alt="image" src="https://github.com/user-attachments/assets/879e56a0-e83a-4d52-8f45-b275ddec0e57" />
