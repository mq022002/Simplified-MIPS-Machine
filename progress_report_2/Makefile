# Usage:
# 	- make all
# 	- make clean

SRC_DIR = src
OUT_DIR = src

IVERILOG = iverilog
VVP = vvp

PROGRESS_REPORT2 = ProgressReport2.v
PROGRESS_REPORT2_OUT = $(OUT_DIR)/ProgressReport2.out

all: clean
	$(IVERILOG) -o $(PROGRESS_REPORT2_OUT) $(SRC_DIR)/$(PROGRESS_REPORT2)
	$(VVP) $(PROGRESS_REPORT2_OUT)

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