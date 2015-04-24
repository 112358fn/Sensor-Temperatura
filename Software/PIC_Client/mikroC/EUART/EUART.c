unsigned char data1[] = "You typed 'A'";
unsigned char data2[] = "You typed 'B'";
unsigned char uhOh[] = "I don't understand!";
unsigned char dataRx = 0;

void main(void)
{
     TRISC = 0b11000000;
     PORTC.RC0 = 0;
     PORTC.RC1 = 0;
     PORTC.RC2 = 0;
     PORTC.RC4 = 0;
     PORTC.RC5 = 0;
     
     UART1_Init(9600);
     BAUDCON.TXCKP = 1; //Tx Data is inverted
     BAUDCON.RXDTP = 1; //Rx Data is inverted
     Delay_ms(100);
     while(1){
            while(!UART1_Data_Ready()){}
            //UART1_Write_Text("Past PIR bit \n");
              //    UART1_Write(13);
                //  UART1_Write(10);
            dataRx = RCREG;
            if(dataRx == 0x41)   // "A"
            {
                  UART1_Write_Text(data1);
                  UART1_Write(13);
                  UART1_Write(10);
            }
            else if(dataRx == 0x42)    // "B"
            {
                  UART1_Write_Text(data2);
                  UART1_Write(13);
                  UART1_Write(10);
            }
            else
            {
                  UART1_Write_Text(uhOh);
                  UART1_Write(13);
                  UART1_Write(10);
            }
     }
}