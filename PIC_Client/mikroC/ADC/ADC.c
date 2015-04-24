unsigned char data1[] = "You typed 'A'";
unsigned char data2[] = "You typed 'B'";
unsigned char uhOh[] = "I don't understand!";
unsigned char dataRx = 0;



void init(void){
  //EUART init
  TRISC = 0b11000000;
  UART1_Init(9600);
  BAUDCON.TXCKP = 1;
  Delay_ms(100);
  //ADC
  TRISA = 0b00001111;
  //  Configure analog pins, voltage reference and digital I/O (ADCON1)
  ADCON1.VCFG1 = 0;//VSS REFERENCE
  ADCON1.VCFG0 = 1;//AN3 REFERENCE
  ADCON1.PCFG3 = 1;//AN0-3 analog input
  ADCON1.PCFG2 = 0;
  ADCON1.PCFG1 = 1;
  ADCON1.PCFG0 = 1;
  //  Select A/D input channel (ADCON0)
  ADCON0.CHS3 = 0;  //Channel AN1
  ADCON0.CHS2 = 0;
  ADCON0.CHS1 = 0;
  ADCON0.CHS0 = 1;
  //  Select A/D acquisition time (ADCON2)
  ADCON2.ACQT2 = 0; //2Tad
  ADCON2.ACQT1 = 0;
  ADCON2.ACQT0 = 1;
  //  Select A/D conversion clock (ADCON2)
  ADCON2.ADCS2 = 1; //16Tosc
  ADCON2.ADCS1 = 0;
  ADCON2.ADCS0 = 1;
  // A/D Result Format Select bit
  ADCON2.ADFM = 1;
  //  Turn on A/D module (ADCON0)
  ADCON0.ADON = 1;
//Interrupts
  //  PERIPHERAL INTERRUPT REQUEST
  PIR1.ADIF = 0;//Clear A/D Conversion Flag
  //  PERIPHERAL INTERRUPT ENABLE
  PIE1.ADIE = 1;//Enables the A/D interrupt
  //   INTERRUPT CONTROL REGISTER
  INTCON.GIE = 1;//Global Interrupt Enable
  INTCON.PEIE = 1;//Peripheral Interrupt Enable
  
return;
}

void interrupt(void){
char buffer[6];
//Verify an A/D conversion completed
if(PIR1.ADIF){
  // Disable A/D interrupts
  PIE1.ADIE = 0;
  //Read A/D result
// ADRESH<<8)+ADRESL);
//ADC_Get_Sample(0)
  WordToStr(ceil(((ADRESH<<8)+ADRESL)*1.25), buffer);
  UART1_Write_Text(buffer);
  UART1_Write(13);
  UART1_Write(10);
  delay_ms(2000);
    //Clear A/D Conversion Flag
  PIR1.ADIF = 0;
  //Re-enable A/D interrupts
  PIE1.ADIE = 1;//Enables the A/D interrupt
  //RE-Start Conversion
  ADCON0.GO = 1;
}
 return;
}




void main(void)
{
//Initializations
  init();
  delay_ms(2000);
//Start Conversion
   ADCON0.GO = 1;
  while(1){}
  return;
}