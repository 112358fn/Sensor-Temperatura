
_API_frame_length:

;Zigbee_API_Simple.c,27 :: 		API_frame_length(unsigned char * API_frame){
;Zigbee_API_Simple.c,29 :: 		((unsigned int)API_frame[2]));
	MOVLW       1
	ADDWF       FARG_API_frame_length_API_frame+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_API_frame_length_API_frame+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	CLRF        R2 
	MOVLW       2
	ADDWF       FARG_API_frame_length_API_frame+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_API_frame_length_API_frame+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	IORWF       R0, 0 
	MOVWF       R0 
	MOVLW       4
	ADDWF       R0, 1 
;Zigbee_API_Simple.c,30 :: 		}
L_end_API_frame_length:
	RETURN      0
; end of _API_frame_length

_API_frame_checksum:

;Zigbee_API_Simple.c,32 :: 		API_frame_checksum(unsigned char * API_frame){
;Zigbee_API_Simple.c,33 :: 		unsigned int checksum=0;
	CLRF        API_frame_checksum_checksum_L0+0 
	CLRF        API_frame_checksum_checksum_L0+1 
;Zigbee_API_Simple.c,37 :: 		length = API_frame_length(API_frame)-4;
	MOVF        FARG_API_frame_checksum_API_frame+0, 0 
	MOVWF       FARG_API_frame_length_API_frame+0 
	MOVF        FARG_API_frame_checksum_API_frame+1, 0 
	MOVWF       FARG_API_frame_length_API_frame+1 
	CALL        _API_frame_length+0, 0
	MOVLW       4
	SUBWF       R0, 0 
	MOVWF       API_frame_checksum_length_L0+0 
;Zigbee_API_Simple.c,40 :: 		for (i=0; i<length ; i++)
	CLRF        API_frame_checksum_i_L0+0 
	CLRF        API_frame_checksum_i_L0+1 
L_API_frame_checksum0:
	MOVLW       0
	SUBWF       API_frame_checksum_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__API_frame_checksum64
	MOVF        API_frame_checksum_length_L0+0, 0 
	SUBWF       API_frame_checksum_i_L0+0, 0 
L__API_frame_checksum64:
	BTFSC       STATUS+0, 0 
	GOTO        L_API_frame_checksum1
;Zigbee_API_Simple.c,41 :: 		checksum+=API_frame[HEADER+i];
	MOVLW       3
	ADDWF       API_frame_checksum_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      API_frame_checksum_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_API_frame_checksum_API_frame+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      FARG_API_frame_checksum_API_frame+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       API_frame_checksum_checksum_L0+0, 1 
	MOVLW       0
	ADDWFC      API_frame_checksum_checksum_L0+1, 1 
;Zigbee_API_Simple.c,40 :: 		for (i=0; i<length ; i++)
	INFSNZ      API_frame_checksum_i_L0+0, 1 
	INCF        API_frame_checksum_i_L0+1, 1 
;Zigbee_API_Simple.c,41 :: 		checksum+=API_frame[HEADER+i];
	GOTO        L_API_frame_checksum0
L_API_frame_checksum1:
;Zigbee_API_Simple.c,44 :: 		return (0xFF)-(checksum & 0xFF);
	MOVLW       255
	ANDWF       API_frame_checksum_checksum_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBLW       255
	MOVWF       R0 
;Zigbee_API_Simple.c,46 :: 		}
L_end_API_frame_checksum:
	RETURN      0
; end of _API_frame_checksum

_ATCMD_init:

;Zigbee_API_Simple.c,60 :: 		ATCMD_init(void){
;Zigbee_API_Simple.c,61 :: 		_atcmd.frameID=FRAMEID;
	MOVLW       1
	MOVWF       __atcmd+0 
;Zigbee_API_Simple.c,62 :: 		_atcmd.AT[0]=0;
	CLRF        __atcmd+1 
;Zigbee_API_Simple.c,63 :: 		_atcmd.AT[1]=0;
	CLRF        __atcmd+2 
;Zigbee_API_Simple.c,64 :: 		_atcmd.parameters=NULL;
	CLRF        __atcmd+3 
	CLRF        __atcmd+4 
;Zigbee_API_Simple.c,65 :: 		_atcmd.para_len=0;
	CLRF        __atcmd+5 
	CLRF        __atcmd+6 
;Zigbee_API_Simple.c,66 :: 		_atcmd.request=ATCMD_request;
	MOVLW       _ATCMD_request+0
	MOVWF       __atcmd+7 
	MOVLW       hi_addr(_ATCMD_request+0)
	MOVWF       __atcmd+8 
	MOVLW       FARG_ATCMD_request_AT_n_parameters+0
	MOVWF       __atcmd+9 
	MOVLW       hi_addr(FARG_ATCMD_request_AT_n_parameters+0)
	MOVWF       __atcmd+10 
;Zigbee_API_Simple.c,67 :: 		return &_atcmd;
	MOVLW       __atcmd+0
	MOVWF       R0 
	MOVLW       hi_addr(__atcmd+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,68 :: 		}
L_end_ATCMD_init:
	RETURN      0
; end of _ATCMD_init

_ATCMD_request:

;Zigbee_API_Simple.c,70 :: 		ATCMD_request(unsigned char * AT_n_parameters, unsigned char length){
;Zigbee_API_Simple.c,74 :: 		_atcmd.AT[0]=AT_n_parameters[0];
	MOVFF       FARG_ATCMD_request_AT_n_parameters+0, FSR0
	MOVFF       FARG_ATCMD_request_AT_n_parameters+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       __atcmd+1 
;Zigbee_API_Simple.c,75 :: 		_atcmd.AT[1]=AT_n_parameters[1];
	MOVLW       1
	ADDWF       FARG_ATCMD_request_AT_n_parameters+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ATCMD_request_AT_n_parameters+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       __atcmd+2 
;Zigbee_API_Simple.c,76 :: 		_atcmd.parameters=(AT_n_parameters+2);
	MOVLW       2
	ADDWF       FARG_ATCMD_request_AT_n_parameters+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ATCMD_request_AT_n_parameters+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       __atcmd+3 
	MOVF        R1, 0 
	MOVWF       __atcmd+4 
;Zigbee_API_Simple.c,77 :: 		_atcmd.para_len=length-2;
	MOVLW       2
	SUBWF       FARG_ATCMD_request_length+0, 0 
	MOVWF       R5 
	CLRF        R6 
	MOVLW       0
	SUBWFB      R6, 1 
	MOVF        R5, 0 
	MOVWF       __atcmd+5 
	MOVF        R6, 0 
	MOVWF       __atcmd+6 
;Zigbee_API_Simple.c,81 :: 		frame[0] = STARTDELIMITER;
	MOVLW       126
	MOVWF       Zigbee_API_Simple_frame+0 
;Zigbee_API_Simple.c,83 :: 		frame[1] = ((ATCMD_data_length(_atcmd))>>8)&0xFF;//Lenght MSB
	MOVLW       4
	ADDWF       R5, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       Zigbee_API_Simple_frame+1 
;Zigbee_API_Simple.c,84 :: 		frame[2] =  (ATCMD_data_length(_atcmd)) & 0xFF;//Length LSB
	MOVLW       255
	ANDWF       R3, 0 
	MOVWF       Zigbee_API_Simple_frame+2 
;Zigbee_API_Simple.c,86 :: 		frame[3] = ATCMD;
	MOVLW       8
	MOVWF       Zigbee_API_Simple_frame+3 
;Zigbee_API_Simple.c,88 :: 		frame[4] = _atcmd.frameID;
	MOVF        __atcmd+0, 0 
	MOVWF       Zigbee_API_Simple_frame+4 
;Zigbee_API_Simple.c,90 :: 		frame[5] = _atcmd.AT[0];
	MOVF        __atcmd+1, 0 
	MOVWF       Zigbee_API_Simple_frame+5 
;Zigbee_API_Simple.c,91 :: 		frame[6] = _atcmd.AT[1];
	MOVF        __atcmd+2, 0 
	MOVWF       Zigbee_API_Simple_frame+6 
;Zigbee_API_Simple.c,93 :: 		if(_atcmd.para_len>0){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R6, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ATCMD_request67
	MOVF        R5, 0 
	SUBLW       0
L__ATCMD_request67:
	BTFSC       STATUS+0, 0 
	GOTO        L_ATCMD_request3
;Zigbee_API_Simple.c,94 :: 		for(i=0; i<_atcmd.para_len; i++)
	CLRF        ATCMD_request_i_L0+0 
	CLRF        ATCMD_request_i_L0+1 
L_ATCMD_request4:
	MOVLW       128
	XORWF       ATCMD_request_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       __atcmd+6, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ATCMD_request68
	MOVF        __atcmd+5, 0 
	SUBWF       ATCMD_request_i_L0+0, 0 
L__ATCMD_request68:
	BTFSC       STATUS+0, 0 
	GOTO        L_ATCMD_request5
;Zigbee_API_Simple.c,95 :: 		frame[7+i]=_atcmd.parameters[i];}
	MOVLW       7
	ADDWF       ATCMD_request_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      ATCMD_request_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        ATCMD_request_i_L0+0, 0 
	ADDWF       __atcmd+3, 0 
	MOVWF       FSR0 
	MOVF        ATCMD_request_i_L0+1, 0 
	ADDWFC      __atcmd+4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,94 :: 		for(i=0; i<_atcmd.para_len; i++)
	INFSNZ      ATCMD_request_i_L0+0, 1 
	INCF        ATCMD_request_i_L0+1, 1 
;Zigbee_API_Simple.c,95 :: 		frame[7+i]=_atcmd.parameters[i];}
	GOTO        L_ATCMD_request4
L_ATCMD_request5:
L_ATCMD_request3:
;Zigbee_API_Simple.c,97 :: 		frame[7+_atcmd.para_len] = API_frame_checksum(frame);
	MOVLW       7
	ADDWF       __atcmd+5, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      __atcmd+6, 0 
	MOVWF       R1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ATCMD_request+0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ATCMD_request+1 
	MOVLW       Zigbee_API_Simple_frame+0
	MOVWF       FARG_API_frame_checksum_API_frame+0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	MOVWF       FARG_API_frame_checksum_API_frame+1 
	CALL        _API_frame_checksum+0, 0
	MOVFF       FLOC__ATCMD_request+0, FSR1
	MOVFF       FLOC__ATCMD_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,99 :: 		return frame;
	MOVLW       Zigbee_API_Simple_frame+0
	MOVWF       R0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,100 :: 		}
