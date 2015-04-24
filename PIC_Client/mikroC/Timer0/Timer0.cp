#line 1 "C:/Users/Alvaro/Documents/mikroC/Timer0/Timer0.c"


void init(void){



TRISA = 0;

TRISC.RC0 = 0;
TRISC.RC1 = 0;

T0CON.TMR0ON = 0;
T0CON.T08BIT = 0;
T0CON.T0CS = 0;
T0CON.T0SE = 0;
T0CON.PSA = 0;
T0CON.T0PS2 = 1;
T0CON.T0PS1 = 0;
T0CON.T0PS0 = 0;

INTCON.GIE = 1;
INTCON.PEIE = 0;
INTCON.INT0IE = 0;
INTCON.TMR0IE = 1;
}


void interrupt(void){

INTCON.TMR0IE = 0;

if(INTCON.TMR0IF){

 PORTA.RA0 = PORTA.RA0 > 0 ? 0:1;
}

INTCON.TMR0IF = 0;

INTCON.TMR0IE = 1;
}


void main(){
init();

T0CON.TMR0ON = 1;
PORTB=0xff;
while(1){};
}
