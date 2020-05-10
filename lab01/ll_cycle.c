#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    node *tortoise = head;
    node *hare = head;
    int incTort = 0; // if incTort is 1, advance tortoise
    while (hare) {
	hare = hare->next;
	if (incTort == 1) {
            tortoise = tortoise->next;
	    incTort = 0;
	} else {
            incTort = 1;
	}

	if (hare == tortoise) {
            return 1;
	}
    }

    return 0;
}
