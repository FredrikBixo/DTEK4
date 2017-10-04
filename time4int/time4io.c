

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int getsw( void ) {
    
    volatile int *portD = (volatile int *) 0xbf8860D0;
    
    int r = (*portD & 0x00000F00) >> 8;
    
    return r;
}

int getbtns(void) {
    
    volatile int *portD = (volatile int *) 0xbf8860D0;
    
    int r = (*portD & 0x000000E0) >> 5;
    
    return r;
    
}