L_end_ATCMD_request:
	RETURN      0
; end of _ATCMD_request

_ZBTR_init:

;Zigbee_API_Simple.c,124 :: 		ZBTR_init(unsigned char * addr64, unsigned char * addr16){
;Zigbee_API_Simple.c,126 :: 		_zbtr.frameID=FRAMEID;
	MOVLW       1
	MOVWF       __zbtr+0 
;Zigbee_API_Simple.c,127 :: 		_zbtr.addr64=addr64;
	MOVF        FARG_ZBTR_init_addr64+0, 0 
	MOVWF       __zbtr+1 
	MOVF        FARG_ZBTR_init_addr64+1, 0 
	MOVWF       __zbtr+2 
;Zigbee_API_Simple.c,128 :: 		_zbtr.addr16=addr16;
	MOVF        FARG_ZBTR_init_addr16+0, 0 
	MOVWF       __zbtr+3 
	MOVF        FARG_ZBTR_init_addr16+1, 0 
	MOVWF       __zbtr+4 
;Zigbee_API_Simple.c,129 :: 		_zbtr.broadcast=0;
	CLRF        __zbtr+5 
;Zigbee_API_Simple.c,130 :: 		_zbtr.options=0;
	CLRF        __zbtr+6 
;Zigbee_API_Simple.c,131 :: 		_zbtr.RFdata=NULL;
	CLRF        __zbtr+7 
	CLRF        __zbtr+8 
;Zigbee_API_Simple.c,132 :: 		_zbtr.RFdata_len=0;
	CLRF        __zbtr+9 
;Zigbee_API_Simple.c,133 :: 		_zbtr.request=ZBTR_request;
	MOVLW       _ZBTR_request+0
	MOVWF       __zbtr+10 
	MOVLW       hi_addr(_ZBTR_request+0)
	MOVWF       __zbtr+11 
	MOVLW       FARG_ZBTR_request_rfdat+0
	MOVWF       __zbtr+12 
	MOVLW       hi_addr(FARG_ZBTR_request_rfdat+0)
	MOVWF       __zbtr+13 
;Zigbee_API_Simple.c,134 :: 		return &_zbtr;
	MOVLW       __zbtr+0
	MOVWF       R0 
	MOVLW       hi_addr(__zbtr+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,135 :: 		}
L_end_ZBTR_init:
	RETURN      0
; end of _ZBTR_init

_ZBTR_request:

;Zigbee_API_Simple.c,137 :: 		ZBTR_request(unsigned char * rfdata, unsigned char len){
;Zigbee_API_Simple.c,140 :: 		_zbtr.RFdata=rfdata;
	MOVF        FARG_ZBTR_request_rfdata+0, 0 
	MOVWF       __zbtr+7 
	MOVF        FARG_ZBTR_request_rfdata+1, 0 
	MOVWF       __zbtr+8 
;Zigbee_API_Simple.c,141 :: 		_zbtr.RFdata_len=len;
	MOVF        FARG_ZBTR_request_len+0, 0 
	MOVWF       __zbtr+9 
;Zigbee_API_Simple.c,144 :: 		frame[0]=STARTDELIMITER;
	MOVLW       126
	MOVWF       Zigbee_API_Simple_frame+0 
;Zigbee_API_Simple.c,146 :: 		frame[1] = ((ZBTR_data_length(_zbtr))>>8)&0xFF;//Lenght MSB
	MOVF        FARG_ZBTR_request_len+0, 0 
	ADDLW       14
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       Zigbee_API_Simple_frame+1 
;Zigbee_API_Simple.c,147 :: 		frame[2] = (ZBTR_data_length(_zbtr)) & 0xFF;//Length LSB
	MOVLW       255
	ANDWF       R3, 0 
	MOVWF       Zigbee_API_Simple_frame+2 
;Zigbee_API_Simple.c,149 :: 		frame[3] = ZBTR;
	MOVLW       16
	MOVWF       Zigbee_API_Simple_frame+3 
;Zigbee_API_Simple.c,151 :: 		frame[4] = _zbtr.frameID;
	MOVF        __zbtr+0, 0 
	MOVWF       Zigbee_API_Simple_frame+4 
;Zigbee_API_Simple.c,153 :: 		for(i=0; i<8; i++)frame[5+i] = _zbtr.addr64[i];
	CLRF        ZBTR_request_i_L0+0 
	CLRF        ZBTR_request_i_L0+1 
L_ZBTR_request7:
	MOVLW       128
	XORWF       ZBTR_request_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ZBTR_request71
	MOVLW       8
	SUBWF       ZBTR_request_i_L0+0, 0 
L__ZBTR_request71:
	BTFSC       STATUS+0, 0 
	GOTO        L_ZBTR_request8
	MOVLW       5
	ADDWF       ZBTR_request_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      ZBTR_request_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        ZBTR_request_i_L0+0, 0 
	ADDWF       __zbtr+1, 0 
	MOVWF       FSR0 
	MOVF        ZBTR_request_i_L0+1, 0 
	ADDWFC      __zbtr+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      ZBTR_request_i_L0+0, 1 
	INCF        ZBTR_request_i_L0+1, 1 
	GOTO        L_ZBTR_request7
L_ZBTR_request8:
;Zigbee_API_Simple.c,155 :: 		frame[13] = _zbtr.addr16[0];
	MOVFF       __zbtr+3, FSR0
	MOVFF       __zbtr+4, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       Zigbee_API_Simple_frame+13 
;Zigbee_API_Simple.c,156 :: 		frame[14] = _zbtr.addr16[1];
	MOVLW       1
	ADDWF       __zbtr+3, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      __zbtr+4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       Zigbee_API_Simple_frame+14 
;Zigbee_API_Simple.c,158 :: 		frame[15] = _zbtr.broadcast;
	MOVF        __zbtr+5, 0 
	MOVWF       Zigbee_API_Simple_frame+15 
;Zigbee_API_Simple.c,160 :: 		frame[16] = _zbtr.options;
	MOVF        __zbtr+6, 0 
	MOVWF       Zigbee_API_Simple_frame+16 
;Zigbee_API_Simple.c,162 :: 		if(_zbtr.RFdata_len>0){
	MOVF        __zbtr+9, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_ZBTR_request10
;Zigbee_API_Simple.c,163 :: 		for(i=0; i<_zbtr.RFdata_len; i++)
	CLRF        ZBTR_request_i_L0+0 
	CLRF        ZBTR_request_i_L0+1 
L_ZBTR_request11:
	MOVLW       128
	XORWF       ZBTR_request_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ZBTR_request72
	MOVF        __zbtr+9, 0 
	SUBWF       ZBTR_request_i_L0+0, 0 
L__ZBTR_request72:
	BTFSC       STATUS+0, 0 
	GOTO        L_ZBTR_request12
;Zigbee_API_Simple.c,164 :: 		frame[17+i]=_zbtr.RFdata[i];}
	MOVLW       17
	ADDWF       ZBTR_request_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      ZBTR_request_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        ZBTR_request_i_L0+0, 0 
	ADDWF       __zbtr+7, 0 
	MOVWF       FSR0 
	MOVF        ZBTR_request_i_L0+1, 0 
	ADDWFC      __zbtr+8, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,163 :: 		for(i=0; i<_zbtr.RFdata_len; i++)
	INFSNZ      ZBTR_request_i_L0+0, 1 
	INCF        ZBTR_request_i_L0+1, 1 
;Zigbee_API_Simple.c,164 :: 		frame[17+i]=_zbtr.RFdata[i];}
	GOTO        L_ZBTR_request11
L_ZBTR_request12:
L_ZBTR_request10:
;Zigbee_API_Simple.c,166 :: 		frame[17+_zbtr.RFdata_len]= API_frame_checksum(frame);
	MOVF        __zbtr+9, 0 
	ADDLW       17
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ZBTR_request+0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ZBTR_request+1 
	MOVLW       Zigbee_API_Simple_frame+0
	MOVWF       FARG_API_frame_checksum_API_frame+0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	MOVWF       FARG_API_frame_checksum_API_frame+1 
	CALL        _API_frame_checksum+0, 0
	MOVFF       FLOC__ZBTR_request+0, FSR1
	MOVFF       FLOC__ZBTR_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,168 :: 		return frame;
	MOVLW       Zigbee_API_Simple_frame+0
	MOVWF       R0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,169 :: 		}
