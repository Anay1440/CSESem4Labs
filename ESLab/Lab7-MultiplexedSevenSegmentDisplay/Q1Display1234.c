#include <LPC17xx.h>

unsigned int i, dig_count = 0; 
unsigned seven_seg[10]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
unsigned int dig_value[4]={1,2,3,4};

int main(void) {
	SystemInit(); //Add these two function for its internal operation
	SystemCoreClockUpdate();

	LPC_PINCON->PINSEL0 &= 0xFF0000FF; //Configure Port0 PINS P0.4-P0.11 as GPIO function
	LPC_PINCON->PINSEL3 &= 0xFFC03FFF; //P1.23 to P1.26
	LPC_GPIO0->FIODIR |= 0xFF0; //Configure P0.4-P0.11 as output port 
	LPC_GPIO1->FIODIR |= 0xF << 23;
	LPC_GPIO1->FIOPIN = 0;
	while(1) {
		for(i = 0; i < 100000; i++);
		LPC_GPIO0->FIOPIN = seven_seg[dig_value[dig_count]] << 4;
		dig_count = (dig_count + 1) % 4;
	}
}
