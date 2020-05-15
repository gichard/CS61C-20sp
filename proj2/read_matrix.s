.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

    # Prologue
	addi sp, sp, -24
	sw s4, 20(sp)
	sw s3, 16(sp)
	sw ra, 12(sp)
	sw s0, 8(sp)
	sw s1, 4(sp)
	sw s2, 0(sp)

	mv s0, a0
	mv s1, a1
	mv s2, a2

	li a0, 8
	jal ra, malloc
	mv s3, a0 # buffer
	mv a1, s0
	li a2, 0
	jal ra, fopen # open file
	mv s4, a0 # file descriptor
	mv a1, s4
	mv a2, s3
	li a3, 8
	jal ra, fread # read first 8 bytes
	li t0, 8
	blt a0, t0, eof_or_error # handle error

	lw t0, 0(s3) # rows
	lw t1, 4(s3) # cols
	sw t0, 0(s1)
	sw t1, 0(s2)
	mv s1, t0
	mv s2, t1
	mv a0, s3
	jal ra, free # free old buffer
	mul s0, s1, s2
	slli s0, s0, 2 # calculate number of bytes needed
	mv a0, s0
	jal ra, malloc
	mv s3, a0 # create new buffer for matrix

	mv a1, s4
	mv a2, s3
	mv a3, s0
	jal ra, fread
	bne a0, s0, eof_or_error

	mv a0, s3
	# Epilogue
	lw s4, 20(sp)
	lw s3, 16(sp)
	lw ra, 12(sp)
	lw s0, 8(sp)
	lw s1, 4(sp)
	lw s2, 0(sp)
	addi sp, sp, 24

    ret

eof_or_error:
    li a1 1
    jal exit2
    