#include <LPC17xx.h>

int main(void) {
    unsigned int value = 0x10, i, j, type = 0;
    SystemInit();
    SystemCoreClockUpdate();

    LPC_PINCON->PINSEL0 = 0xFFFF00FF; //P0.4 to P0.7 GPIO
    LPC_GPIO0->FIODIR = 0x000000F0; //P0.4 to P0.7 output

    LPC_PINCON->PINSEL4 &= 0xF0FFFFFF; //Configure Port2 PIN P2.12 and P2.13 as GPIO function
	LPC_GPIO2->FIODIR &= ~(1 << 12); //Configure pin 12 for input

    while(1) {

        if ((LPC_GPIO2->FIOPIN & (1 << 12)) == 0) {
            if (type == 0)
                type = 1;
            else
                type = 0;
        }

        if (type == 0) {
            //clockwise
            for(i = 0; i < 200; i++) {
                LPC_GPIO0->FIOPIN = value;
                value <<= 1;
                if (value == 0x100)
                    value = 0x10;

                for(j = 0; j < 3000; j++);
            }
        }
        else {
                    //anticlockwise
            value = (1 << 7);

            for(j = 0; j < 10000; j++);

            for(i = 0; i < 200; i++) {
                LPC_GPIO0->FIOPIN = value;
                value >>=1;
                if (value == (1 << 3))
                    value = (1 << 7);

                for(j = 0; j < 3000; j++);
            }
        }
    }
}