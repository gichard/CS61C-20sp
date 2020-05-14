.import ../dot.s
.import ../utils.s

# Set vector values for testing
.data
vector0: .word 1 2 3 4 5 6 7 8 9
vector1: .word 1 2 3 4 5 6 7 8 9


.text
# main function for testing
main:
    # Load vector addresses into registers
    la s0 vector0
    la s1 vector1

    # Set vector attributes
    addi s2, x0, 1
    #addi s3, x0, 1 # set stride
    addi s3, x0, 2 # set stride


    # Call dot function
    mv a0, s0
    mv a1, s1
    #addi a2, x0, 9
    addi a2, x0, 3
    mv a3, s2
    mv a4, s3
    jal ra, dot


    # Print integer result
    mv a1, a0
    jal ra, print_int


    # Print newline
    li a1, '\n'
    jal ra print_char


    # Exit
    jal exit