L_end_ZBTR_request:
	RETURN      0
; end of _ZBTR_request

_RATCMD_init:

;Zigbee_API_Simple.c,183 :: 		RATCMD_init(unsigned char * addr64, unsigned char * addr16){
;Zigbee_API_Simple.c,184 :: 		_ratcmd.frameID=FRAMEID;
	MOVLW       1
	MOVWF       __ratcmd+0 
;Zigbee_API_Simple.c,185 :: 		_ratcmd.addr64=addr64;
	MOVF        FARG_RATCMD_init_addr64+0, 0 
	MOVWF       __ratcmd+1 
	MOVF        FARG_RATCMD_init_addr64+1, 0 
	MOVWF       __ratcmd+2 
;Zigbee_API_Simple.c,186 :: 		_ratcmd.addr16=addr16;
	MOVF        FARG_RATCMD_init_addr16+0, 0 
	MOVWF       __ratcmd+3 
	MOVF        FARG_RATCMD_init_addr16+1, 0 
	MOVWF       __ratcmd+4 
;Zigbee_API_Simple.c,187 :: 		_ratcmd.options=0;
	CLRF        __ratcmd+5 
;Zigbee_API_Simple.c,188 :: 		_ratcmd.AT[0]=0;
	CLRF        __ratcmd+6 
;Zigbee_API_Simple.c,189 :: 		_ratcmd.AT[1]=0;
	CLRF        __ratcmd+7 
;Zigbee_API_Simple.c,190 :: 		_ratcmd.parameters=NULL;
	CLRF        __ratcmd+8 
	CLRF        __ratcmd+9 
;Zigbee_API_Simple.c,191 :: 		_ratcmd.para_len=0;
	CLRF        __ratcmd+10 
;Zigbee_API_Simple.c,192 :: 		_ratcmd.request=RATCMD_request;
	MOVLW       _RATCMD_request+0
	MOVWF       __ratcmd+11 
	MOVLW       hi_addr(_RATCMD_request+0)
	MOVWF       __ratcmd+12 
	MOVLW       FARG_RATCMD_request_RAT_n_parameters+0
	MOVWF       __ratcmd+13 
	MOVLW       hi_addr(FARG_RATCMD_request_RAT_n_parameters+0)
	MOVWF       __ratcmd+14 
;Zigbee_API_Simple.c,193 :: 		return &_ratcmd;
	MOVLW       __ratcmd+0
	MOVWF       R0 
	MOVLW       hi_addr(__ratcmd+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,194 :: 		}
L_end_RATCMD_init:
	RETURN      0
; end of _RATCMD_init

_RATCMD_request:

;Zigbee_API_Simple.c,196 :: 		RATCMD_request(unsigned char * RAT_n_parameters, unsigned char len){
;Zigbee_API_Simple.c,199 :: 		_ratcmd.AT[0]=RAT_n_parameters[0];
	MOVFF       FARG_RATCMD_request_RAT_n_parameters+0, FSR0
	MOVFF       FARG_RATCMD_request_RAT_n_parameters+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       __ratcmd+6 
;Zigbee_API_Simple.c,200 :: 		_ratcmd.AT[1]=RAT_n_parameters[1];
	MOVLW       1
	ADDWF       FARG_RATCMD_request_RAT_n_parameters+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_RATCMD_request_RAT_n_parameters+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       __ratcmd+7 
;Zigbee_API_Simple.c,201 :: 		_ratcmd.parameters=(RAT_n_parameters+2);
	MOVLW       2
	ADDWF       FARG_RATCMD_request_RAT_n_parameters+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_RATCMD_request_RAT_n_parameters+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       __ratcmd+8 
	MOVF        R1, 0 
	MOVWF       __ratcmd+9 
;Zigbee_API_Simple.c,202 :: 		_ratcmd.para_len=len-2;
	MOVLW       2
	SUBWF       FARG_RATCMD_request_len+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __ratcmd+10 
;Zigbee_API_Simple.c,206 :: 		frame[0]=STARTDELIMITER;
	MOVLW       126
	MOVWF       Zigbee_API_Simple_frame+0 
;Zigbee_API_Simple.c,208 :: 		frame[1] = ((RATCMD_data_length(_ratcmd.para_len))>>8)&0xFF;//Lenght MSB
	MOVF        R0, 0 
	ADDLW       15
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       Zigbee_API_Simple_frame+1 
;Zigbee_API_Simple.c,209 :: 		frame[2] = (RATCMD_data_length(_ratcmd.para_len)) & 0xFF;//Length LSB
	MOVLW       255
	ANDWF       R3, 0 
	MOVWF       Zigbee_API_Simple_frame+2 
;Zigbee_API_Simple.c,211 :: 		frame[3] = RATCMD;
	MOVLW       23
	MOVWF       Zigbee_API_Simple_frame+3 
;Zigbee_API_Simple.c,213 :: 		frame[4] = _ratcmd.frameid;
	MOVF        __ratcmd+0, 0 
	MOVWF       Zigbee_API_Simple_frame+4 
;Zigbee_API_Simple.c,215 :: 		for(i=0; i<8; i++)frame[5+i] = _ratcmd.addr64[i];
	CLRF        RATCMD_request_i_L0+0 
	CLRF        RATCMD_request_i_L0+1 
L_RATCMD_request14:
	MOVLW       128
	XORWF       RATCMD_request_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RATCMD_request75
	MOVLW       8
	SUBWF       RATCMD_request_i_L0+0, 0 
L__RATCMD_request75:
	BTFSC       STATUS+0, 0 
	GOTO        L_RATCMD_request15
	MOVLW       5
	ADDWF       RATCMD_request_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      RATCMD_request_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        RATCMD_request_i_L0+0, 0 
	ADDWF       __ratcmd+1, 0 
	MOVWF       FSR0 
	MOVF        RATCMD_request_i_L0+1, 0 
	ADDWFC      __ratcmd+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      RATCMD_request_i_L0+0, 1 
	INCF        RATCMD_request_i_L0+1, 1 
	GOTO        L_RATCMD_request14
L_RATCMD_request15:
;Zigbee_API_Simple.c,217 :: 		frame[13] = _ratcmd.addr16[0];
	MOVFF       __ratcmd+3, FSR0
	MOVFF       __ratcmd+4, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       Zigbee_API_Simple_frame+13 
;Zigbee_API_Simple.c,218 :: 		frame[14] = _ratcmd.addr16[1];
	MOVLW       1
	ADDWF       __ratcmd+3, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      __ratcmd+4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       Zigbee_API_Simple_frame+14 
;Zigbee_API_Simple.c,220 :: 		frame[15] = _ratcmd.options;
	MOVF        __ratcmd+5, 0 
	MOVWF       Zigbee_API_Simple_frame+15 
;Zigbee_API_Simple.c,222 :: 		frame[16] = _ratcmd.AT[0];
	MOVF        __ratcmd+6, 0 
	MOVWF       Zigbee_API_Simple_frame+16 
;Zigbee_API_Simple.c,223 :: 		frame[17] = _ratcmd.AT[1];
	MOVF        __ratcmd+7, 0 
	MOVWF       Zigbee_API_Simple_frame+17 
;Zigbee_API_Simple.c,225 :: 		if(_ratcmd.para_len>0){
	MOVF        __ratcmd+10, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_RATCMD_request17
;Zigbee_API_Simple.c,226 :: 		for(i=0; i<_ratcmd.para_len; i++)
	CLRF        RATCMD_request_i_L0+0 
	CLRF        RATCMD_request_i_L0+1 
L_RATCMD_request18:
	MOVLW       128
	XORWF       RATCMD_request_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RATCMD_request76
	MOVF        __ratcmd+10, 0 
	SUBWF       RATCMD_request_i_L0+0, 0 
L__RATCMD_request76:
	BTFSC       STATUS+0, 0 
	GOTO        L_RATCMD_request19
;Zigbee_API_Simple.c,227 :: 		frame[18+i]=_ratcmd.parameters[i];}
	MOVLW       18
	ADDWF       RATCMD_request_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      RATCMD_request_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        RATCMD_request_i_L0+0, 0 
	ADDWF       __ratcmd+8, 0 
	MOVWF       FSR0 
	MOVF        RATCMD_request_i_L0+1, 0 
	ADDWFC      __ratcmd+9, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,226 :: 		for(i=0; i<_ratcmd.para_len; i++)
	INFSNZ      RATCMD_request_i_L0+0, 1 
	INCF        RATCMD_request_i_L0+1, 1 
;Zigbee_API_Simple.c,227 :: 		frame[18+i]=_ratcmd.parameters[i];}
	GOTO        L_RATCMD_request18
L_RATCMD_request19:
L_RATCMD_request17:
;Zigbee_API_Simple.c,229 :: 		frame[18+_ratcmd.para_len]= API_frame_checksum(frame);
	MOVF        __ratcmd+10, 0 
	ADDLW       18
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       Zigbee_API_Simple_frame+0
	ADDWF       R0, 0 
	MOVWF       FLOC__RATCMD_request+0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__RATCMD_request+1 
	MOVLW       Zigbee_API_Simple_frame+0
	MOVWF       FARG_API_frame_checksum_API_frame+0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	MOVWF       FARG_API_frame_checksum_API_frame+1 
	CALL        _API_frame_checksum+0, 0
	MOVFF       FLOC__RATCMD_request+0, FSR1
	MOVFF       FLOC__RATCMD_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,231 :: 		return frame;
	MOVLW       Zigbee_API_Simple_frame+0
	MOVWF       R0 
	MOVLW       hi_addr(Zigbee_API_Simple_frame+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,232 :: 		}
L_end_RATCMD_request:
	RETURN      0
; end of _RATCMD_request

_API_frame_is_correct:

;Zigbee_API_Simple.c,250 :: 		API_frame_is_correct(unsigned char * buf,unsigned int n){
;Zigbee_API_Simple.c,254 :: 		unsigned int checksum = 0;
	CLRF        API_frame_is_correct_checksum_L0+0 
	CLRF        API_frame_is_correct_checksum_L0+1 
;Zigbee_API_Simple.c,256 :: 		if(buf[0]!=0x7e)return 0;
	MOVFF       FARG_API_frame_is_correct_buf+0, FSR0
	MOVFF       FARG_API_frame_is_correct_buf+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       126
	BTFSC       STATUS+0, 2 
	GOTO        L_API_frame_is_correct21
	CLRF        R0 
	GOTO        L_end_API_frame_is_correct
L_API_frame_is_correct21:
;Zigbee_API_Simple.c,259 :: 		length=(((unsigned int)buf[1])<< 8)|((unsigned int)buf[2]); //length=cmdID+cmdData
	MOVLW       1
	ADDWF       FARG_API_frame_is_correct_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_API_frame_is_correct_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVLW       2
	ADDWF       FARG_API_frame_is_correct_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_API_frame_is_correct_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R3, 0 
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       R8 
	MOVF        R1, 0 
	MOVWF       R9 
;Zigbee_API_Simple.c,260 :: 		if(n<length+4)return 0;
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	SUBWF       FARG_API_frame_is_correct_n+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__API_frame_is_correct78
	MOVF        R2, 0 
	SUBWF       FARG_API_frame_is_correct_n+0, 0 
L__API_frame_is_correct78:
	BTFSC       STATUS+0, 0 
	GOTO        L_API_frame_is_correct22
	CLRF        R0 
	GOTO        L_end_API_frame_is_correct
L_API_frame_is_correct22:
;Zigbee_API_Simple.c,263 :: 		checksum+=buf[3];
	MOVLW       3
	ADDWF       FARG_API_frame_is_correct_buf+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_API_frame_is_correct_buf+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       API_frame_is_correct_checksum_L0+0, 1 
	MOVLW       0
	ADDWFC      API_frame_is_correct_checksum_L0+1, 1 
;Zigbee_API_Simple.c,264 :: 		for(i=0; i < (length-1); i++)
	CLRF        R6 
	CLRF        R7 
L_API_frame_is_correct23:
	MOVLW       1
	SUBWF       R8, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      R9, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       R7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__API_frame_is_correct79
	MOVF        R1, 0 
	SUBWF       R6, 0 
L__API_frame_is_correct79:
	BTFSC       STATUS+0, 0 
	GOTO        L_API_frame_is_correct24
;Zigbee_API_Simple.c,265 :: 		checksum += buf[4+i];
	MOVLW       4
	ADDWF       R6, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R7, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_API_frame_is_correct_buf+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      FARG_API_frame_is_correct_buf+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       API_frame_is_correct_checksum_L0+0, 1 
	MOVLW       0
	ADDWFC      API_frame_is_correct_checksum_L0+1, 1 
;Zigbee_API_Simple.c,264 :: 		for(i=0; i < (length-1); i++)
	INFSNZ      R6, 1 
	INCF        R7, 1 
;Zigbee_API_Simple.c,265 :: 		checksum += buf[4+i];
	GOTO        L_API_frame_is_correct23
L_API_frame_is_correct24:
;Zigbee_API_Simple.c,267 :: 		checksum+=buf[length + 3];
	MOVLW       3
	ADDWF       R8, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_API_frame_is_correct_buf+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      FARG_API_frame_is_correct_buf+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       API_frame_is_correct_checksum_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      API_frame_is_correct_checksum_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       API_frame_is_correct_checksum_L0+0 
	MOVF        R1, 0 
	MOVWF       API_frame_is_correct_checksum_L0+1 
;Zigbee_API_Simple.c,268 :: 		if((checksum&0xFF)!=0xFF)return 0;
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__API_frame_is_correct80
	MOVLW       255
	XORWF       R2, 0 
L__API_frame_is_correct80:
	BTFSC       STATUS+0, 2 
	GOTO        L_API_frame_is_correct26
	CLRF        R0 
	GOTO        L_end_API_frame_is_correct
L_API_frame_is_correct26:
;Zigbee_API_Simple.c,269 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;Zigbee_API_Simple.c,270 :: 		}
L_end_API_frame_is_correct:
	RETURN      0
; end of _API_frame_is_correct

_decode_API_frame:

;Zigbee_API_Simple.c,319 :: 		decode_API_frame(unsigned char * buf,unsigned int n)
;Zigbee_API_Simple.c,323 :: 		((unsigned int)buf[2]); //length=cmdID+cmdData
	MOVLW       1
	ADDWF       FARG_decode_API_frame_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_decode_API_frame_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       decode_API_frame_length_L0+0 
	MOVLW       0
	MOVWF       decode_API_frame_length_L0+1 
	MOVF        decode_API_frame_length_L0+0, 0 
	MOVWF       decode_API_frame_length_L0+1 
	CLRF        decode_API_frame_length_L0+0 
	MOVLW       2
	ADDWF       FARG_decode_API_frame_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_decode_API_frame_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       decode_API_frame_length_L0+0, 1 
	MOVF        R1, 0 
	IORWF       decode_API_frame_length_L0+1, 1 
;Zigbee_API_Simple.c,325 :: 		if(!API_frame_is_correct(buf,n))return NULL;
	MOVF        FARG_decode_API_frame_buf+0, 0 
	MOVWF       FARG_API_frame_is_correct_buf+0 
	MOVF        FARG_decode_API_frame_buf+1, 0 
	MOVWF       FARG_API_frame_is_correct_buf+1 
	MOVF        FARG_decode_API_frame_n+0, 0 
	MOVWF       FARG_API_frame_is_correct_n+0 
	MOVF        FARG_decode_API_frame_n+1, 0 
	MOVWF       FARG_API_frame_is_correct_n+1 
	CALL        _API_frame_is_correct+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_decode_API_frame27
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_decode_API_frame
L_decode_API_frame27:
;Zigbee_API_Simple.c,327 :: 		my_data.cmdData=cmdData;
	MOVLW       Zigbee_API_Simple_cmdData+0
	MOVWF       _my_data+1 
	MOVLW       hi_addr(Zigbee_API_Simple_cmdData+0)
	MOVWF       _my_data+2 
;Zigbee_API_Simple.c,329 :: 		my_data.length = length;
	MOVF        decode_API_frame_length_L0+0, 0 
	MOVWF       _my_data+3 
	MOVF        decode_API_frame_length_L0+1, 0 
	MOVWF       _my_data+4 
;Zigbee_API_Simple.c,330 :: 		my_data.cmdID=buf[3];
	MOVLW       3
	ADDWF       FARG_decode_API_frame_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_decode_API_frame_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _my_data+0 
;Zigbee_API_Simple.c,331 :: 		for(i=0; i < (length-1); i++)
	CLRF        decode_API_frame_i_L0+0 
	CLRF        decode_API_frame_i_L0+1 
L_decode_API_frame28:
	MOVLW       1
	SUBWF       decode_API_frame_length_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      decode_API_frame_length_L0+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       decode_API_frame_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__decode_API_frame82
	MOVF        R1, 0 
	SUBWF       decode_API_frame_i_L0+0, 0 
L__decode_API_frame82:
	BTFSC       STATUS+0, 0 
	GOTO        L_decode_API_frame29
;Zigbee_API_Simple.c,332 :: 		my_data.cmdData[i]=buf[4+i];
	MOVF        decode_API_frame_i_L0+0, 0 
	ADDWF       _my_data+1, 0 
	MOVWF       FSR1 
	MOVF        decode_API_frame_i_L0+1, 0 
	ADDWFC      _my_data+2, 0 
	MOVWF       FSR1H 
	MOVLW       4
	ADDWF       decode_API_frame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      decode_API_frame_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_decode_API_frame_buf+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_decode_API_frame_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,331 :: 		for(i=0; i < (length-1); i++)
	INFSNZ      decode_API_frame_i_L0+0, 1 
	INCF        decode_API_frame_i_L0+1, 1 
;Zigbee_API_Simple.c,332 :: 		my_data.cmdData[i]=buf[4+i];
	GOTO        L_decode_API_frame28
L_decode_API_frame29:
;Zigbee_API_Simple.c,334 :: 		return &my_data;
	MOVLW       _my_data+0
	MOVWF       R0 
	MOVLW       hi_addr(_my_data+0)
	MOVWF       R1 
;Zigbee_API_Simple.c,335 :: 		}
L_end_decode_API_frame:
	RETURN      0
