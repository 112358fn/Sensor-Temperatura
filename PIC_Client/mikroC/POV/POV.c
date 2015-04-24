// Timer0

int  _A[] = { 8,
 0b11000000,
 0b01110000,
 0b00101100,
 0b00100111,
 0b00111000,
 0b11100000,
 0b10000000,
 0b00000000,
};
int  _B[] = { 6,
 0b11111110,
 0b10010010,
 0b10010010,
 0b10010010,
 0b01111100,
 0b00000000,
};
int  _C[] = { 8,
 0b00010000,
 0b01101100,
 0b10000010,
 0b10000010,
 0b10000010,
 0b11000110,
 0b01000100,
 0b00000000,
};
int  _D[] = { 7,
 0b11111110,
 0b10000010,
 0b10000010,
 0b10000010,
 0b01000110,
 0b00111000,
 0b00000000,
};
int  _E[] = { 6,
 0b11111110,
 0b10010010,
 0b10010010,
 0b10010010,
 0b10010010,
 0b00000000,
};
int  _F[] = { 6,
 0b11111110,
 0b00010010,
 0b00010010,
 0b00010010,
 0b00000010,
 0b00000000,
};
int  _G[] = { 8,
 0b00010000,
 0b01111100,
 0b10000010,
 0b10000010,
 0b10010010,
 0b10010010,
 0b01110100,
 0b00000000,
};
int  _H[] = { 7,
 0b11111110,
 0b00010000,
 0b00010000,
 0b00010000,
 0b11111110,
 0b11111110,
 0b00000000,
};
int  _I[] = { 2,
 0b11111110,
 0b00000000,
};
int  _J[] = { 5,
 0b01000000,
 0b10000000,
 0b10000000,
 0b11111110,
 0b00000000,
};
int  _K[] = { 7,
 0b11111110,
 0b00010000,
 0b00011000,
 0b00100100,
 0b11000010,
 0b10000000,
 0b00000000,
};
int  _L[] = { 5,
 0b11111110,
 0b10000000,
 0b10000000,
 0b10000000,
 0b00000000,
};
int  _M[] = { 8,
 0b11111110,
 0b00011100,
 0b11100000,
 0b11000000,
 0b00111000,
 0b00011110,
 0b11111110,
 0b00000000,
};
int  _N[] = { 7,
 0b11111110,
 0b00001100,
 0b00011000,
 0b01100000,
 0b11111110,
 0b11111110,
 0b00000000,
};
int  _O[] = { 8,
 0b00010000,
 0b01101100,
 0b10000010,
 0b10000010,
 0b10000010,
 0b11000110,
 0b01111100,
 0b00000000,
};
int  _P[] = { 6,
 0b11111110,
 0b00010010,
 0b00010010,
 0b00010010,
 0b00011110,
 0b00000000,
};
int  _Q[] = { 9,
 0b00111000,
 0b01101100,
 0b10000010,
 0b10000010,
 0b11000010,
 0b11000110,
 0b11111100,
 0b10000000,
 0b00000000,
};
int  _R[] = { 7,
 0b11111110,
 0b00010010,
 0b00010010,
 0b00110010,
 0b11011110,
 0b10000000,
 0b00000000,
};
int  _S[] = { 7,
 0b01000000,
 0b11001110,
 0b10010010,
 0b10010010,
 0b10010010,
 0b01100100,
 0b00000000,
};
int  _T[] = { 7,
 0b00000010,
 0b00000010,
 0b00000010,
 0b11111110,
 0b00000010,
 0b00000010,
 0b00000000,
};
int  _U[] = { 7,
 0b01111110,
 0b10000000,
 0b10000000,
 0b10000000,
 0b11111110,
 0b00111110,
 0b00000000,
};
int  _V[] = { 8,
 0b00000010,
 0b00011100,
 0b01100000,
 0b11000000,
 0b00110000,
 0b00001110,
 0b00000010,
 0b00000000,
};
int  _W[] = { 11,
 0b00000110,
 0b00111100,
 0b11100000,
 0b11110000,
 0b00001110,
 0b00001110,
 0b11110000,
 0b11100000,
 0b00111110,
 0b00000010,
 0b00000000,
};
int  _X[] = { 7,
 0b10000010,
 0b01000110,
 0b00101100,
 0b00111000,
 0b01100100,
 0b11000010,
 0b00000000,
};
int  _Y[] = { 7,
 0b00000010,
 0b00000100,
 0b00011000,
 0b11110000,
 0b00001100,
 0b00000010,
 0b00000000,
};
int  _Z[] = { 7,
 0b10000001,
 0b11100011,
 0b10110011,
 0b10011011,
 0b10000111,
 0b10000011,
 0b00000000,
};

int  ss[] = { 6,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
};

//int* Msg[] = {_L,ss,_A,ss,_V,ss,_E,ss,_R,ss,_I,ss,_T,ss,_E,ss};
int* Msg[] = {_A,ss,_L,ss,_V,ss,_I,ss};
int MsgLen = 8;

unsigned char stateON=1;

void init(void){
// Initialize PIC: Configuration
//OSCCON = 0x61;
//Port A
TRISA.RA0 = 0;
TRISA.RA1 = 0;
TRISA.RA2 = 0;
TRISA.RA3 = 0;
TRISA.RA4 = 0;
TRISA.RA5 = 0;
//Port C
TRISC.RC0 = 0;
TRISC.RC1 = 0;
//Timer 0
T0CON.TMR0ON = 0; //Off
T0CON.T08BIT = 0; //16 bit
T0CON.T0CS = 0;//Internal instruction cycle clock (CLKO)
T0CON.T0SE = 0;//Rising Edge
T0CON.PSA = 0;//Timer0 clock input comes from prescaler output.
T0CON.T0PS2 = 0; //Prescaler 8
T0CON.T0PS1 = 1;
T0CON.T0PS0 = 0;
//Interrupts
INTCON.GIE = 1;//Global Interrupt Enable
INTCON.PEIE = 0;//Peripheral Interrupt Disable
INTCON.INT0IE = 0;//INT0 External Interrupt Disable
INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable

return;
}


void printLetter(int * letter){
  int i;
  for(i=1; i<letter[0]; i++){
   PORTA = letter[i] & 0x3F;
   PORTC = (letter[i]&0xC0)>>6;
   delay_ms(3);//Ancho letra
  }
  
return;
}

void interrupt(void){
int i;
// Disable Timer0 interrupts
INTCON.TMR0IE = 0;//TMR0 Overflow Interrupt Enable
//Verify Timer0 Overfload Flag
if(INTCON.TMR0IF){
  for(i=0; i<MsgLen; i++)printLetter(Msg[i]);
}
//Clear Timer0 Overfload Flag
INTCON.TMR0IF = 0;
//Re-enable Timer0 interrupts
INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
}



void main(){
int i;
init();
//Start timer0
T0CON.TMR0ON = 1; //On
while(1){};
return;
}