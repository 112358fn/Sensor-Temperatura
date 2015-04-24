#include "Zigbee_API_Simple.h"
#include "API.h"
volatile unsigned char ch=0,connect=FALSE, zigbee_id=0;
volatile unsigned int presc=0,sample_time=10;

void main(void){
     init();
     delay_ms(200);
     connect=FALSE;
     T0CON.TMR0ON = 1; //Start timer0
     while(1){}
     return;
}


void
send_AD_result(void){
    char buffer[4];
    
    //Read A/D result
    buffer[0]=zigbee_id;
    buffer[1]=ch;
    buffer[2]=ADRESH;
    buffer[3]=ADRESL;
    //Send Transmit request
    send(buffer,4);
    //Change ennable Channel
    turn_off_leds;
    ch++;
    if(ch>=4)ch=0;
    switch(ch){
     case 0:if(ADC_channel_EN[0]){channel0;break;}
     case 1:if(ADC_channel_EN[1]){channel1;break;}
     case 2:if(ADC_channel_EN[2]){channel2;break;}
     case 3:if(ADC_channel_EN[3]){channel4;break;}
            else if(ADC_channel_EN[0]){channel0;break;}
    }
    return;
}

void
read_ZB_frame(void){
    int length;
    //Start indicator
    if(RCREG == 0x7E)length=receive_frame(buf);
    else return;
    //Try to decode
    if(decode_API_frame(buf,length)!=NULL){
       //Use the information
       switch(my_data.cmdID){
       //Received data
       case ZBRECVPCK:
            length=get_ZBRCV_packet_data(&my_data,buf);
            actions(buf, length);
            break;
       case ATRESPONSE:
            if(get_AT_response_status(&my_data)==ATOK){}
            else {connect=FALSE;handshake();}
       default:break;
            
       }
    }
    return;

}

void
actions(unsigned char * buf, unsigned char length){
    switch(buf[0]){
      case 'S': //Set channel to ennable
         if(length>=4){enable_channel(buf);
            send("SOK",3);
            }
         break;
      case 'T'://Set sample time in sec
        if(length>=3){sample_time=((buf[1]<<8)|buf[2]);
            send("TOK",3);
            }
        break;
      case 'H'://Handshake
        if(length>=2){
            zigbee_id=buf[1];
            connect=TRUE;
            send("HOK",3);
            }
        break;
      default:
         send("Received something else",23);
         break;
    }
    return;
}



void
init(void){
     //EUART init
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

     //ADC
     TRISA = 0b00101111;
     PORTA.RA4=0;
     //  Configure analog pins, voltage reference and digital I/O (ADCON1)
     ADCON1.VCFG1 = 0;//VSS REFERENCE
     ADCON1.VCFG0 = 1;//AN3 REFERENCE
     ADCON1.PCFG3 = 1;//AN0-4 analog input
     ADCON1.PCFG2 = 0;
     ADCON1.PCFG1 = 1;
     ADCON1.PCFG0 = 0;
     //  Select A/D input channel (ADCON0)
     channel0;
     //  Select A/D acquisition time (ADCON2)
     ADCON2.ACQT2 = 0; //2Tad
     ADCON2.ACQT1 = 0;
     ADCON2.ACQT0 = 1;
     //  Select A/D conversion clock (ADCON2)
     ADCON2.ADCS2 = 1; //64Tosc
     ADCON2.ADCS1 = 1;
     ADCON2.ADCS0 = 0;
     // A/D Result Format Select bit
     ADCON2.ADFM = 1;
     //  Turn on A/D module (ADCON0)
     ADCON0.ADON = 1;
     //Turn off indicator LEDs
     turn_off_leds;

     //Timer 0
     T0CON.TMR0ON = 0; //Off
     T0CON.T08BIT = 0; //16 bit
     T0CON.T0CS = 0;//Internal instruction cycle clock (CLKO)
     T0CON.T0SE = 0;//Rising Edge
     T0CON.PSA = 0;//Timer0 clock input comes from prescaler output.
     T0CON.T0PS2 = 1; //Prescaler 64
     T0CON.T0PS1 = 0;
     T0CON.T0PS0 = 1;
     //In sec=50ns*256*2^16*4=0.84s
    //Interrupts
    //  PERIPHERAL INTERRUPT REQUEST
    PIR1.ADIF = 0;//Clear A/D Conversion Flag
    PIR1.RCIF = 0;//The EUSART receive buffer(RCREG) is empty
    INTCON.TMR0IF = 0;//TMR0 register did not overflow
    //  PERIPHERAL INTERRUPT ENABLE
    PIE1.ADIE = 1;//Enables the A/D interrupt
    PIE1.RCIE = 1;//Enables the EUSART receive interrupt
    //   PERIPHERAL INTERRUPT PRIORITY REGISTER
    IPR1.ADIP = 0;//A/D Converter Interrupt Priority bit LOW
    IPR1.RCIP = 1;//EUSART Receive Interrupt Priority bit HIGH
    INTCON.TMR0IP = 0;//TMR0 Overflow Interrupt Priority bit LOW
    //   RESET CONTROL REGISTER
    RCON.IPEN = 1;//Enable priority levels on interrupts
    //   INTERRUPT CONTROL REGISTER
    INTCON.GIEH = 1;//Enables all high-priority interrupts
    INTCON.GIEL = 1;//Enables all low-priority peripheral interrupts (if GIE/GIEH = 1)
    INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable

    //API Frame functions
    ATCMD_init();//AT commands structure to generate API frames
    ZBTR_init(addr64,addr16);//Transmit structure to generate API frames
    RATCMD_init(addr64,addr16);//Remote AT to generate API frames

    return;
}