; end of _decode_API_frame

_get_AT_response_frameid:

;Zigbee_API_Simple.c,353 :: 		get_AT_response_frameid(data_frame * my_data){
;Zigbee_API_Simple.c,354 :: 		return my_data->cmdData[0];
	MOVLW       1
	ADDWF       FARG_get_AT_response_frameid_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_frameid_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,355 :: 		}
L_end_get_AT_response_frameid:
	RETURN      0
; end of _get_AT_response_frameid

_get_AT_response_name:

;Zigbee_API_Simple.c,357 :: 		get_AT_response_name(data_frame * my_data, unsigned char* name){
;Zigbee_API_Simple.c,358 :: 		name[0]=my_data->cmdData[1];
	MOVLW       1
	ADDWF       FARG_get_AT_response_name_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_name_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_get_AT_response_name_name+0, FSR1
	MOVFF       FARG_get_AT_response_name_name+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,359 :: 		name[1]=my_data->cmdData[2];
	MOVLW       1
	ADDWF       FARG_get_AT_response_name_name+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_name_name+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_AT_response_name_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_name_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,360 :: 		return;
;Zigbee_API_Simple.c,361 :: 		}
L_end_get_AT_response_name:
	RETURN      0
; end of _get_AT_response_name

_get_AT_response_status:

;Zigbee_API_Simple.c,363 :: 		get_AT_response_status(data_frame * my_data){
;Zigbee_API_Simple.c,364 :: 		return my_data->cmdData[3];
	MOVLW       1
	ADDWF       FARG_get_AT_response_status_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_status_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,365 :: 		}
L_end_get_AT_response_status:
	RETURN      0
; end of _get_AT_response_status

_get_AT_response_data_length:

;Zigbee_API_Simple.c,367 :: 		get_AT_response_data_length(unsigned int length){
;Zigbee_API_Simple.c,368 :: 		return (unsigned char)length-5;
	MOVLW       5
	SUBWF       FARG_get_AT_response_data_length_length+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,369 :: 		}
L_end_get_AT_response_data_length:
	RETURN      0
; end of _get_AT_response_data_length

_get_AT_response_data:

;Zigbee_API_Simple.c,371 :: 		get_AT_response_data(data_frame * my_data){
;Zigbee_API_Simple.c,374 :: 		unsigned char* cmdData=NULL;
	MOVLW       0
	MOVWF       get_AT_response_data_cmdData_L0+0 
	MOVLW       0
	MOVWF       get_AT_response_data_cmdData_L0+1 
;Zigbee_API_Simple.c,377 :: 		length = get_AT_response_data_length(my_data->length);
	MOVLW       3
	ADDWF       FARG_get_AT_response_data_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_data_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_AT_response_data_length_length+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_AT_response_data_length_length+1 
	CALL        _get_AT_response_data_length+0, 0
	MOVF        R0, 0 
	MOVWF       get_AT_response_data_length_L0+0 
;Zigbee_API_Simple.c,378 :: 		if(length==0)return NULL;
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_get_AT_response_data31
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_get_AT_response_data
L_get_AT_response_data31:
;Zigbee_API_Simple.c,379 :: 		cmdData = (unsigned char*)malloc(length);
	MOVF        get_AT_response_data_length_L0+0, 0 
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVF        R0, 0 
	MOVWF       get_AT_response_data_cmdData_L0+0 
	MOVF        R1, 0 
	MOVWF       get_AT_response_data_cmdData_L0+1 
;Zigbee_API_Simple.c,380 :: 		if(cmdData==NULL) return NULL;
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_AT_response_data88
	MOVLW       0
	XORWF       R0, 0 
L__get_AT_response_data88:
	BTFSS       STATUS+0, 2 
	GOTO        L_get_AT_response_data32
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_get_AT_response_data
L_get_AT_response_data32:
;Zigbee_API_Simple.c,381 :: 		for(i=0; i<length; i++)cmdData[i]=my_data->cmdData[4+i];
	CLRF        get_AT_response_data_i_L0+0 
	CLRF        get_AT_response_data_i_L0+1 
L_get_AT_response_data33:
	MOVLW       0
	SUBWF       get_AT_response_data_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_AT_response_data89
	MOVF        get_AT_response_data_length_L0+0, 0 
	SUBWF       get_AT_response_data_i_L0+0, 0 
L__get_AT_response_data89:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_AT_response_data34
	MOVF        get_AT_response_data_i_L0+0, 0 
	ADDWF       get_AT_response_data_cmdData_L0+0, 0 
	MOVWF       FSR1 
	MOVF        get_AT_response_data_i_L0+1, 0 
	ADDWFC      get_AT_response_data_cmdData_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_AT_response_data_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_AT_response_data_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       4
	ADDWF       get_AT_response_data_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      get_AT_response_data_i_L0+1, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      get_AT_response_data_i_L0+0, 1 
	INCF        get_AT_response_data_i_L0+1, 1 
	GOTO        L_get_AT_response_data33
L_get_AT_response_data34:
;Zigbee_API_Simple.c,382 :: 		return cmdData;
	MOVF        get_AT_response_data_cmdData_L0+0, 0 
	MOVWF       R0 
	MOVF        get_AT_response_data_cmdData_L0+1, 0 
	MOVWF       R1 
;Zigbee_API_Simple.c,383 :: 		}
L_end_get_AT_response_data:
	RETURN      0
