# Usage:
# behavioral_serial_adder/behavioral_serial_adder.v
# 	- make dev0
# 	- make ci0
# 	- make clean0
# progress_report_1/src/ProgressReport1.v
# 	- make dev1
# 	- make ci1
# 	- make clean1
# progress_report_2/src/ProgressReport2.v
# 	- make dev2
# 	- make ci2
# 	- make clean2
# progress_report_3/src/ProgressReport3.v
# 	- make dev3
# 	- make ci3
# 	- make clean3
# progress_report_4/src/ProgressReport4.v
# 	- make dev4
# 	- make ci4
# 	- make clean4
# progress_report_4_v2/src/ProgressReport4.v
# 	- make dev4.2
# 	- make ci4.2
# 	- make clean4.2

IVERILOG = iverilog
VVP = vvp

BEHAVIORALSERIALADDER_SRC_DIR = behavioral_serial_adder
BEHAVIORALSERIALADDER_OUT_DIR = behavioral_serial_adder
BEHAVIORALSERIALADDER = behavioral_serial_adder.v
BEHAVIORALSERIALADDER_OUT = $(BEHAVIORALSERIALADDER_OUT_DIR)/behavioral_serial_adder.out
dev0: clean0
	$(IVERILOG) -o $(BEHAVIORALSERIALADDER_OUT) $(BEHAVIORALSERIALADDER_SRC_DIR)/$(BEHAVIORALSERIALADDER)
	$(VVP) $(BEHAVIORALSERIALADDER_OUT)
ci0: 
	$(IVERILOG) -o $(BEHAVIORALSERIALADDER_OUT) $(BEHAVIORALSERIALADDER_SRC_DIR)/$(BEHAVIORALSERIALADDER)
	$(VVP) $(BEHAVIORALSERIALADDER_OUT)
clean0:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(BEHAVIORALSERIALADDER_OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(BEHAVIORALSERIALADDER_OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(BEHAVIORALSERIALADDER_OUT_DIR)/*.out
	endif
endif

PROGRESREPORT1_SRC_DIR = progress_report_1/src
PROGRESREPORT1_OUT_DIR = progress_report_1/src
PROGRESS_REPORT1 = ProgressReport1.v
PROGRESS_REPORT1_OUT = $(PROGRESREPORT1_OUT_DIR)/ProgressReport1.out
dev1: clean1
	$(IVERILOG) -o $(PROGRESS_REPORT1_OUT) $(PROGRESREPORT1_SRC_DIR)/$(PROGRESS_REPORT1)
	$(VVP) $(PROGRESS_REPORT1_OUT)
ci1: 
	$(IVERILOG) -o $(PROGRESS_REPORT1_OUT) $(PROGRESREPORT1_SRC_DIR)/$(PROGRESS_REPORT1)
	$(VVP) $(PROGRESS_REPORT1_OUT)
clean1:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(PROGRESREPORT1_OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(PROGRESREPORT1_OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(PROGRESREPORT1_OUT_DIR)/*.out
	endif
endif

PROGRESREPORT2_SRC_DIR = progress_report_2/src
PROGRESREPORT2_OUT_DIR = progress_report_2/src
PROGRESS_REPORT2 = ProgressReport2.v
PROGRESS_REPORT2_OUT = $(PROGRESREPORT2_OUT_DIR)/ProgressReport2.out
dev2: clean2
	$(IVERILOG) -o $(PROGRESS_REPORT2_OUT) $(PROGRESREPORT2_SRC_DIR)/$(PROGRESS_REPORT2)
	$(VVP) $(PROGRESS_REPORT2_OUT)
ci2: 
	$(IVERILOG) -o $(PROGRESS_REPORT2_OUT) $(PROGRESREPORT2_SRC_DIR)/$(PROGRESS_REPORT2)
	$(VVP) $(PROGRESS_REPORT2_OUT)
clean2:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(PROGRESREPORT2_OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(PROGRESREPORT2_OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(PROGRESREPORT2_OUT_DIR)/*.out
	endif
endif

PROGRESREPORT3_SRC_DIR = progress_report_3/src
PROGRESREPORT3_OUT_DIR = progress_report_3/src
PROGRESS_REPORT3 = ProgressReport3.v
PROGRESS_REPORT3_OUT = $(PROGRESREPORT3_OUT_DIR)/ProgressReport3.out
dev3: clean3
	$(IVERILOG) -o $(PROGRESS_REPORT3_OUT) $(PROGRESREPORT3_SRC_DIR)/$(PROGRESS_REPORT3)
	$(VVP) $(PROGRESS_REPORT3_OUT)
ci3: 
	$(IVERILOG) -o $(PROGRESS_REPORT3_OUT) $(PROGRESREPORT3_SRC_DIR)/$(PROGRESS_REPORT3)
	$(VVP) $(PROGRESS_REPORT3_OUT)
clean3:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(PROGRESREPORT3_OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(PROGRESREPORT3_OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(PROGRESREPORT3_OUT_DIR)/*.out
	endif
endif

PROGRESREPORT4_SRC_DIR = progress_report_4/src
PROGRESREPORT4_OUT_DIR = progress_report_4/src
PROGRESS_REPORT4 = ProgressReport4.v
PROGRESS_REPORT4_OUT = $(PROGRESREPORT4_OUT_DIR)/ProgressReport4.out
dev4: clean4
	$(IVERILOG) -o $(PROGRESS_REPORT4_OUT) $(PROGRESREPORT4_SRC_DIR)/$(PROGRESS_REPORT4)
	$(VVP) $(PROGRESS_REPORT4_OUT)
ci4: 
	$(IVERILOG) -o $(PROGRESS_REPORT4_OUT) $(PROGRESREPORT4_SRC_DIR)/$(PROGRESS_REPORT4)
	$(VVP) $(PROGRESS_REPORT4_OUT)
clean4:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(PROGRESREPORT4_OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(PROGRESREPORT4_OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(PROGRESREPORT4_OUT_DIR)/*.out
	endif
endif

PROGRESREPORT4_SRC_DIR = progress_report_4_v2/src
PROGRESREPORT4_OUT_DIR = progress_report_4_v2/src
PROGRESS_REPORT4 = ProgressReport4.v
PROGRESS_REPORT4_OUT = $(PROGRESREPORT4_OUT_DIR)/ProgressReport4.out
dev4.2: clean4
	$(IVERILOG) -o $(PROGRESS_REPORT4_OUT) $(PROGRESREPORT4_SRC_DIR)/$(PROGRESS_REPORT4)
	$(VVP) $(PROGRESS_REPORT4_OUT)
ci4.2: 
	$(IVERILOG) -o $(PROGRESS_REPORT4_OUT) $(PROGRESREPORT4_SRC_DIR)/$(PROGRESS_REPORT4)
	$(VVP) $(PROGRESS_REPORT4_OUT)
clean4.2:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(PROGRESREPORT4_OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(PROGRESREPORT4_OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(PROGRESREPORT4_OUT_DIR)/*.out
	endif
endif