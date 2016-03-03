#
# This Makefile is for simluating N-body system  in CUDA
# Typing 'make' will create the executable file and
# 'make clean' will remove all the executable file generated by this file
# add parameters as this :
#				make env=1 bls=16
#

# define compiler: nvcc for cuda program in this case
COMPILER = /usr/local/cuda-5.5/bin/nvcc

# set flags for compiling the program
# -g  		adds debugging information to the executable file
# -Wall 	turns on most, but not all, compiler warnings
# -arch=sm_20  enables double-type variables in cuda
CFLAGS = -g -arch=sm_20

# set flag for environment
# if env is set then the code is compiled under windows 10 environment
#  add a flag -std=c11
ifdef env
	CFLAGS += -std=c11
endif

# set grid dimension and set up a default block size 256
#  need only one dimension
ifdef bls
	DIM = -DBLOCKSIZE=$(bls)
else
	DIM = -DBLOCKSIZE=256
endif

# initialize data using host functions
ifdef mcore
	CFLAGS += -DMCORE=1
endif

# add libraries
LIBRARY = -lm

BLOCKING = $(DIM)
CFLAGS += $(BLOCKING) -O3

OBJECTS = andromeda.cu
# defining target for make
default: andromeda
all: clean andromeda

andromeda: $(OBJECTS)
	$(COMPILER) $(CFLAGS) $(LIBRARY) -o andromeda $(OBJECTS)

# Make file test
test: gputest.cu
	$(COMPILER) $(CFLAGS) $(LIBRARY) -o test gputest.cu

clean:
	$(RM) andromeda test
