
SYSTEMC_HOME=/usr/local/systemc-2.3.3

CXX:=g++
CXXFLAGS:=-Wno-deprecated

INCS:=-I. -I$(SYSTEMC_HOME)/include -I/usr/include
# LIBS:=-L$(SYSTEMC_HOME)/lib-linux64 -lsystemc -lm -lstdc++
LIBS:=-L$(SYSTEMC_HOME)/lib-linux64 -lsystemc
OBJS:=main.o tb.o fir.o
EXE:=main

LD_LIBRARY_PATH=$(SYSTEMC_HOME)/lib-linux64

all:$(OBJS)
	$(CXX) $(CXXFLAGS) $(INCS) $(LIBS) -o $(EXE) $(OBJS)

%.o:%.cc
	$(CXX) $(INCS) $(LIBS) -c $^ -o $@ 

run:
	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) ./main
	@make cmp_result

.PHONY:clean
clean:
	rm -rf $(OBJS) $(EXE)


GOLD_FILE=./golden.dat

cmp_result:
	@echo "******************************************"
	@if diff -w $(GOLD_FILE) ./output.dat ; then \
		echo "SIMULATION PASSED"; \
	else \
		echo "SIMULATION FAILED"; \
	fi
	@echo "******************************************"
