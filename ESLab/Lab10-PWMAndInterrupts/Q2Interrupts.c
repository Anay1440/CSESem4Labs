#include <LPC17xx.h>

void EINT2_IRQHandler(void)
{
	int i;
    LPC_GPIO0->FIOPIN= ~ (LPC_GPIO0->FIOPIN);
    for(i=0;i<100000;i++);
    LPC_SC->EXTINT=1;
    return;
}

int main(void) {
    int flag = 0;
    LPC_PINCON->PINSEL0 &= 0xFF0000FF; //Configure Port0 PINS P0.4-P0.11 as GPIO function
	LPC_GPIO0->FIODIR |= 0xFF0; //Configure P0.4-P0.11 as output port 
    LPC_PINCON->PINSEL4 |= (1 << 24); //Configure Port2 PIN P2.12 as function 2
    LPC_SC->EXTMODE = (1 << 3);// the third bit is set to 1 then it is edge triggered
    LPC_SC->EXTPOLAR=0;
    NVIC_EnableIRQ(EINT2_IRQn);
    while (1);
} // end main
