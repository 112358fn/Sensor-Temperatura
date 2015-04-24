#line 1 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
#line 1 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
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
#line 209 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
atcmd _atcmd;
zbtr _zbtr;
ratcmd _ratcmd;
data_frame my_data;
#line 219 "c:/users/alvaro/documents/mikroc/api/zigbee_api_simple.h"
static unsigned char cmdData[100];
static unsigned char frame[100];
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
#line 26 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
unsigned char
API_frame_length(unsigned char * API_frame){
#line 29 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
 return 4 +((((unsigned int)API_frame[1])<< 8)| ((unsigned int)API_frame[2]));
}
unsigned char
API_frame_checksum(unsigned char * API_frame){
 unsigned int checksum=0;
 unsigned char length;
 unsigned int i;

 length = API_frame_length(API_frame)-4;


 for (i=0; i<length ; i++)
 checksum+=API_frame[ 3 +i];


 return (0xFF)-(checksum & 0xFF);

}
#line 59 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
atcmd *
ATCMD_init(void){
 _atcmd.frameID= 0x1 ;
 _atcmd.AT[0]=0;
 _atcmd.AT[1]=0;
 _atcmd.parameters= ((void*)0) ;
 _atcmd.para_len=0;
 _atcmd.request=ATCMD_request;
 return &_atcmd;
}
unsigned char *
ATCMD_request(unsigned char * AT_n_parameters, unsigned char length){
 int i;


 _atcmd.AT[0]=AT_n_parameters[0];
 _atcmd.AT[1]=AT_n_parameters[1];
 _atcmd.parameters=(AT_n_parameters+2);
 _atcmd.para_len=length-2;



 frame[0] =  0x7e ;

 frame[1] = (( (( 4 )+(_atcmd.para_len)) )>>8)&0xFF;
 frame[2] = ( (( 4 )+(_atcmd.para_len)) ) & 0xFF;

 frame[3] =  0X08 ;

 frame[4] = _atcmd.frameID;

 frame[5] = _atcmd.AT[0];
 frame[6] = _atcmd.AT[1];

 if(_atcmd.para_len>0){
 for(i=0; i<_atcmd.para_len; i++)
 frame[7+i]=_atcmd.parameters[i];}

 frame[7+_atcmd.para_len] = API_frame_checksum(frame);

 return frame;
}
#line 123 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
zbtr *
ZBTR_init(unsigned char * addr64, unsigned char * addr16){

 _zbtr.frameID= 0x1 ;
 _zbtr.addr64=addr64;
 _zbtr.addr16=addr16;
 _zbtr.broadcast=0;
 _zbtr.options=0;
 _zbtr.RFdata= ((void*)0) ;
 _zbtr.RFdata_len=0;
 _zbtr.request=ZBTR_request;
 return &_zbtr;
}
unsigned char *
ZBTR_request(unsigned char * rfdata, unsigned char len){
 int i;

 _zbtr.RFdata=rfdata;
 _zbtr.RFdata_len=len;


 frame[0]= 0x7e ;

 frame[1] = (( (( 14 )+(_zbtr.RFdata_len)) )>>8)&0xFF;
 frame[2] = ( (( 14 )+(_zbtr.RFdata_len)) ) & 0xFF;

 frame[3] =  0x10 ;

 frame[4] = _zbtr.frameID;

 for(i=0; i<8; i++)frame[5+i] = _zbtr.addr64[i];

 frame[13] = _zbtr.addr16[0];
 frame[14] = _zbtr.addr16[1];

 frame[15] = _zbtr.broadcast;

 frame[16] = _zbtr.options;

 if(_zbtr.RFdata_len>0){
 for(i=0; i<_zbtr.RFdata_len; i++)
 frame[17+i]=_zbtr.RFdata[i];}

 frame[17+_zbtr.RFdata_len]= API_frame_checksum(frame);

 return frame;
}
#line 182 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
ratcmd *
RATCMD_init(unsigned char * addr64, unsigned char * addr16){
 _ratcmd.frameID= 0x1 ;
 _ratcmd.addr64=addr64;
 _ratcmd.addr16=addr16;
 _ratcmd.options=0;
 _ratcmd.AT[0]=0;
 _ratcmd.AT[1]=0;
 _ratcmd.parameters= ((void*)0) ;
 _ratcmd.para_len=0;
 _ratcmd.request=RATCMD_request;
 return &_ratcmd;
}
unsigned char *
RATCMD_request(unsigned char * RAT_n_parameters, unsigned char len){
 int i;

 _ratcmd.AT[0]=RAT_n_parameters[0];
 _ratcmd.AT[1]=RAT_n_parameters[1];
 _ratcmd.parameters=(RAT_n_parameters+2);
 _ratcmd.para_len=len-2;



 frame[0]= 0x7e ;

 frame[1] = (( (( 15 )+(_ratcmd.para_len)) )>>8)&0xFF;
 frame[2] = ( (( 15 )+(_ratcmd.para_len)) ) & 0xFF;

 frame[3] =  0x17 ;

 frame[4] = _ratcmd.frameid;

 for(i=0; i<8; i++)frame[5+i] = _ratcmd.addr64[i];

 frame[13] = _ratcmd.addr16[0];
 frame[14] = _ratcmd.addr16[1];

 frame[15] = _ratcmd.options;

 frame[16] = _ratcmd.AT[0];
 frame[17] = _ratcmd.AT[1];

 if(_ratcmd.para_len>0){
 for(i=0; i<_ratcmd.para_len; i++)
 frame[18+i]=_ratcmd.parameters[i];}

 frame[18+_ratcmd.para_len]= API_frame_checksum(frame);

 return frame;
}
#line 249 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
unsigned char
API_frame_is_correct(unsigned char * buf,unsigned int n){

 unsigned int i;
 unsigned int length;
 unsigned int checksum = 0;

 if(buf[0]!=0x7e)return 0;


 length=(((unsigned int)buf[1])<< 8)|((unsigned int)buf[2]);
 if(n<length+4)return 0;


 checksum+=buf[3];
 for(i=0; i < (length-1); i++)
 checksum += buf[4+i];

 checksum+=buf[length + 3];
 if((checksum&0xFF)!=0xFF)return 0;
 return 1;
}
#line 318 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
data_frame *
decode_API_frame(unsigned char * buf,unsigned int n)
{
 unsigned int i, length;
#line 323 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
 length=(((unsigned int)buf[1])<< 8)| ((unsigned int)buf[2]);

 if(!API_frame_is_correct(buf,n))return  ((void*)0) ;

 my_data.cmdData=cmdData;

 my_data.length = length;
 my_data.cmdID=buf[3];
 for(i=0; i < (length-1); i++)
 my_data.cmdData[i]=buf[4+i];

 return &my_data;
}
#line 352 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
unsigned char
get_AT_response_frameid(data_frame * my_data){
 return my_data->cmdData[0];
}
void
get_AT_response_name(data_frame * my_data, unsigned char* name){
 name[0]=my_data->cmdData[1];
 name[1]=my_data->cmdData[2];
 return;
}
unsigned char
get_AT_response_status(data_frame * my_data){
 return my_data->cmdData[3];
}
unsigned char
get_AT_response_data_length(unsigned int length){
 return (unsigned char)length-5;
}
unsigned char *
get_AT_response_data(data_frame * my_data){

 unsigned char length;
 unsigned char* cmdData= ((void*)0) ;
 unsigned int i;

 length = get_AT_response_data_length(my_data->length);
 if(length==0)return  ((void*)0) ;
 cmdData = (unsigned char*)malloc(length);
 if(cmdData== ((void*)0) ) return  ((void*)0) ;
 for(i=0; i<length; i++)cmdData[i]=my_data->cmdData[4+i];
 return cmdData;
}
#line 398 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
unsigned char
get_ZBTR_status_frameid(data_frame * my_data){
 return my_data->cmdData[0];
}
void
get_ZBTR_status_address16(data_frame * my_data, unsigned char* address){
 address[0]=my_data->cmdData[1];
 address[1]=my_data->cmdData[2];
 return;
}
unsigned char
get_ZBTR_status_retrycount(data_frame * my_data){
 return my_data->cmdData[3];
}
unsigned char
get_ZBTR_status_deliveryST(data_frame * my_data){
 return my_data->cmdData[4];
}
unsigned char
get_ZBTR_status_discoveryST(data_frame * my_data){
 return my_data->cmdData[5];
}
#line 431 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
void
get_ZBRCV_packet_address64(data_frame * my_data, unsigned char* address){
 int i;
 for(i=0; i<8; i++)
 address[i]=my_data->cmdData[i];
 return;
}
void
get_ZBRCV_packet_address16(data_frame * my_data, unsigned char* address){
 address[0]=my_data->cmdData[8];
 address[1]=my_data->cmdData[9];
 return;
}
unsigned char
get_ZBRCV_packet_options(data_frame * my_data){
 return my_data->cmdData[10];
}
unsigned char
get_ZBRCV_packet_data_length(data_frame * my_data){
 return my_data->length-12;
}

