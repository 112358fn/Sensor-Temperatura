#line 1 "C:/Users/Alvaro/Documents/mikroC/BlinkLed.c"
void main() {


 TRISC.RC0 = 0;
 TRISC.RC1 = 0;


 while(1) {

 PORTC.RC0 = 1;
 PORTC.RC1 = 0;
 Delay_ms(1000);


 PORTC.RC0 = 1;
 PORTC.RC1 = 1;
 Delay_ms(1000);
 }

}
