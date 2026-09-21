# 1. Create the work library
vlib work
vmap work work

# 2. Compile Lab 1 VHDL files
vcom partB.vhd
vcom partC.vhd
vcom partD.vhd
vcom ALU.vhd

# 3. Start the simulation
vsim work.ALU

# 4. Add waves
add wave -position insertpoint sim:/ALU/*

# Initial Default Signals for Lab 1 Table
force -freeze sim:/ALU/A 16'hF00F 0
force -freeze sim:/ALU/B 16'h000A 0
force -freeze sim:/ALU/Cin 0 0

# =========================================================
# Part B: Logic Operations (4 Operations)
# =========================================================

# 1. F = A AND B
force -freeze sim:/ALU/S 4'b0100 0
run 10 ns

# 2. F = A OR B
force -freeze sim:/ALU/S 4'b0101 0
run 10 ns

# 3. F = A XOR B
force -freeze sim:/ALU/S 4'b0110 0
run 10 ns

# 4. F = NOT A
force -freeze sim:/ALU/S 4'b0111 0
run 10 ns

# =========================================================
# Part C: Shift Right Operations (5 Operations from Table)
# =========================================================

# 5. F = Logic shift right A
force -freeze sim:/ALU/S 4'b1000 0
run 10 ns

# 6. F = Rotate right A
force -freeze sim:/ALU/S 4'b1001 0
run 10 ns

# 7. F = Rotate right A with Carry (Cin = 0)
force -freeze sim:/ALU/S 4'b1010 0
force -freeze sim:/ALU/Cin 0 0
run 10 ns

# 8. F = Rotate right A with Carry (Cin = 1)
force -freeze sim:/ALU/S 4'b1010 0
force -freeze sim:/ALU/Cin 1 0
run 10 ns

# 9. F = Arithmetic shift right A
force -freeze sim:/ALU/S 4'b1011 0
force -freeze sim:/ALU/Cin 0 0
run 10 ns

# =========================================================
# Part D: Shift Left Operations (5 Operations from Table)
# =========================================================

# 10. F = Logic shift left A
force -freeze sim:/ALU/S 4'b1100 0
run 10 ns

# 11. F = Rotate left A
force -freeze sim:/ALU/S 4'b1101 0
run 10 ns

# 12. F = Rotate left A with Carry (Cin = 0)
force -freeze sim:/ALU/S 4'b1110 0
force -freeze sim:/ALU/Cin 0 0
run 10 ns

# 13. F = Rotate left A with Carry (Cin = 1)
force -freeze sim:/ALU/S 4'b1110 0
force -freeze sim:/ALU/Cin 1 0
run 10 ns

# 14. F = 0000
force -freeze sim:/ALU/S 4'b1111 0
run 10 ns

# =========================================================
# Special Case from Lab 1 Table: A = F00A
# =========================================================

# 15. F = Rotate right A (with A = F00A)
force -freeze sim:/ALU/A 16'hF00A 0
force -freeze sim:/ALU/S 4'b1001 0
run 10 ns