.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
    beq a0, x0, void_vec # if v==NULL
    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)

    mv s0, a0
    add a0, x0, x0 # a0 = 0
    lw s1, 0(s0) # s1 = v[0]
    add s3, x0, x0 # i = 0;
loop_start:
    bge s3, a1, loop_end
    lw s2, 0(s0) # s2 = v[i]
    addi s0, s0, 4
    addi s3, s3, 1 # i++
    bge s1, s2, loop_start
loop_continue:
    add a0, s3, x0 # a0 = newMaxInd
    mv s1, s2 # s1 = newMax
    j loop_start

loop_end:
    

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    addi sp, sp, 16

    ret
void_vec:
    addi a0, x1, -1
    ret
