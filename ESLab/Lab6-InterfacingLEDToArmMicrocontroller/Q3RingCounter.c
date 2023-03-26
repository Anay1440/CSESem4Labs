#include <LPC17xx.h>
unsigned int i,j; 
unsigned long LED = 0x10;
int main(void)
{
	SystemInit(); //Add these two function for its internal operation
	SystemCoreClockUpdate();
	LPC_PINCON->PINSEL0 &= 0xFF0000FF; //Configure Port0 PINS P0.4-P0.11 as GPIO function
	LPC_PINCON->PINSEL4 &= 0xF0FFFFFF; //Configure Port1 PIN P2.12 and P2.13 as GPIO function
	LPC_GPIO2->FIODIR &= ~(1 << 12); //Configure pin 7 for input
	LPC_GPIO0->FIODIR |= 0xFF0; //Configure P0.4-P0.11 as output port 
	LED = 0x10; // Initial value on LED

	while(1)
 {
	  if ( (LPC_GPIO2->FIOPIN & (1 << 12)) == 0 ) {
						LPC_GPIO0->FIOCLR = LED;
						for(j=0;j<50000;j++); //delay
						LED <<= 1;
						if (LED == (0x10 << 8))
							LED = 0x10;
				
		}
			LPC_GPIO0->FIOSET = LED; 
			for(j=0;j<50000;j++); //delay
	}
}
