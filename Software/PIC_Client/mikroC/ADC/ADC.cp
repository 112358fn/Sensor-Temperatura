#line 1 "C:/Users/Alvaro/Documents/mikroC/ADC/ADC.c"
unsigned char data1[] = "You typed 'A'";
unsigned char data2[] = "You typed 'B'";
unsigned char uhOh[] = "I don't understand!";
unsigned char dataRx = 0;



void init(void){

 TRISC = 0b11000000;
 UART1_Init(9600);
 BAUDCON.TXCKP = 1;
 Delay_ms(100);

 TRISA = 0b00001111;

 ADCON1.VCFG1 = 0;
 ADCON1.VCFG0 = 1;
 ADCON1.PCFG3 = 1;
 ADCON1.PCFG2 = 0;
 ADCON1.PCFG1 = 1;
 ADCON1.PCFG0 = 1;

 ADCON0.CHS3 = 0;
 ADCON0.CHS2 = 0;
 ADCON0.CHS1 = 0;
 ADCON0.CHS0 = 1;

 ADCON2.ACQT2 = 0;
 ADCON2.ACQT1 = 0;
 ADCON2.ACQT0 = 1;

 ADCON2.ADCS2 = 1;
 ADCON2.ADCS1 = 0;
 ADCON2.ADCS0 = 1;

 ADCON2.ADFM = 1;

 ADCON0.ADON = 1;


 PIR1.ADIF = 0;

 PIE1.ADIE = 1;

 INTCON.GIE = 1;
 INTCON.PEIE = 1;

return;
}

void interrupt(void){
char buffer[6];

if(PIR1.ADIF){

 PIE1.ADIE = 0;



 WordToStr(ceil(((ADRESH<<8)+ADRESL)*1.25), buffer);
 UART1_Write_Text(buffer);
 UART1_Write(13);
 UART1_Write(10);
 delay_ms(2000);

 PIR1.ADIF = 0;

 PIE1.ADIE = 1;

 ADCON0.GO = 1;
}
 return;
}




void main(void)
{

 init();
 delay_ms(2000);

 ADCON0.GO = 1;
 while(1){}
 return;
}
