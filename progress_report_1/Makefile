# Usage:
# 	- make compile_and_run_ALU_tb
# 	- make compile_and_run_RegisterFile_tb
# 	- make compile_and_run_PC_tb
# 	- make compile_and_run_InstructionMemory_tb
# 	- make compile_and_run_CPU_tb
# 	- make all
# 	- make clean

SRC_DIR = src
TB_DIR = testbenches
OUT_DIR = testbenches

IVERILOG = iverilog
VVP = vvp

ALU = ALU.v
REGISTER_FILE = RegisterFile.v
PC = PC.v
INSTRUCTION_MEMORY = InstructionMemory.v
CPU = CPU.v

ALU_TB = ALU_tb.v
REGISTER_FILE_TB = RegisterFile_tb.v
PC_TB = PC_tb.v
INSTRUCTION_MEMORY_TB = InstructionMemory_tb.v
CPU_TB = CPU_tb.v

ALU_TB_OUT = $(OUT_DIR)/ALU_tb.out
REGISTER_FILE_TB_OUT = $(OUT_DIR)/RegisterFile_tb.out
PC_TB_OUT = $(OUT_DIR)/PC_tb.out
INSTRUCTION_MEMORY_TB_OUT = $(OUT_DIR)/InstructionMemory_tb.out
CPU_TB_OUT = $(OUT_DIR)/CPU_tb.out

compile_and_run_ALU_tb:
	$(IVERILOG) -o $(ALU_TB_OUT) $(SRC_DIR)/$(ALU) $(TB_DIR)/$(ALU_TB)
	$(VVP) $(ALU_TB_OUT)

compile_and_run_RegisterFile_tb:
	$(IVERILOG) -o $(REGISTER_FILE_TB_OUT) $(SRC_DIR)/$(REGISTER_FILE) $(TB_DIR)/$(REGISTER_FILE_TB)
	$(VVP) $(REGISTER_FILE_TB_OUT)

compile_and_run_PC_tb:
	$(IVERILOG) -o $(PC_TB_OUT) $(SRC_DIR)/$(PC) $(TB_DIR)/$(PC_TB)
	$(VVP) $(PC_TB_OUT)

compile_and_run_InstructionMemory_tb:
	$(IVERILOG) -o $(INSTRUCTION_MEMORY_TB_OUT) $(SRC_DIR)/$(INSTRUCTION_MEMORY) $(TB_DIR)/$(INSTRUCTION_MEMORY_TB)
	$(VVP) $(INSTRUCTION_MEMORY_TB_OUT)

compile_and_run_CPU_tb:
	$(IVERILOG) -o $(CPU_TB_OUT) $(SRC_DIR)/$(ALU) $(SRC_DIR)/$(REGISTER_FILE) $(SRC_DIR)/$(INSTRUCTION_MEMORY) $(SRC_DIR)/$(PC) $(TB_DIR)/$(CPU_TB)
	$(VVP) $(CPU_TB_OUT)

all: compile_and_run_ALU_tb compile_and_run_RegisterFile_tb compile_and_run_PC_tb compile_and_run_InstructionMemory_tb compile_and_run_CPU_tb

clean:
	del /Q $(OUT_DIR)\*.out
	# rm -f $(OUT_DIR)/*.out