unsigned char
get_ZBRCV_packet_data(data_frame * my_data, unsigned char * buf){
 unsigned char length;
 unsigned int i;

 length = get_ZBRCV_packet_data_length(my_data);
 for(i=0; i<length; i++) buf[i]=my_data->cmdData[11+i];

 return length;
}
#line 492 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
zigbee *
NODE_id_decode(data_frame * my_data){

 unsigned int i;
 zigbee * zb_elem= ((void*)0) ;
 unsigned char length;


 zb_elem = (zigbee*) malloc(sizeof(zigbee));
 if( zb_elem==  ((void*)0) )return  ((void*)0) ;


 zb_elem->network[0]=my_data->cmdData[11];
 zb_elem->network[1]=my_data->cmdData[12];

 for(i=0; i<8; i++)zb_elem->address[i]=my_data->cmdData[13+i];


 length = strlen(&(my_data->cmdData[21]));

 length = (length > 15 ? 15 : length);
 for(i=0; i<length; i++) zb_elem->string[i]=my_data->cmdData[21+i];
 zb_elem->string[length]='\0';

 zb_elem->parent[0]=my_data->cmdData[22+length];
 zb_elem->parent[1]=my_data->cmdData[23+length];

 zb_elem->devicetype=my_data->cmdData[24+length];

 return zb_elem;
}


