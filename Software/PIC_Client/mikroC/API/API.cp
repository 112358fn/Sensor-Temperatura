#line 1 "C:/Users/Alvaro/Documents/mikroC/API/API.c"
#line 1 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
#line 20 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
unsigned char addr64[]= {0,0x13,0xA2,0,0x40,0xA8,0xB9,0x30};
unsigned char addr16[]= {0xFF,0xFE};
#line 145 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
typedef struct DATA_frame {
 unsigned char cmdID;
 unsigned char * cmdData;
 unsigned int length;
}data_frame;


typedef struct API_frame {
 unsigned char start_delimiter;
 data_frame * my_data;
 unsigned char checksum;
}api_frame;


typedef struct zigbeee_struct {
 unsigned char address[8];
 unsigned char network[2];
 unsigned char string[0x10];
 unsigned char parent[2];
 unsigned char devicetype;
}zigbee;


typedef struct atcmd_struct {
 unsigned char frameID;
 unsigned char AT[2];
 unsigned char * parameters;
 int para_len;
 unsigned char *(*request)(unsigned char *,unsigned char);
}atcmd;


typedef struct zbtr_struct {
 unsigned char frameID;
 unsigned char * addr64;
 unsigned char * addr16;
 unsigned char broadcast;
 unsigned char options;
 unsigned char * RFdata;
 unsigned char RFdata_len;
 unsigned char *(*request)(unsigned char *,unsigned char);
}zbtr;

typedef struct ratcmd_struct {
 unsigned char frameID;
 unsigned char * addr64;
 unsigned char * addr16;
 unsigned char options;
 unsigned char AT[2];
 unsigned char * parameters;
 unsigned char para_len;
 unsigned char *(*request)(unsigned char *,unsigned char);
}ratcmd;




extern zbtr _zbtr;
extern atcmd _atcmd;
extern ratcmd _ratcmd;
extern data_frame my_data;
#line 228 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
unsigned char
API_frame_length(unsigned char * API_frame);
unsigned char
API_frame_checksum(unsigned char * API_frame);



atcmd *
ATCMD_init(void);
unsigned char *
ATCMD_request(unsigned char * AT_n_parameters, unsigned char len);


zbtr *
ZBTR_init(unsigned char * addr64, unsigned char * addr16);
unsigned char *
ZBTR_request(unsigned char * rfdat, unsigned char len);



ratcmd *
RATCMD_init(unsigned char * addr64, unsigned char * addr16);
unsigned char *
RATCMD_request(unsigned char * RAT_n_parameters, unsigned char len);
#line 257 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
unsigned char
API_frame_is_correct(unsigned char * buf,unsigned int n);
#line 263 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
api_frame *
API_frame_decode(unsigned char * buf,unsigned int n);
data_frame *
decode_API_frame(unsigned char * buf,unsigned int n);



unsigned char
get_AT_response_frameid(data_frame * my_data);
void
get_AT_response_name(data_frame * my_data, unsigned char* name);
unsigned char
get_AT_response_status(data_frame * my_data);
unsigned char
get_AT_response_data_length(unsigned int length);
#line 286 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
unsigned char
get_ZBTR_status_frameid(data_frame * my_data);
void
get_ZBTR_status_address16(data_frame * my_data, unsigned char * address);
unsigned char
get_ZBTR_status_retrycount(data_frame * my_data);
unsigned char
get_ZBTR_status_deliveryST(data_frame * my_data);
unsigned char
get_ZBTR_status_discoveryST(data_frame * my_data);



void
get_ZBRCV_packet_address64(data_frame * my_data, unsigned char* address);
void
get_ZBRCV_packet_address16(data_frame * my_data, unsigned char* address);
unsigned char
get_ZBRCV_packet_options(data_frame * my_data);
unsigned char
get_ZBRCV_packet_data_length(data_frame * my_data);

unsigned char
get_ZBRCV_packet_data(data_frame * my_data, unsigned char * buf);
#line 317 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
zigbee *
NODE_id_decode(data_frame * my_data);

void
get_NODE_id_source_addr64(data_frame * my_data, unsigned char* address);
void
get_NODE_id_source_addr16(data_frame * my_data, unsigned char* address);
unsigned char
get_NODE_id_options(data_frame * my_data);
unsigned char
get_NODE_id_event(data_frame * my_data);


