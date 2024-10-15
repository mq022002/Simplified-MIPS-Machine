# Usage:
# 	- make compile_and_run_Mux2To1_tb
# 	- make compile_and_run_Mux4To1_tb
# 	- make compile_and_run_ALU_tb
# 	- make compile_and_run_RegisterFile_tb
# 	- make compile_and_run_InstructionMemory_tb
# 	- make compile_and_run_ControlUnit_tb
# 	- make compile_and_run_CPU_tb
# 	- make compile_and_run_ProgressReport1
# 	- make all
# 	- make

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

MUX2TO1_TB = Mux2To1Testbench.v
MUX4TO1_TB = Mux4To1Testbench.v
ALU_TB = ALUTestbench.v
REGISTER_FILE_TB = RegisterFileTestbench.v
INSTRUCTION_MEMORY_TB = InstructionMemoryTestbench.v
CONTROL_UNIT_TB = ControlUnitTestbench.v
CPU_TB = CPUTestbench.v

MUX2TO1_TB_OUT = $(OUT_DIR)/Mux2To1Testbench.out
MUX4TO1_TB_OUT = $(OUT_DIR)/Mux4To1Testbench.out
ALU_TB_OUT = $(OUT_DIR)/ALUTestbench.out
REGISTER_FILE_TB_OUT = $(OUT_DIR)/RegisterFileTestbench.out
INSTRUCTION_MEMORY_TB_OUT = $(OUT_DIR)/InstructionMemoryTestbench.out
CONTROL_UNIT_TB_OUT = $(OUT_DIR)/ControlUnitTestbench.out
CPU_TB_OUT = $(OUT_DIR)/CPUTestbench.out
PROGRESS_REPORT1_OUT = $(OUT_DIR)/ProgressReport1.out

compile_and_run_Mux2To1_tb:
	$(IVERILOG) -o $(MUX2TO1_TB_OUT) $(SRC_DIR)/$(MUX2TO1) $(TB_DIR)/$(MUX2TO1_TB)
	$(VVP) $(MUX2TO1_TB_OUT)

compile_and_run_Mux4To1_tb:
	$(IVERILOG) -o $(MUX4TO1_TB_OUT) $(SRC_DIR)/$(MUX4TO1) $(TB_DIR)/$(MUX4TO1_TB)
	$(VVP) $(MUX4TO1_TB_OUT)

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
	$(IVERILOG) -o $(PROGRESS_REPORT1_OUT) $(SRC_DIR)/$(PROGRESS_REPORT1)
	$(VVP) $(PROGRESS_REPORT1_OUT)

dev: clean compile_and_run_Mux2To1_tb compile_and_run_Mux4To1_tb compile_and_run_ALU_tb compile_and_run_RegisterFile_tb compile_and_run_InstructionMemory_tb compile_and_run_ControlUnit_tb compile_and_run_CPU_tb

ci: compile_and_run_Mux2To1_tb compile_and_run_Mux4To1_tb compile_and_run_ALU_tb compile_and_run_RegisterFile_tb compile_and_run_InstructionMemory_tb compile_and_run_ControlUnit_tb compile_and_run_CPU_tb

clean:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(OUT_DIR)\*.out -Force"
else
	UNAME_S := $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(OUT_DIR)/*.out
	endif
endif