/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */
#include <stdio.h>

int timeoutcount =0;
int mytime = 0x5957;
int prime = 1234567;

volatile int *trisE = (volatile int *) 0xbf886100;
volatile int *portE = (volatile int *) 0xbf886110;
volatile int *portD = (volatile int *) 0xbf8860D0;
volatile int *trisD = (volatile int *) 0xbf0887FE0;


//volatile int *iFS = (volatile int *) 0x81030;
volatile int *t2CONSET = (volatile int *) 0x0810;
volatile int *pR2 = (volatile int *) 0x0820;

volatile int *t2con = (volatile int *) 0x0800;
volatile int *tmr2 = (volatile int *) 0x0810;

char textstring[] = "text, more text, and even more text!";

/* Interrupt Service Routine */
void user_isr( void )
{
    
    
    if (IFS(0) & 0x100) {
        timeoutcount++;
        IFSCLR(0)=0x100;
    }
    
    if (timeoutcount > 9) {
        time2string( textstring, mytime );
        display_string( 3, textstring );
        display_update();
        tick( &mytime );
        timeoutcount = 0;
    
    }
    
    
    
    *portE = 0x1;
    
    
  return;
}



/* Lab-specific initialization goes here */
void labinit( void )
{

    enable_interrupt();
    
    *trisE = *trisE & 0xffffff00;
    *portE = 0;
    *trisD = 0xbf0887FE0;
    
    
    T2CON = 0x70;
    PR2 = (800000000/10/256);
    TMR2 = 0;
    
    T2CONSET = 0x8000;
    
    IEC(0) = 0x100;
    IPC(2) = 0x7;
    
    return;
}

void labwork( void ) {
    prime = nextprime( prime );
    display_string( 0, itoaconv( prime ) );
    display_update();
}

