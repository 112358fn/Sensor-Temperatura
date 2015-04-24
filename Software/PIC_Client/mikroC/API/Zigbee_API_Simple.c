/*
 * Zigbee_API_Simple.c
 *
 *
 *  Created by Alvaro Rodrigo Alonso Bivou.
 *
 *
 */

//----------------------------------------------------------------------------
#define _ZIGBEE_API_SIMPLE_C
#include "Zigbee_API_Simple.h"

//////////////////////////////////////////////////////////
//                                                                                                                //
//                API FRAME CODE FUNCTIONS:                                                //
// Use it to generate API Frames                                                //
//                                                                                                                //
//////////////////////////////////////////////////////////


/************************************
 * General API Frame function                 *
 *                                                                         *
 ************************************/
unsigned char
API_frame_length(unsigned char * API_frame){
        return 4 +((((unsigned int)API_frame[1])<< 8)|\
                                ((unsigned int)API_frame[2]));
}
unsigned char
API_frame_checksum(unsigned char * API_frame){
        unsigned int checksum=0;
        unsigned char length;
        unsigned int i;
        
        length = API_frame_length(API_frame)-4;

        //Not including frame delimiters and length, add all bytes
        for (i=0; i<length ; i++)
                        checksum+=API_frame[HEADER+i];
        // keeping only the lowest 8 bits of the result and subtract
        //the result from 0xFF.
        return (0xFF)-(checksum & 0xFF);

}

/************************************
 *        AT Command Request                                *
 *                                                                        *
 ************************************/
/*
 * Frame Type: 0x08
 * Used to query or set module parameters on the local
 * device. This API command applies changes after executing
 * the command.
 *
 */
atcmd *
ATCMD_init(void){
       _atcmd.frameID=FRAMEID;
       _atcmd.AT[0]=0;
       _atcmd.AT[1]=0;
       _atcmd.parameters=NULL;
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
         
        //---- Start filling the frame
        //.... Start Delimiter
        frame[0] = STARTDELIMITER;
        //.... Length of Frame specific my_data
        frame[1] = ((ATCMD_data_length(_atcmd))>>8)&0xFF;//Lenght MSB
        frame[2] =  (ATCMD_data_length(_atcmd)) & 0xFF;//Length LSB
        //.... Frame Type
        frame[3] = ATCMD;
        //.... Frame ID
        frame[4] = _atcmd.frameID;
        //.... AT Command
        frame[5] = _atcmd.AT[0];
        frame[6] = _atcmd.AT[1];
        //.... AT Parameters
        if(_atcmd.para_len>0){
                for(i=0; i<_atcmd.para_len; i++)
                        frame[7+i]=_atcmd.parameters[i];}
        //....Checksum
        frame[7+_atcmd.para_len] = API_frame_checksum(frame);
        //---- Return frame
        return frame;
}

/************************************
 *        ZigBee Transmit Request                        *
 *                                                                        *
 ************************************/
/*
 * Frame Type: 0x10
 * A Transmit Request API frame causes the module to send my_data as
 * an RF packet to the specified destination. The 64-bit destination
 * address should be set to 0x000000000000FFFF for a broadcast
 * transmission (to all devices). The coordinator can be addressed
 * by either setting the 64-bit address to all 0x00s and the 16-bit
 * address to 0xFFFE, OR by setting the 64-bit address to the
 * coordinator's 64-bit address and the 16-bit address to 0x0000.
 * For all other transmissions, setting the 16-bit address to the
 * correct 16-bit address can help improve performance when
 * transmitting to multiple destinations. If a 16-bit address is
 * not known, this field should be set to 0xFFFE (unknown). The
 * Transmit Status frame (0x8B) will indicate the discovered
 * 16-bit address, if successful.
 *
 */
