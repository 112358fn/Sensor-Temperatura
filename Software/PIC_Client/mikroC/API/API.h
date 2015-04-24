#if !defined(_API_H)
#define _API_H

/******************
* Veriables
*******************/
unsigned char * API_frame; //Pointer to the generated API frame
unsigned char buf[100]; //Receiver Buffer
unsigned char ADC_channel_EN[4]={1,1,1,1};
unsigned char start_con;

/******************
* Functions
******************/
void 
init(void);
void
interrupt(void);
//Interrupt functions
void
send_AD_result(void);
void
read_ZB_frame(void);
//Other functions
int
receive_frame(unsigned char * buf);
void
actions(unsigned char * buf,unsigned char length);
void
send(unsigned char * buf, unsigned char len);
void
my_prescaler(void);
void
handshake(void);

/*******************
* Definitions
********************/
#define WAIT 2
#define channel0 do{ \
     ch=0;\
     PORTA.RA4=1;\
     ADCON0.CHS3 = 0;\
     ADCON0.CHS2 = 0;\
     ADCON0.CHS1 = 0;\
     ADCON0.CHS0 = 0;\
     }while(0)
#define channel1 do{ \
     ch=1;\
     PORTC.RC0=1;\
     ADCON0.CHS3 = 0;\
     ADCON0.CHS2 = 0;\
     ADCON0.CHS1 = 0;\
     ADCON0.CHS0 = 1;\
     }while(0)
#define channel2 do{ \
     ch=2;\
     PORTC.RC1=1;\
     ADCON0.CHS3 = 0;\
     ADCON0.CHS2 = 0;\
     ADCON0.CHS1 = 1;\
     ADCON0.CHS0 = 0;\
     }while(0)
#define channel4 do{ \
     ch=3;\
     PORTC.RC2=1;\
     ADCON0.CHS3 = 0;\
     ADCON0.CHS2 = 1;\
     ADCON0.CHS1 = 0;\
     ADCON0.CHS0 = 0;\
     }while(0)
#define turn_off_leds do{\
     PORTC.RC2=1;\
     PORTA.RA4=0;\
     PORTC.RC0=0;\
     PORTC.RC1=0;\
     PORTC.RC2=0;\
     }while(0)

#define enable_channel(buf) do{\
        if((buf)[1]=='1') ADC_channel_EN[0]=1;\
        else ADC_channel_EN[0]=0;\
        if((buf)[2]=='1') ADC_channel_EN[1]=1;\
        else ADC_channel_EN[1]=0;\
        if((buf)[3]=='1') ADC_channel_EN[2]=1;\
        else ADC_channel_EN[2]=0;\
        if((buf)[4]=='1') ADC_channel_EN[3]=1;\
        else ADC_channel_EN[3]=0;\
        }while(0)
        
#endif