.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s

.globl main

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    # Exit if incorrect number of command line args
    li t0, 5
    blt a0, t0, invalid_args
    lw s0, 4(a1) # m0
    lw s1, 8(a1) # m1
    lw s2, 12(a1) # input_path
    lw s3, 16(a1) # output_path
    mv s10, a0
	# =====================================
    # LOAD MATRICES
    # =====================================
    li a0, 24
    jal ra, malloc
    mv s4, a0 # store sizes

    # Load pretrained m0
    mv a0, s0
    addi a1, s4, 0
    addi a2, s4, 4
    jal ra, read_matrix
    mv s5, a0
    # Load pretrained m1
    mv a0, s1
    addi a1, s4, 8
    addi a2, s4, 12
    jal ra, read_matrix
    mv s6, a0
    # Load input matrix
    mv a0, s2
    addi a1, s4, 16
    addi a2, s4, 20
    jal ra, read_matrix
    mv s7, a0

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    lw t0, 0(s4)
    lw t1, 20(s4)
    mul a0, t0, t1
    slli a0, a0, 2
    jal ra, malloc
    mv s8, a0 # hidden layer
    # m0 * input
    mv a0, s5
    lw a1, 0(s4)
    lw a2, 4(s4)
    mv a3, s7
    lw a4, 16(s4)
    lw a5, 20(s4)
    mv a6, s8
    jal ra, matmul
    # ReLU
    mv a0, s8
    lw t0, 0(s4)
    lw t1, 20(s4)
    mul a1, t0, t1
    jal ra, relu
    # m1 * ..
    lw t0, 8(s4)
    lw t1, 20(s4)
    mul a0, t0, t1
    slli a0, a0, 2
    jal ra, malloc
    mv s9, a0 # scores
    mv a0, s6
    lw a1, 8(s4)
    lw a2, 12(s4)
    mv a3, s8
    lw a4, 0(s4)
    lw a5, 20(s4)
    mv a6, s9
    jal ra, matmul
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    # lw a0 16(s0) # Load pointer to output filename
    mv a0, s3 # Load pointer to output filename
    mv a1, s9
    lw a2, 8(s4)
    lw a3, 20(s4)
    jal ra, write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    lw t0, 8(s4)
    lw t1, 20(s4)
    mul a1, t0, t1
    mv a0, s9
    jal ra, argmax

    # Print classification
    mv a1, a0
    jal ra, print_int



    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    # free
    mv a0, s5
    jal ra, free # free m0
    mv a0, s7
    jal ra, free # free input matrix
    mv a0, s9
    jal ra, free # free output
    mv a0, s4
    jal ra, free # free sizes
    mv a0, s8
    jal ra, free # free hidden layer
    mv a0, s6
    jal ra, free # free m1
    mv a0, s0
    jal ra, free
    mv a0, s1
    jal ra, free
    mv a0, s2
    jal ra, free
    mv a0, s3
    jal ra, free
    mv a0, s10
    jal ra, free

    jal exit

invalid_args:
    li a1 3
    jal exit2