zbtr *
ZBTR_init(unsigned char * addr64, unsigned char * addr16){
        
        _zbtr.frameID=FRAMEID;
        _zbtr.addr64=addr64;
        _zbtr.addr16=addr16;
        _zbtr.broadcast=0;
        _zbtr.options=0;
        _zbtr.RFdata=NULL;
        _zbtr.RFdata_len=0;
        _zbtr.request=ZBTR_request;
        return &_zbtr;
}
unsigned char *
ZBTR_request(unsigned char * rfdata, unsigned char len){
        int i;

        _zbtr.RFdata=rfdata;
        _zbtr.RFdata_len=len;
        //---- Start filling the frame
        //.... Start Delimiter
        frame[0]=STARTDELIMITER;
        //.... Length of Frame specific my_data
        frame[1] = ((ZBTR_data_length(_zbtr))>>8)&0xFF;//Lenght MSB
        frame[2] = (ZBTR_data_length(_zbtr)) & 0xFF;//Length LSB
        //.... Frame Type
        frame[3] = ZBTR;
        //.... Frame ID
        frame[4] = _zbtr.frameID;
        //.... 64-bit Destination Address
        for(i=0; i<8; i++)frame[5+i] = _zbtr.addr64[i];
        //.... 16-bit Destination Network Address
        frame[13] = _zbtr.addr16[0];
        frame[14] = _zbtr.addr16[1];
        //.... Broadcast Radius
        frame[15] = _zbtr.broadcast;
        //.... Options
        frame[16] = _zbtr.options;
        //.... Data Payload
        if(_zbtr.RFdata_len>0){
                for(i=0; i<_zbtr.RFdata_len; i++)
                        frame[17+i]=_zbtr.RFdata[i];}
        //....Checksum
        frame[17+_zbtr.RFdata_len]= API_frame_checksum(frame);
        //---- Return frame
        return frame;
}
/************************************
 * Remote AT Command Request                *
 *                                                                        *
 ************************************/
/*
 * Frame Type: 0x17
 * Used to query or set module parameters on a remote device.
 * For parameter changes on the remote device to take effect,
 * changes must be applied, either by setting the apply changes
 * options bit, or by sending an AC command to the remote.
 *
 */
ratcmd *
RATCMD_init(unsigned char * addr64, unsigned char * addr16){
       _ratcmd.frameID=FRAMEID;
       _ratcmd.addr64=addr64;
       _ratcmd.addr16=addr16;
       _ratcmd.options=0;
       _ratcmd.AT[0]=0;
       _ratcmd.AT[1]=0;
       _ratcmd.parameters=NULL;
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

        //---- Start filling the frame
        //.... Start Delimiter
        frame[0]=STARTDELIMITER;
        //.... Length of Frame specific my_data
        frame[1] = ((RATCMD_data_length(_ratcmd.para_len))>>8)&0xFF;//Lenght MSB
        frame[2] = (RATCMD_data_length(_ratcmd.para_len)) & 0xFF;//Length LSB
        //.... Frame Type
        frame[3] = RATCMD;
        //.... Frame ID
        frame[4] = _ratcmd.frameid;
        //.... 64-bit Destination Address
        for(i=0; i<8; i++)frame[5+i] = _ratcmd.addr64[i];
        //.... 16-bit Destination Network Address
        frame[13] = _ratcmd.addr16[0];
        frame[14] = _ratcmd.addr16[1];
        //.... Remote Command Options
        frame[15] = _ratcmd.options;
        //.... AT Command
        frame[16] = _ratcmd.AT[0];
        frame[17] = _ratcmd.AT[1];
        //.... AT Parameters
        if(_ratcmd.para_len>0){
                for(i=0; i<_ratcmd.para_len; i++)
                        frame[18+i]=_ratcmd.parameters[i];}
        //....Checksum
        frame[18+_ratcmd.para_len]= API_frame_checksum(frame);
        //---- Return frame length
        return frame;
}


//////////////////////////////////////////////////////////
//                                                                                                                //
//                DECODE FUNCTIONS                                                                //
//Use it to decode a received API Frame                                        //
//                                                                                                                //
//////////////////////////////////////////////////////////
/********************************************************
 * API_frame_decode                                                                                *
 *                                                                                                                 *
 * Function: disassemble the API frame into its parts        *
 * Parameters:                                                                                         *
 * buf - pointer to the my_data buffer                                                *
 * n - number of bytes in the buffer                                        *
 ********************************************************/
