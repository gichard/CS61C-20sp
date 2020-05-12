#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"
//#include "bit_ops.h"

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
//    uint16_t newBit = get_bit((unsigned)(*reg), (unsigned)0) ^ get_bit((unsigned)(*reg), (unsigned)2) ^ get_bit((unsigned)(*reg), (unsigned)3) ^ get_bit((unsigned)(*reg), (unsigned)5);
//    *reg = *reg >> 1;
//    set_bit((unsigned *)reg, 15, newBit);
    // a new way, from wikipedia
    uint16_t bit = ((*reg >> 0) ^ (*reg >> 2) ^ (*reg >> 3) ^ (*reg >> 5));
    *reg = (*reg >> 1) | (bit << 15);
}