void
interrupt(void){
     int i, sum=0;
     
   //Verify Timer0 Overfload Flag
  if(INTCON.TMR0IF){
    // Disable Timer0 interrupts
    INTCON.TMR0IE = 0;//TMR0 Overflow Interrupt Enable
    //First start
    if(connect!=TRUE)handshake();
    else if(connect==TRUE){
      //No channel Enable
      for(i=0;i<4;i++)sum+=ADC_channel_EN[i];
      if(sum==0)ADCON0.GO=0;
      else my_prescaler();
      }
    //Clear Timer0 Overfload Flag
    INTCON.TMR0IF = 0;
    //Re-enable Timer0 interrupts
    INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
    return;
  }
  
  //Verify an A/D conversion completed
  if(PIR1.ADIF){
    //Disable A/D interrupts
    INTCON.GIEL = 0;//Disables all low-priority peripheral interrupts
    //Send the conversion result
    send_AD_result();
    //Clear A/D Conversion Flag
    PIR1.ADIF = 0;
    //Re-enable A/D interrupts
    INTCON.GIEL = 1;//Enables all low-priority peripheral interrupts
    return;
  }
  
  //Verify RC Euart reception
  if(PIR1.RCIF){
    //Disable RC interrupts
    INTCON.GIEH = 0;//Disables all interrupts
    //Read frame
    read_ZB_frame();
    //Clear RC Conversion Flag
    PIR1.RCIF = 0;
    //Re-enable RC interrupts
    INTCON.GIEH = 1;//Enables all high-priority interrupts
    return;
  }
 return;
}

int
receive_frame(unsigned char * buf){
     int i,length;
     buf[0]=0x7E;
     for(i=1;i<3;i++){
        while(!UART1_Data_Ready()){};
        buf[i]=UART_Read();
     }
     length=(((unsigned int)buf[1])<< 8)|((unsigned int)buf[2]);
     for(i=3;i<length+4;i++){
        while(!UART1_Data_Ready()){}
        buf[i]=UART_Read();
     }
     return length+4;
}

void
send(unsigned char * buf, unsigned char len){
    int i;
    _zbtr;
    API_frame=_zbtr.request(buf,len);
    for(i=0;i<API_frame_length(API_frame); i++)
       UART1_Write(API_frame[i]);
}
void
my_prescaler(void){//Multiples of 0.84seconds
  presc++;
  if(presc>=(sample_time*100/84)){
    ADCON0.GO = 1;//RE-Start Conversion
    presc=0;}
  return;
}
    
void
handshake(void){
     int i;
     unsigned char buf[3];
    _atcmd;
    if(connect==FALSE){
      buf[0]='C';
      buf[1]='B';
      buf[2]=1;
      API_frame=_atcmd.request(buf,3);
      for(i=0;i<API_frame_length(API_frame); i++)
         UART1_Write(API_frame[i]);
      connect=WAIT;
    }
    else if(connect==WAIT){
      presc++;
      if(presc>=10){
        connect = FALSE;//RE-Start Connection
       presc=0;}
    }
      
      
}
    /*while(1){
            while(!UART1_Data_Ready()){}
            if(RCREG == 0x7E){
               length=receive_frame(buf);
               data_=decode_API_frame(buf,n);
                   _zbtr;
                   API_frame=_zbtr.request((data_->cmdID),1);
                   for(i=0;i<API_frame_length(API_frame); i++)
                      UART1_Write(API_frame[i]);
            }

            if(RCREG == 'A'){
                 zbtr_;
                 API_frame=zbtr_->request("FUNCIONA?",9);
            }
            else if(RCREG == 'B'){
                 atcmd_;
                 API_frame=atcmd_->request("IDHOLA",6);
            }
            else{
                 ratcmd_;
                 API_frame=ratcmd_->request("IDHOLA",6);
            }
            for(i=0;i<API_frame_length(API_frame); i++)
                 UART1_Write(API_frame[i]);
     }*/