unsigned char
API_frame_is_correct(unsigned char * buf,unsigned int n){

         unsigned int i;
         unsigned int length;
         unsigned int checksum = 0;
        //---- Verified start delimiter
        if(buf[0]!=0x7e)return 0;

        //---- Verified length
        length=(((unsigned int)buf[1])<< 8)|((unsigned int)buf[2]); //length=cmdID+cmdData
        if(n<length+4)return 0;

        //---- Verified checksum
        checksum+=buf[3];
        for(i=0; i < (length-1); i++)
                checksum += buf[4+i];

        checksum+=buf[length + 3];
        if((checksum&0xFF)!=0xFF)return 0;
        return 1;
}
/*
 * This function is optional mainly for educational
 * purpose use decode_API_frame instead
 */
#if 0
api_frame *
API_frame_decode(unsigned char * buf,unsigned int n)
{
        api_frame * api = NULL;
        data_frame * my_data = NULL;
        unsigned int length;
        unsigned char * cmdData = NULL;
        unsigned int i;
        
        if(!API_frame_is_correct(buf,n))return NULL;

        //---- Create the API Frame ----
        api = (api_frame*) malloc(sizeof(api_frame));
        if(api == NULL)return NULL;
        //---- Create the Data Frame ----
        my_data = (data_frame*) malloc(sizeof(data_frame));
        if(my_data== NULL)return NULL;
        //---- Create Data Space ----
        length=(((unsigned int)buf[1])<< 8)|\
               ((unsigned int)buf[2]); //length=cmdID+cmdData
        cmdData = (unsigned char*) malloc(length-1);
        if( cmdData== NULL)return NULL;

        //---- Link Data frame to API frame
        api->my_data = my_data;
        //---- Link Data Space to Data frame
        api->my_data->cmdData=cmdData;

        //---- Fill the API Frame ----
        api->start_delimiter=buf[0];
        //.... Fill the Data Frame....
        api->my_data->length = length;
        api->my_data->cmdID=buf[3];
        for(i=0; i < (length-1); i++)
                api->my_data->cmdData[i]=buf[4+i];
        //.... Checksum ....
        api->checksum=buf[api->my_data->length + 3];

        //---- Return the API Frame ----
        return api;
}
#endif
data_frame *
decode_API_frame(unsigned char * buf,unsigned int n)
{
        unsigned int i, length; 
        length=(((unsigned int)buf[1])<< 8)|\
                          ((unsigned int)buf[2]); //length=cmdID+cmdData

        if(!API_frame_is_correct(buf,n))return NULL;
        //---- Link Data Space to Data frame
        my_data.cmdData=cmdData;
        //.... Fill the Data Frame....
        my_data.length = length;
        my_data.cmdID=buf[3];
        for(i=0; i < (length-1); i++)
                my_data.cmdData[i]=buf[4+i];
        //---- Return the API Frame ----
        return &my_data;
}


/************************************
 *        AT Command Response Functions        *
 *                                                                        *
 ************************************/
/*
 * Frame Type: 0x88
 * In response to an AT Command message, the module will
 * send an AT Command Response message. Some commands will
 * send back multiple frames (for example, the ND (Node
 * Discover) command).
 *
 */
//NOT USE
//my_data->cmdData[0] is Frame ID
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
        unsigned char* cmdData=NULL;
        unsigned int i;
        
        length = get_AT_response_data_length(my_data->length);
        if(length==0)return NULL;
        cmdData = (unsigned char*)malloc(length);
        if(cmdData==NULL) return NULL;
        for(i=0; i<length; i++)cmdData[i]=my_data->cmdData[4+i];
        return cmdData;
}


/****************************************
 *        ZigBee Transmit Status Functions        *
 *                                                                                *
 ****************************************/
/*
 * Frame Type: 0x8B
 * When a TX Request is completed, the module sends a TX
 * Status message. This message will indicate if the packet
 * was transmitted successfully or if there was a failure.
 *
 */

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

