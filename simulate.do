# 1. Create the work library
vlib work
vmap work work

# 2. Compile all VHDL files
vcom PartA.vhd
vcom partB.vhd
vcom partC.vhd
vcom partD.vhd
vcom ALU.vhd

# 3. Start the simulation with generic parameter n=8 as specified in Lab 2
vsim -g n=8 work.ALU

# 4. Add waves
add wave -position insertpoint sim:/ALU/*

# =========================================================
# Part A Test Cases (From Lab 2 Assignment Table - n=8)
# =========================================================

# 1. F = A
force -freeze sim:/ALU/A 8'h0F 0
force -freeze sim:/ALU/B 8'h00 0
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b0000 0
run 10 ns

# 2. F = A + B
force -freeze sim:/ALU/A 8'h0F 0
force -freeze sim:/ALU/B 8'h01 0
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b0001 0
run 10 ns

# 3. F = A + B (With Overflow Carry)
force -freeze sim:/ALU/A 8'hFF 0
force -freeze sim:/ALU/B 8'h01 0
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b0001 0
run 10 ns

# 4. F = A - B - 1
force -freeze sim:/ALU/A 8'hFF 0
force -freeze sim:/ALU/B 8'h01 0
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b0010 0
run 10 ns

# 5. F = A - 1
force -freeze sim:/ALU/A 8'hFF 0
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b0011 0
run 10 ns

# 6. F = A + 1
force -freeze sim:/ALU/A 8'h0E 0
force -freeze sim:/ALU/Cin 1 0
force -freeze sim:/ALU/S 4'b0000 0
run 10 ns

# 7. F = A + B + 1
force -freeze sim:/ALU/A 8'hFF 0
force -freeze sim:/ALU/B 8'h01 0
force -freeze sim:/ALU/Cin 1 0
force -freeze sim:/ALU/S 4'b0001 0
run 10 ns

# 8. F = A - B
force -freeze sim:/ALU/A 8'h0F 0
force -freeze sim:/ALU/B 8'h01 0
force -freeze sim:/ALU/Cin 1 0
force -freeze sim:/ALU/S 4'b0010 0
run 10 ns

# 9. F = 0
force -freeze sim:/ALU/A 8'hF0 0
force -freeze sim:/ALU/Cin 1 0
force -freeze sim:/ALU/S 4'b0011 0
run 10 ns

# =========================================================
# Parts B, C, D Test Cases (From Lab 2 Assignment Table)
# =========================================================
force -freeze sim:/ALU/A 8'hF5 0
force -freeze sim:/ALU/B 8'hAA 0

# Part B: Logic
# 10. AND
force -freeze sim:/ALU/S 4'b0100 0
run 10 ns

# 11. OR
force -freeze sim:/ALU/S 4'b0101 0
run 10 ns

# 12. XOR
force -freeze sim:/ALU/S 4'b0110 0
run 10 ns

# 13. NOT
force -freeze sim:/ALU/S 4'b0111 0
run 10 ns

# Part C: Shifts & Rotates Right
# 14. Logic Shift Right A
force -freeze sim:/ALU/S 4'b1000 0
run 10 ns

# 15. Rotate Right A
force -freeze sim:/ALU/S 4'b1001 0
run 10 ns

# 16. Rotate Right A with Carry (Cin = 0)
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b1010 0
run 10 ns

# 17. Rotate Right A with Carry (Cin = 1)
force -freeze sim:/ALU/Cin 1 0
force -freeze sim:/ALU/S 4'b1010 0
run 10 ns

# 18. Arithmetic Shift Right A
force -freeze sim:/ALU/S 4'b1011 0
run 10 ns

# Part D: Shifts & Rotates Left
# 19. Logic Shift Left A
force -freeze sim:/ALU/S 4'b1100 0
run 10 ns

# 20. Rotate Left A
force -freeze sim:/ALU/S 4'b1101 0
run 10 ns

# 21. Rotate Left A with Carry (Cin = 0)
force -freeze sim:/ALU/Cin 0 0
force -freeze sim:/ALU/S 4'b1110 0
run 10 ns

# 22. Rotate Left A with Carry (Cin = 1)
force -freeze sim:/ALU/Cin 1 0
force -freeze sim:/ALU/S 4'b1110 0
run 10 ns

# 23. F = 0000
force -freeze sim:/ALU/S 4'b1111 0
run 10 ns

# 24. Special Case: Rotate Right A (A = 7A)
force -freeze sim:/ALU/A 8'h7A 0
force -freeze sim:/ALU/S 4'b1001 0
run 10 ns
