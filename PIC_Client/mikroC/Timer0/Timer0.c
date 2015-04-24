// Timer0

void init(void){
// Initialize PIC: Configuration
//OSCCON = 0x61;
//Port A
TRISA = 0;
//Port C
TRISC.RC0 = 0;
TRISC.RC1 = 0;
//Timer 0
T0CON.TMR0ON = 0; //Off
T0CON.T08BIT = 0; //16 bit
T0CON.T0CS = 0;//Internal instruction cycle clock (CLKO)
T0CON.T0SE = 0;//Rising Edge
T0CON.PSA = 0;//Timer0 clock input comes from prescaler output.
T0CON.T0PS2 = 1; //Prescaler 32
T0CON.T0PS1 = 0;
T0CON.T0PS0 = 0;
//Interrupts
INTCON.GIE = 1;//Global Interrupt Enable
INTCON.PEIE = 0;//Peripheral Interrupt Disable
INTCON.INT0IE = 0;//INT0 External Interrupt Disable
INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
}


void interrupt(void){
// Disable Timer0 interrupts
INTCON.TMR0IE = 0;//TMR0 Overflow Interrupt Enable
//Verify Timer0 Overfload Flag
if(INTCON.TMR0IF){
  //PORTA.RA0 = ~ PORTA.RA0;
   PORTA.RA0 =  PORTA.RA0 > 0 ? 0:1;
}
//Clear Timer0 Overfload Flag
INTCON.TMR0IF = 0;
//Re-enable Timer0 interrupts
INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
}


void main(){
init();
//Start timer0
T0CON.TMR0ON = 1; //On
PORTB=0xff;
while(1){};
}