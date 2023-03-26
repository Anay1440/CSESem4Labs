#include <LPC17xx.h>
unsigned int i,j; 
unsigned long LED = 0x10;
int main(void)
{
	SystemInit(); //Add these two function for its internal operation
	SystemCoreClockUpdate();
	LPC_PINCON->PINSEL0 &= 0xFF0000FF;
	//Configure Port0 PINS P0.4-P0.11 as GPIO function
	LPC_GPIO0->FIODIR |= 0xFF0;
	//Configure P0.4-P0.11 as output port 
	while(1)
 {
		LED = 0x10; // Initial value on LED 
		for(i=1;i<256;i++)
		{
			LPC_GPIO0->FIOPIN = LED; 
			for(j=0;j<50000;j++); //delay
			LED += 0x10; 
		}
	}
}
