#include <LPC17xx.h>

unsigned int i, value = 9999; 
unsigned seven_seg[10]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
unsigned int seg_select[4] = {0, 1<<23, 2<<23, 3<<23};

void display() {

    int digits[4] = {0,0,0,0};
    int ind = 0,x, val = value;
    while(val > 0) {
        x = val % 10;
        val = val / 10;
        digits[ind++] = x;
    }

    for(ind = 0; ind < 4; ind++) {
        LPC_GPIO1->FIOPIN = seg_select[ind];
        LPC_GPIO0->FIOPIN = seven_seg[digits[ind]] << 4;
        for(i = 0; i < 1000; i++);
    }
}


int main(void) {
	SystemInit(); //Add these two function for its internal operation
	SystemCoreClockUpdate();

	LPC_PINCON->PINSEL0 &= 0xFF0000FF; //Configure Port0 PINS P0.4-P0.11 as GPIO function
	LPC_PINCON->PINSEL3 &= 0xFFC03FFF; //P1.23 to P1.26
	LPC_GPIO0->FIODIR |= 0xFF0; //Configure P0.4-P0.11 as output port 
	LPC_GPIO1->FIODIR |= 0xF << 23;
	LPC_GPIO1->FIOPIN = 0;
	while(1) {
		for(i = 0; i < 1000; i++);
		display();
        if (value == 0)
            value = 10000;
		value = (value - 1);
	}
}
