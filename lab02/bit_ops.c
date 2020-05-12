#include <stdio.h>
#include "bit_ops.h"

// Return the nth bit of x.
// Assume 0 <= n <= 31
unsigned get_bit(unsigned x,
                 unsigned n) {
    // YOUR CODE HERE
    // Returning -1 is a placeholder (it makes
    // no sense, because get_bit only returns 
    // 0 or 1)
    unsigned mask = 1 << n;
    return (x & mask) >> n;
}
// Set the nth bit of the value of x to v.
// Assume 0 <= n <= 31, and v is 0 or 1
void set_bit(unsigned * x,
             unsigned n,
             unsigned v) {
    // YOUR CODE HERE
    unsigned setter = v << n;
    unsigned mask = ~((~v) << n);
    mask = mask | ((~(unsigned)0) >> (n + 1) << (n + 1)); // produce 11..1v1..1
    *x = (*x & mask) | setter;
}
// Flip the nth bit of the value of x.
// Assume 0 <= n <= 31
void flip_bit(unsigned * x,
              unsigned n) {
    // YOUR CODE HERE
    unsigned flipper = 1 << n;
    *x = *x ^ flipper;
}

