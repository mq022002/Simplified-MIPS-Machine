# Usage:
# 	- make ci
# 	- make dev
# 	- make clean

SRC_DIR = src
OUT_DIR = src

IVERILOG = iverilog
VVP = vvp

PROGRESS_REPORT4 = ProgressReport4.v
PROGRESS_REPORT4_OUT = $(OUT_DIR)/ProgressReport4.out

dev: clean
	$(IVERILOG) -o $(PROGRESS_REPORT4_OUT) $(SRC_DIR)/$(PROGRESS_REPORT4)
	$(VVP) $(PROGRESS_REPORT4_OUT)

ci: 
	$(IVERILOG) -o $(PROGRESS_REPORT4_OUT) $(SRC_DIR)/$(PROGRESS_REPORT4)
	$(VVP) $(PROGRESS_REPORT4_OUT)

clean:
ifeq ($(OS),Windows_NT)
	@echo "Detected OS: $(OS)"
	powershell -Command "Remove-Item -Path .\$(OUT_DIR)\*.out -Force"
else
	UNAME_S = $(shell uname -s)
	@echo "Detected OS: $(UNAME_S)"
	ifeq ($(UNAME_S),Linux)
		rm -f $(OUT_DIR)/*.out
	endif
	ifeq ($(UNAME_S),Darwin)
		rm -f $(OUT_DIR)/*.out
	endif
endif