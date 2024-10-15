# Usage:
# 	- make compile_and_run_ALU_tb
# 	- make compile_and_run_RegisterFile_tb
# 	- make compile_and_run_InstructionMemory_tb
# 	- make compile_and_run_ControlUnit_tb
# 	- make compile_and_run_CPU_tb
# 	- make all
# 	- make clean

SRC_DIR = src
TB_DIR = testbenches
OUT_DIR = testbenches

IVERILOG = iverilog
VVP = vvp

MUX2TO1 = Mux2To1.v
MUX4TO1 = Mux4To1.v
ALU = ALU.v
REGISTER_FILE = RegisterFile.v
INSTRUCTION_MEMORY = InstructionMemory.v
CONTROL_UNIT = ControlUnit.v
CPU = CPU.v
PROGRESS_REPORT1 = ProgressReport1.v

ALU_TB = ALU_tb.v
REGISTER_FILE_TB = RegisterFile_tb.v
INSTRUCTION_MEMORY_TB = InstructionMemory_tb.v
CONTROL_UNIT_TB = ControlUnit_tb.v
CPU_TB = CPU_tb.v

ALU_TB_OUT = $(OUT_DIR)/ALU_tb.out
REGISTER_FILE_TB_OUT = $(OUT_DIR)/RegisterFile_tb.out
INSTRUCTION_MEMORY_TB_OUT = $(OUT_DIR)/InstructionMemory_tb.out
CONTROL_UNIT_TB_OUT = $(OUT_DIR)/ControlUnit_tb.out
CPU_TB_OUT = $(OUT_DIR)/CPU_tb.out
PROGRESS_REPORT1_OUT = $(OUT_DIR)/ProgressReport1.out

compile_and_run_ALU_tb:
	$(IVERILOG) -o $(ALU_TB_OUT) $(SRC_DIR)/$(MUX2TO1) $(SRC_DIR)/$(MUX4TO1) $(SRC_DIR)/$(ALU) $(TB_DIR)/$(ALU_TB)
	$(VVP) $(ALU_TB_OUT)

compile_and_run_RegisterFile_tb:
	$(IVERILOG) -o $(REGISTER_FILE_TB_OUT) $(SRC_DIR)/$(MUX2TO1) $(SRC_DIR)/$(MUX4TO1) $(SRC_DIR)/$(REGISTER_FILE) $(TB_DIR)/$(REGISTER_FILE_TB)
	$(VVP) $(REGISTER_FILE_TB_OUT)

compile_and_run_InstructionMemory_tb:
	$(IVERILOG) -o $(INSTRUCTION_MEMORY_TB_OUT) $(SRC_DIR)/$(MUX2TO1) $(SRC_DIR)/$(MUX4TO1) $(SRC_DIR)/$(INSTRUCTION_MEMORY) $(TB_DIR)/$(INSTRUCTION_MEMORY_TB)
	$(VVP) $(INSTRUCTION_MEMORY_TB_OUT)

compile_and_run_ControlUnit_tb:
	$(IVERILOG) -o $(CONTROL_UNIT_TB_OUT) $(SRC_DIR)/$(MUX2TO1) $(SRC_DIR)/$(MUX4TO1) $(SRC_DIR)/$(CONTROL_UNIT) $(TB_DIR)/$(CONTROL_UNIT_TB)
	$(VVP) $(CONTROL_UNIT_TB_OUT)

compile_and_run_CPU_tb:
	$(IVERILOG) -o $(CPU_TB_OUT) $(SRC_DIR)/$(MUX2TO1) $(SRC_DIR)/$(MUX4TO1) $(SRC_DIR)/$(ALU) $(SRC_DIR)/$(REGISTER_FILE) $(SRC_DIR)/$(INSTRUCTION_MEMORY) $(SRC_DIR)/$(CONTROL_UNIT) $(SRC_DIR)/$(CPU) $(TB_DIR)/$(CPU_TB)
	$(VVP) $(CPU_TB_OUT)

compile_and_run_ProgressReport1:
	$(IVERILOG) -o $(PROGRESS_REPORT1_OUT) $(SRC_DIR)/$(MUX2TO1) $(SRC_DIR)/$(MUX4TO1) $(SRC_DIR)/$(PROGRESS_REPORT1)
	$(VVP) $(PROGRESS_REPORT1_OUT)

all: compile_and_run_ALU_tb compile_and_run_RegisterFile_tb compile_and_run_InstructionMemory_tb compile_and_run_ControlUnit_tb compile_and_run_CPU_tb

clean:
	del /Q $(OUT_DIR)\*.out
	# rm -f $(OUT_DIR)/*.out