void
get_NODE_id_source_addr64(data_frame * my_data, unsigned char* address){
 int i;
 for(i=0; i<8; i++)
 address[i]=my_data->cmdData[i];
 return;
}
void
get_NODE_id_source_addr16(data_frame * my_data, unsigned char* address){
 address[0]=my_data->cmdData[8];
 address[1]=my_data->cmdData[9];
 return;
}
unsigned char
get_NODE_id_options(data_frame * my_data){
 return my_data->cmdData[10];
}
unsigned char
get_NODE_id_event(data_frame * my_data){
 return my_data->cmdData[my_data->length-6];
}
#line 562 "C:/Users/Alvaro/Documents/mikroC/API/Zigbee_API_Simple.c"
void
get_RAT_response_addr64(data_frame * my_data, unsigned char* address){
 int i;
 for(i=0; i<8; i++)
 address[i]=my_data->cmdData[i+1];
 return;
}
void
get_RAT_response_addr16(data_frame * my_data, unsigned char* address){
 address[0]=my_data->cmdData[9];
 address[1]=my_data->cmdData[10];
 return;
}
void
get_RAT_response_name(data_frame * my_data, unsigned char* name){
 name[0]=my_data->cmdData[11];
 name[1]=my_data->cmdData[12];
 return;
}
unsigned char
get_RAT_response_status(data_frame * my_data){
 return my_data->cmdData[13];
}
unsigned char
get_RAT_response_data_length(unsigned int length){
 return (unsigned char)length-15;
}
unsigned char *
get_RAT_response_data(data_frame * my_data){
 unsigned char length;
 unsigned char* cmdData= ((void*)0) ;
 unsigned int i;

 length = get_RAT_response_data_length(my_data->length);
 if(length==0)return  ((void*)0) ;
 if((cmdData = (unsigned char*)malloc(length))== ((void*)0) ) return  ((void*)0) ;
 for(i=0; i<length; i++)cmdData[i]=my_data->cmdData[14+i];
 return cmdData;
}