void
get_RAT_response_addr64(data_frame * my_data, unsigned char* address);
void
get_RAT_response_addr16(data_frame * my_data, unsigned char* address);
void
get_RAT_response_name(data_frame * my_data, unsigned char* name);
unsigned char
get_RAT_response_status(data_frame * my_data);
unsigned char
get_RAT_response_data_length(unsigned int length);
#line 1 "c:/users/alvaro/documents/mikroc/api/api.h"
#line 7 "c:/users/alvaro/documents/mikroc/api/api.h"
unsigned char * API_frame;
unsigned char buf[100];
unsigned char ADC_channel_EN[4]={1,1,1,1};
unsigned char start_con;
#line 15 "c:/users/alvaro/documents/mikroc/api/api.h"
void
init(void);
void
interrupt(void);

void
send_AD_result(void);
void
read_ZB_frame(void);

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
#line 3 "C:/Users/Alvaro/Documents/mikroC/API/API.c"
volatile unsigned char ch=0,connect= 0 , zigbee_id=0;
volatile unsigned int presc=0,sample_time=10;

void main(void){
 init();
 delay_ms(200);
 connect= 0 ;
 T0CON.TMR0ON = 1;
 while(1){}
 return;
}


void
send_AD_result(void){
 char buffer[4];


 buffer[0]=zigbee_id;
 buffer[1]=ch;
 buffer[2]=ADRESH;
 buffer[3]=ADRESL;

 send(buffer,4);

  do{ PORTC.RC2=1; PORTA.RA4=0; PORTC.RC0=0; PORTC.RC1=0; PORTC.RC2=0; }while(0) ;
 ch++;
 if(ch>=4)ch=0;
 switch(ch){
 case 0:if(ADC_channel_EN[0]){ do{ ch=0; PORTA.RA4=1; ADCON0.CHS3 = 0; ADCON0.CHS2 = 0; ADCON0.CHS1 = 0; ADCON0.CHS0 = 0; }while(0) ;break;}
 case 1:if(ADC_channel_EN[1]){ do{ ch=1; PORTC.RC0=1; ADCON0.CHS3 = 0; ADCON0.CHS2 = 0; ADCON0.CHS1 = 0; ADCON0.CHS0 = 1; }while(0) ;break;}
 case 2:if(ADC_channel_EN[2]){ do{ ch=2; PORTC.RC1=1; ADCON0.CHS3 = 0; ADCON0.CHS2 = 0; ADCON0.CHS1 = 1; ADCON0.CHS0 = 0; }while(0) ;break;}
 case 3:if(ADC_channel_EN[3]){ do{ ch=3; PORTC.RC2=1; ADCON0.CHS3 = 0; ADCON0.CHS2 = 1; ADCON0.CHS1 = 0; ADCON0.CHS0 = 0; }while(0) ;break;}
 else if(ADC_channel_EN[0]){ do{ ch=0; PORTA.RA4=1; ADCON0.CHS3 = 0; ADCON0.CHS2 = 0; ADCON0.CHS1 = 0; ADCON0.CHS0 = 0; }while(0) ;break;}
 }
 return;
}

void
read_ZB_frame(void){
 int length;

 if(RCREG == 0x7E)length=receive_frame(buf);
 else return;

 if(decode_API_frame(buf,length)!= ((void*)0) ){

 switch(my_data.cmdID){

 case  0x90 :
 length=get_ZBRCV_packet_data(&my_data,buf);
 actions(buf, length);
 break;
 case  0x88 :
 if(get_AT_response_status(&my_data)== 0 ){}
 else {connect= 0 ;handshake();}
 default:break;

 }
 }
 return;

}

