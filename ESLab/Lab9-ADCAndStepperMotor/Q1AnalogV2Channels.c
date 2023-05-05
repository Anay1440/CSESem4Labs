#include <LPC17xx.h>
#include <stdio.h>

#define Ref_Vtg 3.300
#define Full_Scale 0xFFF // 12 bit ADC

void delay_lcd(unsigned int r1) {
    unsigned int r;
    for(r=0;r<r1;r++);
    return;
}

void clear_ports(void) {
    /* Clearing the lines at power on */
    LPC_GPIO0->FIOCLR = 0x0F<<23; //Clearing data lines
    LPC_GPIO0->FIOCLR = 1<<27; //Clearing RS line
    LPC_GPIO0->FIOCLR = 1<<28; //Clearing Enable line
    
    return;
}

void write(int temp2, int type) { 
    clear_ports();
    LPC_GPIO0->FIOPIN = temp2; // Assign the value to the data lines 
    if(type==0)
        LPC_GPIO0->FIOCLR = 1<<27; // clear bit RS for Command
    else
        LPC_GPIO0->FIOSET = 1<<27; // set bit RS for Data
    LPC_GPIO0->FIOSET = 1<<28; // EN=1
    delay_lcd(25);
    LPC_GPIO0->FIOCLR = 1<<28; // EN =0
    return;
}

void lcd_comdata(int temp1, int type) {
    int temp2 = temp1 & 0xF0; //move data (26-8+1) times : 26 - HN place, 4 - Bits
    temp2 = temp2 << 19; //data lines from 23 to 26
    write(temp2, type);
    temp2 = temp1 & 0x0F; //26-4+1
    temp2 = temp2 << 23; 
    write(temp2, type);
    delay_lcd(1000);
    return;
}

void lcd_puts(unsigned char *buf1) {
    unsigned int i=0;
    unsigned int temp3;
    while(buf1[i]!='\0') {
        temp3 = buf1[i];
        lcd_comdata(temp3, 1);
        i++;
        if(i==16) {
            lcd_comdata(0xc0, 0);
        }
    }
    return;
}

void lcd_init() {
    /*Ports initialized as GPIO */
    LPC_PINCON->PINSEL1 &= 0xFC003FFF; //P0.23 to P0.28
    /*Setting the directions as output */
    LPC_GPIO0->FIODIR |= 0x0F<<23 | 1<<27 | 1<<28;
 
    clear_ports();
    delay_lcd(3200);
    lcd_comdata(0x33, 0); 
    delay_lcd(30000); 
    lcd_comdata(0x32, 0);
    delay_lcd(30000);
    lcd_comdata(0x28, 0); //function set
    delay_lcd(30000);
    lcd_comdata(0x0c, 0);//display on cursor off
    delay_lcd(800);
    lcd_comdata(0x06, 0); //entry mode set increment cursor right
    delay_lcd(800);
    lcd_comdata(0x01, 0); //display clear
    delay_lcd(10000);
    return;
}

int main(void)
{
    unsigned long adc_temp1, adc_temp2;
    unsigned int i;
    float in_vtg1, in_vtg2;
    unsigned char vtg1[7], vtg2[7];
    unsigned char Msg3[6] = {"CH 4: "};
    unsigned char Msg4[6] = {"CH 5: "};
    SystemInit();
    SystemCoreClockUpdate();
    LPC_SC->PCONP |= (1 << 15); // Power for GPIO block
    lcd_init();
    LPC_PINCON->PINSEL3 |= 0x30000000; // P1.30 as AD0.4
    LPC_PINCON->PINSEL3 |= 0xC0000000; // P1.31 as AD0.5
    LPC_SC->PCONP |= (1 << 12);        // enable the peripheral ADC
    SystemCoreClockUpdate();
    lcd_comdata(0x80, 0);
    delay_lcd(800);
    lcd_puts(&Msg3[0]);
    lcd_comdata(0xC0, 0);
    delay_lcd(800);
    lcd_puts(&Msg4[0]);
    LPC_ADC->ADCR = (1 << 4) | (1 << 5) | (1 << 21) | (1 << 16);
    while (1)
    {
        while (!(LPC_ADC->ADDR5 & (1 << 31)));
        // wait till 'done' bit is 1, indicates conversion complete
        adc_temp1 = LPC_ADC->ADDR4;
        adc_temp1 >>= 4;
        adc_temp1 &= 0xFFF;
        adc_temp2 = LPC_ADC->ADDR5;
        adc_temp2 >>= 4;
        adc_temp2 &= 0x00000FFF; // 12 bit ADC
        in_vtg1 = (((float)adc_temp1 * (float)Ref_Vtg)) / ((float)Full_Scale);
        in_vtg2 = (((float)adc_temp2 * (float)Ref_Vtg)) / ((float)Full_Scale);
        // calculating input analog voltage
        sprintf(vtg1, "%3.2fV", in_vtg1);
        sprintf(vtg2, "%3.2fV", in_vtg2);
        for (i = 0; i < 2000; i++);
        lcd_comdata(0x89, 0);
        delay_lcd(800);
        lcd_puts(&vtg1[0]);
        lcd_comdata(0xC8, 0);
        delay_lcd(800);
        lcd_puts(&vtg2[0]);
        for (i = 0; i < 200000; i++);
        for (i = 0; i < 7; i++)
            vtg1[i] = vtg2[i] = 0;
        adc_temp1 = 0;
        in_vtg1 = 0;
        adc_temp2 = 0;
        in_vtg2 = 0;
    }
}