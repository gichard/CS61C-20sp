.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
    beq a0, x0, void_input
    beq a1, x0, void_input
    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    add s3, x0, x0 # sum = 0
    slli a3, a3, 2
    slli a4, a4, 2
loop_start:
    beq a2, x0, loop_end
    lw s0, 0(a0)
    lw s1, 0(a1)
    add a0, a0, a3
    add a1, a1, a4
    addi a2, a2, -1
    mul s2, s0, s1
    add s3, s3, s2
    j loop_start
loop_end:
    mv a0, s3
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    addi sp, sp, 16
    ret
void_input:
    addi a0, x0, -1
    ret