; end of _get_AT_response_data

_get_ZBTR_status_frameid:

;Zigbee_API_Simple.c,399 :: 		get_ZBTR_status_frameid(data_frame * my_data){
;Zigbee_API_Simple.c,400 :: 		return my_data->cmdData[0];
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_frameid_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_frameid_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,401 :: 		}
L_end_get_ZBTR_status_frameid:
	RETURN      0
; end of _get_ZBTR_status_frameid

_get_ZBTR_status_address16:

;Zigbee_API_Simple.c,403 :: 		get_ZBTR_status_address16(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,404 :: 		address[0]=my_data->cmdData[1];
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_address16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_address16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_get_ZBTR_status_address16_address+0, FSR1
	MOVFF       FARG_get_ZBTR_status_address16_address+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,405 :: 		address[1]=my_data->cmdData[2];
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_address16_address+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_address16_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_address16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_address16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,406 :: 		return;
;Zigbee_API_Simple.c,407 :: 		}
L_end_get_ZBTR_status_address16:
	RETURN      0
; end of _get_ZBTR_status_address16

_get_ZBTR_status_retrycount:

;Zigbee_API_Simple.c,409 :: 		get_ZBTR_status_retrycount(data_frame * my_data){
;Zigbee_API_Simple.c,410 :: 		return my_data->cmdData[3];
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_retrycount_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_retrycount_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,411 :: 		}
L_end_get_ZBTR_status_retrycount:
	RETURN      0
; end of _get_ZBTR_status_retrycount

_get_ZBTR_status_deliveryST:

;Zigbee_API_Simple.c,413 :: 		get_ZBTR_status_deliveryST(data_frame * my_data){
;Zigbee_API_Simple.c,414 :: 		return my_data->cmdData[4];
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_deliveryST_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_deliveryST_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,415 :: 		}
L_end_get_ZBTR_status_deliveryST:
	RETURN      0
; end of _get_ZBTR_status_deliveryST

_get_ZBTR_status_discoveryST:

;Zigbee_API_Simple.c,417 :: 		get_ZBTR_status_discoveryST(data_frame * my_data){
;Zigbee_API_Simple.c,418 :: 		return my_data->cmdData[5];
	MOVLW       1
	ADDWF       FARG_get_ZBTR_status_discoveryST_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBTR_status_discoveryST_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,419 :: 		}
L_end_get_ZBTR_status_discoveryST:
	RETURN      0
; end of _get_ZBTR_status_discoveryST

_get_ZBRCV_packet_address64:

;Zigbee_API_Simple.c,432 :: 		get_ZBRCV_packet_address64(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,434 :: 		for(i=0; i<8; i++)
	CLRF        R2 
	CLRF        R3 
L_get_ZBRCV_packet_address6436:
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_ZBRCV_packet_address6496
	MOVLW       8
	SUBWF       R2, 0 
L__get_ZBRCV_packet_address6496:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_ZBRCV_packet_address6437
;Zigbee_API_Simple.c,435 :: 		address[i]=my_data->cmdData[i];
	MOVF        R2, 0 
	ADDWF       FARG_get_ZBRCV_packet_address64_address+0, 0 
	MOVWF       FSR1 
	MOVF        R3, 0 
	ADDWFC      FARG_get_ZBRCV_packet_address64_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_ZBRCV_packet_address64_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_address64_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,434 :: 		for(i=0; i<8; i++)
	INFSNZ      R2, 1 
	INCF        R3, 1 
;Zigbee_API_Simple.c,435 :: 		address[i]=my_data->cmdData[i];
	GOTO        L_get_ZBRCV_packet_address6436
L_get_ZBRCV_packet_address6437:
;Zigbee_API_Simple.c,436 :: 		return;
;Zigbee_API_Simple.c,437 :: 		}
L_end_get_ZBRCV_packet_address64:
	RETURN      0
; end of _get_ZBRCV_packet_address64

_get_ZBRCV_packet_address16:

;Zigbee_API_Simple.c,439 :: 		get_ZBRCV_packet_address16(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,440 :: 		address[0]=my_data->cmdData[8];
	MOVLW       1
	ADDWF       FARG_get_ZBRCV_packet_address16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_address16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_get_ZBRCV_packet_address16_address+0, FSR1
	MOVFF       FARG_get_ZBRCV_packet_address16_address+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,441 :: 		address[1]=my_data->cmdData[9];
	MOVLW       1
	ADDWF       FARG_get_ZBRCV_packet_address16_address+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_address16_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_ZBRCV_packet_address16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_address16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       9
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,442 :: 		return;
;Zigbee_API_Simple.c,443 :: 		}
L_end_get_ZBRCV_packet_address16:
	RETURN      0
; end of _get_ZBRCV_packet_address16

_get_ZBRCV_packet_options:

;Zigbee_API_Simple.c,445 :: 		get_ZBRCV_packet_options(data_frame * my_data){
;Zigbee_API_Simple.c,446 :: 		return my_data->cmdData[10];
	MOVLW       1
	ADDWF       FARG_get_ZBRCV_packet_options_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_options_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,447 :: 		}
L_end_get_ZBRCV_packet_options:
	RETURN      0
; end of _get_ZBRCV_packet_options

_get_ZBRCV_packet_data_length:

;Zigbee_API_Simple.c,449 :: 		get_ZBRCV_packet_data_length(data_frame * my_data){
;Zigbee_API_Simple.c,450 :: 		return  my_data->length-12;//=FrameLength-FrameType-64Addr-16Addr-Options
	MOVLW       3
	ADDWF       FARG_get_ZBRCV_packet_data_length_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_data_length_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       12
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,451 :: 		}
L_end_get_ZBRCV_packet_data_length:
	RETURN      0
; end of _get_ZBRCV_packet_data_length

_get_ZBRCV_packet_data:

;Zigbee_API_Simple.c,454 :: 		get_ZBRCV_packet_data(data_frame * my_data, unsigned char * buf){
;Zigbee_API_Simple.c,458 :: 		length = get_ZBRCV_packet_data_length(my_data);
	MOVF        FARG_get_ZBRCV_packet_data_my_data+0, 0 
	MOVWF       FARG_get_ZBRCV_packet_data_length_my_data+0 
	MOVF        FARG_get_ZBRCV_packet_data_my_data+1, 0 
	MOVWF       FARG_get_ZBRCV_packet_data_length_my_data+1 
	CALL        _get_ZBRCV_packet_data_length+0, 0
	MOVF        R0, 0 
	MOVWF       get_ZBRCV_packet_data_length_L0+0 
;Zigbee_API_Simple.c,459 :: 		for(i=0; i<length; i++) buf[i]=my_data->cmdData[11+i];
	CLRF        get_ZBRCV_packet_data_i_L0+0 
	CLRF        get_ZBRCV_packet_data_i_L0+1 
L_get_ZBRCV_packet_data39:
	MOVLW       0
	SUBWF       get_ZBRCV_packet_data_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_ZBRCV_packet_data101
	MOVF        get_ZBRCV_packet_data_length_L0+0, 0 
	SUBWF       get_ZBRCV_packet_data_i_L0+0, 0 
L__get_ZBRCV_packet_data101:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_ZBRCV_packet_data40
	MOVF        get_ZBRCV_packet_data_i_L0+0, 0 
	ADDWF       FARG_get_ZBRCV_packet_data_buf+0, 0 
	MOVWF       FSR1 
	MOVF        get_ZBRCV_packet_data_i_L0+1, 0 
	ADDWFC      FARG_get_ZBRCV_packet_data_buf+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_ZBRCV_packet_data_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_ZBRCV_packet_data_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       11
	ADDWF       get_ZBRCV_packet_data_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      get_ZBRCV_packet_data_i_L0+1, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      get_ZBRCV_packet_data_i_L0+0, 1 
	INCF        get_ZBRCV_packet_data_i_L0+1, 1 
	GOTO        L_get_ZBRCV_packet_data39
L_get_ZBRCV_packet_data40:
;Zigbee_API_Simple.c,461 :: 		return length;
	MOVF        get_ZBRCV_packet_data_length_L0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,462 :: 		}
