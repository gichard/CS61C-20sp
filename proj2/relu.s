.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    mv s0, a0
loop_start:
    beq a1, x0, loop_end
    lw s1, 0(s0) # load value
    addi a1, a1, -1
    addi s0, s0, 4
    bge s1, x0, loop_start # value non-negative, do nothing
loop_continue:
    sub s1, x0, s1
    sw s1, -4(s0)
    j loop_start

loop_end:
    

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    
	ret