void
actions(unsigned char * buf, unsigned char length){
 switch(buf[0]){
 case 'S':
 if(length>=4){ do{ if((buf)[1]=='1') ADC_channel_EN[0]=1; else ADC_channel_EN[0]=0; if((buf)[2]=='1') ADC_channel_EN[1]=1; else ADC_channel_EN[1]=0; if((buf)[3]=='1') ADC_channel_EN[2]=1; else ADC_channel_EN[2]=0; if((buf)[4]=='1') ADC_channel_EN[3]=1; else ADC_channel_EN[3]=0; }while(0) ;
 send("SOK",3);
 }
 break;
 case 'T':
 if(length>=3){sample_time=((buf[1]<<8)|buf[2]);
 send("TOK",3);
 }
 break;
 case 'H':
 if(length>=2){
 zigbee_id=buf[1];
 connect= 1 ;
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

 TRISC = 0b11000000;
 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC4 = 0;
 PORTC.RC5 = 0;
 UART1_Init(9600);
 BAUDCON.TXCKP = 1;
 BAUDCON.RXDTP = 1;
 Delay_ms(100);


 TRISA = 0b00101111;
 PORTA.RA4=0;

 ADCON1.VCFG1 = 0;
 ADCON1.VCFG0 = 1;
 ADCON1.PCFG3 = 1;
 ADCON1.PCFG2 = 0;
 ADCON1.PCFG1 = 1;
 ADCON1.PCFG0 = 0;

  do{ ch=0; PORTA.RA4=1; ADCON0.CHS3 = 0; ADCON0.CHS2 = 0; ADCON0.CHS1 = 0; ADCON0.CHS0 = 0; }while(0) ;

 ADCON2.ACQT2 = 0;
 ADCON2.ACQT1 = 0;
 ADCON2.ACQT0 = 1;

 ADCON2.ADCS2 = 1;
 ADCON2.ADCS1 = 1;
 ADCON2.ADCS0 = 0;

 ADCON2.ADFM = 1;

 ADCON0.ADON = 1;

  do{ PORTC.RC2=1; PORTA.RA4=0; PORTC.RC0=0; PORTC.RC1=0; PORTC.RC2=0; }while(0) ;


 T0CON.TMR0ON = 0;
 T0CON.T08BIT = 0;
 T0CON.T0CS = 0;
 T0CON.T0SE = 0;
 T0CON.PSA = 0;
 T0CON.T0PS2 = 1;
 T0CON.T0PS1 = 0;
 T0CON.T0PS0 = 1;



 PIR1.ADIF = 0;
 PIR1.RCIF = 0;
 INTCON.TMR0IF = 0;

 PIE1.ADIE = 1;
 PIE1.RCIE = 1;

 IPR1.ADIP = 0;
 IPR1.RCIP = 1;
 INTCON.TMR0IP = 0;

 RCON.IPEN = 1;

 INTCON.GIEH = 1;
 INTCON.GIEL = 1;
 INTCON.TMR0IE = 1;


 ATCMD_init();
 ZBTR_init(addr64,addr16);
 RATCMD_init(addr64,addr16);

 return;
}


void
interrupt(void){
 int i, sum=0;


 if(INTCON.TMR0IF){

 INTCON.TMR0IE = 0;

 if(connect!= 1 )handshake();
 else if(connect== 1 ){

 for(i=0;i<4;i++)sum+=ADC_channel_EN[i];
 if(sum==0)ADCON0.GO=0;
 else my_prescaler();
 }

 INTCON.TMR0IF = 0;

 INTCON.TMR0IE = 1;
 return;
 }


 if(PIR1.ADIF){

 INTCON.GIEL = 0;

 send_AD_result();

 PIR1.ADIF = 0;

 INTCON.GIEL = 1;
 return;
 }


 if(PIR1.RCIF){

 INTCON.GIEH = 0;

 read_ZB_frame();

 PIR1.RCIF = 0;

 INTCON.GIEH = 1;
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
my_prescaler(void){
 presc++;
 if(presc>=(sample_time*100/84)){
 ADCON0.GO = 1;
 presc=0;}
 return;
}

void
handshake(void){
 int i;
 unsigned char buf[3];
 _atcmd;
 if(connect== 0 ){
 buf[0]='C';
 buf[1]='B';
 buf[2]=1;
 API_frame=_atcmd.request(buf,3);
 for(i=0;i<API_frame_length(API_frame); i++)
 UART1_Write(API_frame[i]);
 connect= 2 ;
 }
 else if(connect== 2 ){
 presc++;
 if(presc>=10){
 connect =  0 ;
 presc=0;}
 }


}