L_end_get_ZBRCV_packet_data:
	RETURN      0
; end of _get_ZBRCV_packet_data

_NODE_id_decode:

;Zigbee_API_Simple.c,493 :: 		NODE_id_decode(data_frame * my_data){
;Zigbee_API_Simple.c,496 :: 		zigbee * zb_elem=NULL;
	MOVLW       0
	MOVWF       NODE_id_decode_zb_elem_L0+0 
	MOVLW       0
	MOVWF       NODE_id_decode_zb_elem_L0+1 
;Zigbee_API_Simple.c,500 :: 		zb_elem = (zigbee*) malloc(sizeof(zigbee));
	MOVLW       29
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVF        R0, 0 
	MOVWF       NODE_id_decode_zb_elem_L0+0 
	MOVF        R1, 0 
	MOVWF       NODE_id_decode_zb_elem_L0+1 
;Zigbee_API_Simple.c,501 :: 		if( zb_elem== NULL)return NULL;
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NODE_id_decode103
	MOVLW       0
	XORWF       R0, 0 
L__NODE_id_decode103:
	BTFSS       STATUS+0, 2 
	GOTO        L_NODE_id_decode42
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_NODE_id_decode
L_NODE_id_decode42:
;Zigbee_API_Simple.c,504 :: 		zb_elem->network[0]=my_data->cmdData[11];
	MOVLW       8
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       11
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,505 :: 		zb_elem->network[1]=my_data->cmdData[12];
	MOVLW       8
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       12
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,507 :: 		for(i=0; i<8; i++)zb_elem->address[i]=my_data->cmdData[13+i];
	CLRF        NODE_id_decode_i_L0+0 
	CLRF        NODE_id_decode_i_L0+1 
L_NODE_id_decode43:
	MOVLW       0
	SUBWF       NODE_id_decode_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NODE_id_decode104
	MOVLW       8
	SUBWF       NODE_id_decode_i_L0+0, 0 
L__NODE_id_decode104:
	BTFSC       STATUS+0, 0 
	GOTO        L_NODE_id_decode44
	MOVF        NODE_id_decode_i_L0+0, 0 
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       FSR1 
	MOVF        NODE_id_decode_i_L0+1, 0 
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       13
	ADDWF       NODE_id_decode_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      NODE_id_decode_i_L0+1, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      NODE_id_decode_i_L0+0, 1 
	INCF        NODE_id_decode_i_L0+1, 1 
	GOTO        L_NODE_id_decode43
L_NODE_id_decode44:
;Zigbee_API_Simple.c,510 :: 		length = strlen(&(my_data->cmdData[21]));
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       21
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       NODE_id_decode_length_L0+0 
;Zigbee_API_Simple.c,512 :: 		length = (length > 15 ? 15 : length);
	MOVF        R0, 0 
	SUBLW       15
	BTFSC       STATUS+0, 0 
	GOTO        L_NODE_id_decode46
	MOVLW       15
	MOVWF       R0 
	GOTO        L_NODE_id_decode47
L_NODE_id_decode46:
	MOVF        NODE_id_decode_length_L0+0, 0 
	MOVWF       R0 
L_NODE_id_decode47:
	MOVF        R0, 0 
	MOVWF       NODE_id_decode_length_L0+0 
;Zigbee_API_Simple.c,513 :: 		for(i=0; i<length; i++) zb_elem->string[i]=my_data->cmdData[21+i];
	CLRF        NODE_id_decode_i_L0+0 
	CLRF        NODE_id_decode_i_L0+1 
L_NODE_id_decode48:
	MOVLW       0
	SUBWF       NODE_id_decode_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NODE_id_decode105
	MOVF        NODE_id_decode_length_L0+0, 0 
	SUBWF       NODE_id_decode_i_L0+0, 0 
L__NODE_id_decode105:
	BTFSC       STATUS+0, 0 
	GOTO        L_NODE_id_decode49
	MOVLW       10
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       R1 
	MOVF        NODE_id_decode_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVF        NODE_id_decode_i_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       21
	ADDWF       NODE_id_decode_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      NODE_id_decode_i_L0+1, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      NODE_id_decode_i_L0+0, 1 
	INCF        NODE_id_decode_i_L0+1, 1 
	GOTO        L_NODE_id_decode48
L_NODE_id_decode49:
;Zigbee_API_Simple.c,514 :: 		zb_elem->string[length]='\0';
	MOVLW       10
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       R1 
	MOVF        NODE_id_decode_length_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Zigbee_API_Simple.c,516 :: 		zb_elem->parent[0]=my_data->cmdData[22+length];
	MOVLW       26
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        NODE_id_decode_length_L0+0, 0 
	ADDLW       22
	MOVWF       R2 
	CLRF        R3 
	MOVLW       0
	ADDWFC      R3, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,517 :: 		zb_elem->parent[1]=my_data->cmdData[23+length];
	MOVLW       26
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        NODE_id_decode_length_L0+0, 0 
	ADDLW       23
	MOVWF       R2 
	CLRF        R3 
	MOVLW       0
	ADDWFC      R3, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,519 :: 		zb_elem->devicetype=my_data->cmdData[24+length];
	MOVLW       28
	ADDWF       NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_NODE_id_decode_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_NODE_id_decode_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        NODE_id_decode_length_L0+0, 0 
	ADDLW       24
	MOVWF       R2 
	CLRF        R3 
	MOVLW       0
	ADDWFC      R3, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,521 :: 		return zb_elem;
	MOVF        NODE_id_decode_zb_elem_L0+0, 0 
	MOVWF       R0 
	MOVF        NODE_id_decode_zb_elem_L0+1, 0 
	MOVWF       R1 
;Zigbee_API_Simple.c,522 :: 		}
L_end_NODE_id_decode:
	RETURN      0
; end of _NODE_id_decode

_get_NODE_id_source_addr64:

;Zigbee_API_Simple.c,526 :: 		get_NODE_id_source_addr64(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,528 :: 		for(i=0; i<8; i++)
	CLRF        R2 
	CLRF        R3 
L_get_NODE_id_source_addr6451:
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_NODE_id_source_addr64107
	MOVLW       8
	SUBWF       R2, 0 
L__get_NODE_id_source_addr64107:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_NODE_id_source_addr6452
;Zigbee_API_Simple.c,529 :: 		address[i]=my_data->cmdData[i];
	MOVF        R2, 0 
	ADDWF       FARG_get_NODE_id_source_addr64_address+0, 0 
	MOVWF       FSR1 
	MOVF        R3, 0 
	ADDWFC      FARG_get_NODE_id_source_addr64_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_NODE_id_source_addr64_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_source_addr64_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,528 :: 		for(i=0; i<8; i++)
	INFSNZ      R2, 1 
	INCF        R3, 1 
;Zigbee_API_Simple.c,529 :: 		address[i]=my_data->cmdData[i];
	GOTO        L_get_NODE_id_source_addr6451
L_get_NODE_id_source_addr6452:
;Zigbee_API_Simple.c,530 :: 		return;
;Zigbee_API_Simple.c,531 :: 		}
L_end_get_NODE_id_source_addr64:
	RETURN      0
; end of _get_NODE_id_source_addr64

_get_NODE_id_source_addr16:

;Zigbee_API_Simple.c,533 :: 		get_NODE_id_source_addr16(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,534 :: 		address[0]=my_data->cmdData[8];
	MOVLW       1
	ADDWF       FARG_get_NODE_id_source_addr16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_source_addr16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_get_NODE_id_source_addr16_address+0, FSR1
	MOVFF       FARG_get_NODE_id_source_addr16_address+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,535 :: 		address[1]=my_data->cmdData[9];
	MOVLW       1
	ADDWF       FARG_get_NODE_id_source_addr16_address+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_source_addr16_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_NODE_id_source_addr16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_source_addr16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       9
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,536 :: 		return;
;Zigbee_API_Simple.c,537 :: 		}
L_end_get_NODE_id_source_addr16:
	RETURN      0
; end of _get_NODE_id_source_addr16

_get_NODE_id_options:

