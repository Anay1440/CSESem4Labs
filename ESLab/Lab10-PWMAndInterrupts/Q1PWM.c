#include <LPC17xx.h>

unsigned char row, var, flag, key;
unsigned long int i, var1, temp, temp1, temp2, temp3;
unsigned char SCAN_CODE[4] = {0x11, 0x21, 0x41, 0x81};

void delay(unsigned int r1) {
    unsigned int r;
    for(r=0;r<r1;r++);
    return;
}

void initPWM(void) {
    LPC_PINCON->PINSEL3 |= 0x8000; //Select PWM1.4 output for Pin1.23, function 2
    LPC_PWM1->PCR = 0x1000; //enable PWM1.4, by default it is single Edged 
    LPC_PWM1->PR = 0; 
    LPC_PWM1->MR0 = 30000; //period=10ms if pclk=cclk/4
    LPC_PWM1->MCR = (1<<1); //Reset PWM TC on PWM1MR0 match
    LPC_PWM1->LER = 0xff; //update values in MR0 and MR1
    LPC_PWM1->TCR = 0x2; //RESET COUNTER TC and PC
    LPC_PWM1->TCR = 0x9; //enable TC and PC
}

void updatePulseWidth(unsigned int pulseWidth) {
    LPC_PWM1->MR4 = pulseWidth; //Update MR4 with new value
    LPC_PWM1->LER = 0xff; //Load the MR4 new value at start of next cycle
}

void scan(void) {
    temp3 = LPC_GPIO0->FIOPIN;
    temp3 &= (0xF << 15); //check if any key pressed in the enabled row .. checks bits 18 to 15
    if(temp3 != 0) {
        flag = 1;
        temp3 >>= 11;//Shifted to come at HN of byte (4 to 7 bits)
        temp >>= 19; //shifted to come at LN of byte (indicates row, 0 to 3 bits)
        key = temp3|temp; //get SCAN_CODE (0 to 7 bits)
    }
}//end scan

int main(void)
{
    int pulseWidths[] = {2700, 6750, 13500, 20250};
    // keyboard connected to CNC
    LPC_GPIO0->FIODIR |= (1 << 19); // made output P0.19 (row 0)
    LPC_GPIO0->FIODIR &= ~(0xF << 15); // made input P0.15 to 0.18(cols)
    initPWM(); //Initialize PWM
    updatePulseWidth(pulseWidths[3]);
    while (1) {
        while (1) {
            temp = 1 << 19;
            LPC_GPIO0->FIOSET = temp; //enabling the row
            flag = 0;
            scan(); // scan if any key pressed in the enabled row
             // end for
            if (flag == 1)
                break;
        }                        // 2nd while(1)
        for (i = 0; i < 4; i++) // get the ascii code for display
        {
            if (key == SCAN_CODE[i]) 
                updatePulseWidth(pulseWidths[i]);
        }  
    } // end while 1
} // end main
