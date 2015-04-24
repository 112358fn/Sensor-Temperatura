void main() {

  //TRISA = 0;           // set direction to be output
  TRISC.RC0 = 0;
  TRISC.RC1 = 0;
  

  while(1) {
    //PORTA = 0x00;       // Turn OFF LEDs on PORTA and C
    PORTC.RC0 = 1;
    PORTC.RC1 = 0;
    Delay_ms(1000);    // 1 second delay

    //PORTA = 0xff;       // Turn ON LEDs on PORTA and C
    PORTC.RC0 = 1;
    PORTC.RC1 = 1;
    Delay_ms(1000);    // 1 second delay
  }         // Endless loop

}