;Zigbee_API_Simple.c,539 :: 		get_NODE_id_options(data_frame * my_data){
;Zigbee_API_Simple.c,540 :: 		return my_data->cmdData[10];
	MOVLW       1
	ADDWF       FARG_get_NODE_id_options_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_options_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,541 :: 		}
L_end_get_NODE_id_options:
	RETURN      0
; end of _get_NODE_id_options

_get_NODE_id_event:

;Zigbee_API_Simple.c,543 :: 		get_NODE_id_event(data_frame * my_data){
;Zigbee_API_Simple.c,544 :: 		return my_data->cmdData[my_data->length-6];
	MOVLW       1
	ADDWF       FARG_get_NODE_id_event_my_data+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_event_my_data+1, 0 
	MOVWF       R3 
	MOVLW       3
	ADDWF       FARG_get_NODE_id_event_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_NODE_id_event_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       6
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        R0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,545 :: 		}
L_end_get_NODE_id_event:
	RETURN      0
; end of _get_NODE_id_event

_get_RAT_response_addr64:

;Zigbee_API_Simple.c,563 :: 		get_RAT_response_addr64(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,565 :: 		for(i=0; i<8; i++)
	CLRF        R4 
	CLRF        R5 
L_get_RAT_response_addr6454:
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_RAT_response_addr64112
	MOVLW       8
	SUBWF       R4, 0 
L__get_RAT_response_addr64112:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_RAT_response_addr6455
;Zigbee_API_Simple.c,566 :: 		address[i]=my_data->cmdData[i+1];
	MOVF        R4, 0 
	ADDWF       FARG_get_RAT_response_addr64_address+0, 0 
	MOVWF       FSR1 
	MOVF        R5, 0 
	ADDWFC      FARG_get_RAT_response_addr64_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_RAT_response_addr64_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_addr64_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	ADDWF       R4, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R5, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,565 :: 		for(i=0; i<8; i++)
	INFSNZ      R4, 1 
	INCF        R5, 1 
;Zigbee_API_Simple.c,566 :: 		address[i]=my_data->cmdData[i+1];
	GOTO        L_get_RAT_response_addr6454
L_get_RAT_response_addr6455:
;Zigbee_API_Simple.c,567 :: 		return;
;Zigbee_API_Simple.c,568 :: 		}
L_end_get_RAT_response_addr64:
	RETURN      0
; end of _get_RAT_response_addr64

_get_RAT_response_addr16:

;Zigbee_API_Simple.c,570 :: 		get_RAT_response_addr16(data_frame * my_data, unsigned char* address){
;Zigbee_API_Simple.c,571 :: 		address[0]=my_data->cmdData[9];
	MOVLW       1
	ADDWF       FARG_get_RAT_response_addr16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_addr16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       9
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_get_RAT_response_addr16_address+0, FSR1
	MOVFF       FARG_get_RAT_response_addr16_address+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,572 :: 		address[1]=my_data->cmdData[10];
	MOVLW       1
	ADDWF       FARG_get_RAT_response_addr16_address+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_addr16_address+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_RAT_response_addr16_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_addr16_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,573 :: 		return;
;Zigbee_API_Simple.c,574 :: 		}
L_end_get_RAT_response_addr16:
	RETURN      0
; end of _get_RAT_response_addr16

_get_RAT_response_name:

;Zigbee_API_Simple.c,576 :: 		get_RAT_response_name(data_frame * my_data, unsigned char* name){
;Zigbee_API_Simple.c,577 :: 		name[0]=my_data->cmdData[11];
	MOVLW       1
	ADDWF       FARG_get_RAT_response_name_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_name_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       11
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_get_RAT_response_name_name+0, FSR1
	MOVFF       FARG_get_RAT_response_name_name+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,578 :: 		name[1]=my_data->cmdData[12];
	MOVLW       1
	ADDWF       FARG_get_RAT_response_name_name+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_name_name+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_RAT_response_name_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_name_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       12
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Zigbee_API_Simple.c,579 :: 		return;
;Zigbee_API_Simple.c,580 :: 		}
L_end_get_RAT_response_name:
	RETURN      0
; end of _get_RAT_response_name

_get_RAT_response_status:

;Zigbee_API_Simple.c,582 :: 		get_RAT_response_status(data_frame * my_data){
;Zigbee_API_Simple.c,583 :: 		return my_data->cmdData[13];
	MOVLW       1
	ADDWF       FARG_get_RAT_response_status_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_status_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       13
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,584 :: 		}
L_end_get_RAT_response_status:
	RETURN      0
; end of _get_RAT_response_status

_get_RAT_response_data_length:

;Zigbee_API_Simple.c,586 :: 		get_RAT_response_data_length(unsigned int length){
;Zigbee_API_Simple.c,587 :: 		return (unsigned char)length-15;//-15=-Type-ID-64bit-16bit-AT-Status
	MOVLW       15
	SUBWF       FARG_get_RAT_response_data_length_length+0, 0 
	MOVWF       R0 
;Zigbee_API_Simple.c,588 :: 		}
L_end_get_RAT_response_data_length:
	RETURN      0
; end of _get_RAT_response_data_length

_get_RAT_response_data:

;Zigbee_API_Simple.c,590 :: 		get_RAT_response_data(data_frame * my_data){
;Zigbee_API_Simple.c,592 :: 		unsigned char* cmdData=NULL;
	MOVLW       0
	MOVWF       get_RAT_response_data_cmdData_L0+0 
	MOVLW       0
	MOVWF       get_RAT_response_data_cmdData_L0+1 
;Zigbee_API_Simple.c,595 :: 		length = get_RAT_response_data_length(my_data->length);
	MOVLW       3
	ADDWF       FARG_get_RAT_response_data_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_data_my_data+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_RAT_response_data_length_length+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_get_RAT_response_data_length_length+1 
	CALL        _get_RAT_response_data_length+0, 0
	MOVF        R0, 0 
	MOVWF       get_RAT_response_data_length_L0+0 
;Zigbee_API_Simple.c,596 :: 		if(length==0)return NULL;
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_get_RAT_response_data57
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_get_RAT_response_data
L_get_RAT_response_data57:
;Zigbee_API_Simple.c,597 :: 		if((cmdData = (unsigned char*)malloc(length))==NULL) return NULL;
	MOVF        get_RAT_response_data_length_L0+0, 0 
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVF        R0, 0 
	MOVWF       get_RAT_response_data_cmdData_L0+0 
	MOVF        R1, 0 
	MOVWF       get_RAT_response_data_cmdData_L0+1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_RAT_response_data118
	MOVLW       0
	XORWF       R0, 0 
L__get_RAT_response_data118:
	BTFSS       STATUS+0, 2 
	GOTO        L_get_RAT_response_data58
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_get_RAT_response_data
L_get_RAT_response_data58:
;Zigbee_API_Simple.c,598 :: 		for(i=0; i<length; i++)cmdData[i]=my_data->cmdData[14+i];
	CLRF        get_RAT_response_data_i_L0+0 
	CLRF        get_RAT_response_data_i_L0+1 
L_get_RAT_response_data59:
	MOVLW       0
	SUBWF       get_RAT_response_data_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_RAT_response_data119
	MOVF        get_RAT_response_data_length_L0+0, 0 
	SUBWF       get_RAT_response_data_i_L0+0, 0 
L__get_RAT_response_data119:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_RAT_response_data60
	MOVF        get_RAT_response_data_i_L0+0, 0 
	ADDWF       get_RAT_response_data_cmdData_L0+0, 0 
	MOVWF       FSR1 
	MOVF        get_RAT_response_data_i_L0+1, 0 
	ADDWFC      get_RAT_response_data_cmdData_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_get_RAT_response_data_my_data+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_get_RAT_response_data_my_data+1, 0 
	MOVWF       FSR0H 
	MOVLW       14
	ADDWF       get_RAT_response_data_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      get_RAT_response_data_i_L0+1, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      get_RAT_response_data_i_L0+0, 1 
	INCF        get_RAT_response_data_i_L0+1, 1 
	GOTO        L_get_RAT_response_data59
L_get_RAT_response_data60:
;Zigbee_API_Simple.c,599 :: 		return cmdData;
	MOVF        get_RAT_response_data_cmdData_L0+0, 0 
	MOVWF       R0 
	MOVF        get_RAT_response_data_cmdData_L0+1, 0 
	MOVWF       R1 
;Zigbee_API_Simple.c,600 :: 		}
L_end_get_RAT_response_data:
	RETURN      0
; end of _get_RAT_response_data
