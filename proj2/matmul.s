.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error if mismatched dimensions
    bne a2, a4, mismatched_dimensions

    # Prologue
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    mv s0, a0 # m0 row vec
    mv s1, a3 # m1 col vec
    mv s2, a1 # rowNum of m0
    li s3, 0 # row of m0
    li s4, 0 # col of m1
    mv s5, a2 # vec length
    slli s6, s5, 2 # m0 row vec inc
    mv s7, a3 # save 0th col
outer_loop_start:
    bge s3, s2, outer_loop_end
inner_loop_start:
    mv a0, s0 # set row of m0
    mv a2, s5
    li a3, 1
    bge s4, a5, inner_loop_end
    mv a1, s1
    mv a4, a5
    jal ra, dot
    sw a0, 0(a6)
    addi a6, a6, 4
    addi s1, s1, 1
    addi s4, s4, 1 # increment col
    j inner_loop_start
inner_loop_end:
    li s4, 0
    mv s1, s7 # reset col vec
    add s0, s0, s6
    addi s3, s3, 1 # increment row
    j outer_loop_start
outer_loop_end:
    

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    addi sp, sp, 32
    
    ret


mismatched_dimensions:
    li a1 2
    jal exit2
