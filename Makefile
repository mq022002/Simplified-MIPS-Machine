# Usage:
# 	- make dev4
# 	- make ci4
# 	- make clean4

IVERILOG = iverilog
VVP = vvp

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