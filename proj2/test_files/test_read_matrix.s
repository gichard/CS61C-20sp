.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./test_input.bin"

.text
main:
    # Read matrix into memory
    li a0, 8
	jal ra, malloc
	mv s0, a0
	mv a1, a0
	addi a2, a0, 4 # set pointer to integer
    la a0, file_path
    jal ra, read_matrix

    # Print out elements of matrix
    lw a1, 0(s0)
    lw a2, 4(s0)
    jal ra, print_int_array

    # Terminate the program
    addi a0, x0, 10
    ecall