/****************************************
 *        ZigBee Receive Packet Functions                *
 *                                                                                *
 ****************************************/
/*
 * Frame Type: (0x90)
 * When the module receives an RF packet, it is sent out
 * the UART using this message type.
 *
 */
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
        return  my_data->length-12;//=FrameLength-FrameType-64Addr-16Addr-Options
}
#if NO_MALLOC
unsigned char
get_ZBRCV_packet_data(data_frame * my_data, unsigned char * buf){
        unsigned char length;
        unsigned int i;
        
        length = get_ZBRCV_packet_data_length(my_data);
        for(i=0; i<length; i++) buf[i]=my_data->cmdData[11+i];
        
        return length;
}
#elif
unsigned char *
get_ZBRCV_packet_data(data_frame * my_data){

        unsigned char length;
        unsigned char * receiveData=NULL;
        unsigned int i;
        
        length = get_ZBRCV_packet_data_length(my_data);
        if((receiveData = (unsigned char*)malloc(length))==NULL) return NULL;
        for(i=0; i<length; i++) receiveData[i]=my_data->cmdData[11+i];
        
        return receiveData;
}
#endif

/************************************************
 *        Node Identification Indicator Functions                *
 *                                                                                                *
 ************************************************/
/*
 * Frame Type: 0x95
 * This frame is received when a module transmits a node identification
 * message to identify itself (when AO=0). The my_data portion of this frame
 * is similar to a network discovery response frame (see ND command).
 *
 */
//Indicates the information of the remote module that
//transmitted the node identification frame.
zigbee *
NODE_id_decode(data_frame * my_data){

        unsigned int i;
        zigbee * zb_elem=NULL;
        unsigned char length;
        
        //---- Create ZigBee Frame ----
        zb_elem = (zigbee*) malloc(sizeof(zigbee));
        if( zb_elem== NULL)return NULL;
        //---- Fill ZigBee Frame ----
        //.... Network 16-bit Address
        zb_elem->network[0]=my_data->cmdData[11];
        zb_elem->network[1]=my_data->cmdData[12];
        //.... 64-bit Address ....
        for(i=0; i<8; i++)zb_elem->address[i]=my_data->cmdData[13+i];
        //.... String length
        //length = strlen((const char *) &(my_data->cmdData[21]));
        length = strlen(&(my_data->cmdData[21]));
        //.... String Space (Max 15 char)....
        length = (length > 15 ? 15 : length);
        for(i=0; i<length; i++) zb_elem->string[i]=my_data->cmdData[21+i];
        zb_elem->string[length]='\0';
        //.... Parent 16-bit Address (0xFFFE if the remote has no parent.)
        zb_elem->parent[0]=my_data->cmdData[22+length];
        zb_elem->parent[1]=my_data->cmdData[23+length];
        //.... Device type
        zb_elem->devicetype=my_data->cmdData[24+length];
        //---- Return
        return zb_elem;
}

//Indicates the 64-bit & 16-bit address of the sender module
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

/************************************************
 *        Remote Command Response Functions                        *
 *                                                                                                *
 ************************************************/
/*
 * Frame Type: 0x97
 * If a module receives a remote command response RF my_data frame in
 * response to a Remote AT Command Request, the module will send a
 * Remote AT Command Response message out the UART. Some commands
 * may send back multiple frames--for example, Node Discover (ND)
 * command.
 *
 */
//NOT USE
//my_data->cmdData[0] is Frame ID
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
        return (unsigned char)length-15;//-15=-Type-ID-64bit-16bit-AT-Status
}
unsigned char *
get_RAT_response_data(data_frame * my_data){
        unsigned char length;
        unsigned char* cmdData=NULL;
        unsigned int i;
        
        length = get_RAT_response_data_length(my_data->length);
        if(length==0)return NULL;
        if((cmdData = (unsigned char*)malloc(length))==NULL) return NULL;
        for(i=0; i<length; i++)cmdData[i]=my_data->cmdData[14+i];
        return cmdData;
}
//----------------------------------------------------------------------------