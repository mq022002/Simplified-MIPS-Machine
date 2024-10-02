# Usage:
# 	- make compile_ALU_tb
# 	- make compile_RegisterFile_tb
# 	- make compile_PC_tb
# 	- make compile_CPU_tb
# 	- make run_ALU_tb
# 	- make run_RegisterFile_tb
# 	- make run_PC_tb
# 	- make run_CPU_tb
# 	- make all
# 	- make clean

SRC_DIR = src
TB_DIR = testbenches
OUT_DIR = testbenches

IVERILOG = iverilog
VVP = vvp

ALU = ALU.v
REGISTER_FILE = RegisterFile.v
INSTRUCTION_MEMORY = InstructionMemory.v
PC = PC.v

ALU_TB = ALU_tb.v
REGISTER_FILE_TB = RegisterFile_tb.v
PC_TB = PC_tb.v
CPU_TB = CPU_tb.v

ALU_TB_OUT = $(OUT_DIR)/ALU_tb.out
REGISTER_FILE_TB_OUT = $(OUT_DIR)/RegisterFile_tb.out
PC_TB_OUT = $(OUT_DIR)/PC_tb.out
CPU_TB_OUT = $(OUT_DIR)/CPU_tb.out

compile_ALU_tb:
	$(IVERILOG) -o $(ALU_TB_OUT) $(SRC_DIR)/$(ALU) $(TB_DIR)/$(ALU_TB)

compile_RegisterFile_tb:
	$(IVERILOG) -o $(REGISTER_FILE_TB_OUT) $(SRC_DIR)/$(REGISTER_FILE) $(TB_DIR)/$(REGISTER_FILE_TB)

compile_PC_tb:
	$(IVERILOG) -o $(PC_TB_OUT) $(SRC_DIR)/$(PC) $(TB_DIR)/$(PC_TB)

compile_CPU_tb:
	$(IVERILOG) -o $(CPU_TB_OUT) $(SRC_DIR)/$(ALU) $(SRC_DIR)/$(REGISTER_FILE) $(SRC_DIR)/$(INSTRUCTION_MEMORY) $(SRC_DIR)/$(PC) $(TB_DIR)/$(CPU_TB)

run_ALU_tb: compile_ALU_tb
	$(VVP) $(ALU_TB_OUT)

run_RegisterFile_tb: compile_RegisterFile_tb
	$(VVP) $(REGISTER_FILE_TB_OUT)

run_PC_tb: compile_PC_tb
	$(VVP) $(PC_TB_OUT)

run_CPU_tb: compile_CPU_tb
	$(VVP) $(CPU_TB_OUT)

all: run_ALU_tb run_RegisterFile_tb run_PC_tb run_CPU_tb

clean:
	del /Q $(OUT_DIR)\*.out
	# rm -f $(OUT_DIR)/*.out
