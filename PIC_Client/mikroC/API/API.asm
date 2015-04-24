
_main:

;API.c,6 :: 		void main(void){
;API.c,7 :: 		init();
	CALL        _init+0, 0
;API.c,8 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;API.c,9 :: 		connect=FALSE;
	CLRF        _connect+0 
;API.c,10 :: 		T0CON.TMR0ON = 1; //Start timer0
	BSF         T0CON+0, 7 
;API.c,11 :: 		while(1){}
L_main1:
	GOTO        L_main1
;API.c,13 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_send_AD_result:

;API.c,17 :: 		send_AD_result(void){
;API.c,21 :: 		buffer[0]=zigbee_id;
	MOVF        _zigbee_id+0, 0 
	MOVWF       send_AD_result_buffer_L0+0 
;API.c,22 :: 		buffer[1]=ch;
	MOVF        _ch+0, 0 
	MOVWF       send_AD_result_buffer_L0+1 
;API.c,23 :: 		buffer[2]=ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       send_AD_result_buffer_L0+2 
;API.c,24 :: 		buffer[3]=ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       send_AD_result_buffer_L0+3 
;API.c,26 :: 		send(buffer,4);
	MOVLW       send_AD_result_buffer_L0+0
	MOVWF       FARG_send_buf+0 
	MOVLW       hi_addr(send_AD_result_buffer_L0+0)
	MOVWF       FARG_send_buf+1 
	MOVLW       4
	MOVWF       FARG_send_len+0 
	CALL        _send+0, 0
;API.c,28 :: 		turn_off_leds;
	BSF         PORTC+0, 2 
	BCF         PORTA+0, 4 
	BCF         PORTC+0, 0 
	BCF         PORTC+0, 1 
	BCF         PORTC+0, 2 
;API.c,29 :: 		ch++;
	MOVF        _ch+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ch+0 
;API.c,30 :: 		if(ch>=4)ch=0;
	MOVLW       4
	SUBWF       _ch+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_send_AD_result6
	CLRF        _ch+0 
L_send_AD_result6:
;API.c,31 :: 		switch(ch){
	GOTO        L_send_AD_result7
;API.c,32 :: 		case 0:if(ADC_channel_EN[0]){channel0;break;}
L_send_AD_result9:
	MOVF        _ADC_channel_EN+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result10
	CLRF        _ch+0 
	BSF         PORTA+0, 4 
	BCF         ADCON0+0, 5 
	BCF         ADCON0+0, 4 
	BCF         ADCON0+0, 3 
	BCF         ADCON0+0, 2 
	GOTO        L_send_AD_result8
L_send_AD_result10:
;API.c,33 :: 		case 1:if(ADC_channel_EN[1]){channel1;break;}
L_send_AD_result14:
	MOVF        _ADC_channel_EN+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result15
	MOVLW       1
	MOVWF       _ch+0 
	BSF         PORTC+0, 0 
	BCF         ADCON0+0, 5 
	BCF         ADCON0+0, 4 
	BCF         ADCON0+0, 3 
	BSF         ADCON0+0, 2 
	GOTO        L_send_AD_result8
L_send_AD_result15:
;API.c,34 :: 		case 2:if(ADC_channel_EN[2]){channel2;break;}
L_send_AD_result19:
	MOVF        _ADC_channel_EN+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result20
	MOVLW       2
	MOVWF       _ch+0 
	BSF         PORTC+0, 1 
	BCF         ADCON0+0, 5 
	BCF         ADCON0+0, 4 
	BSF         ADCON0+0, 3 
	BCF         ADCON0+0, 2 
	GOTO        L_send_AD_result8
L_send_AD_result20:
;API.c,35 :: 		case 3:if(ADC_channel_EN[3]){channel4;break;}
L_send_AD_result24:
	MOVF        _ADC_channel_EN+3, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result25
	MOVLW       3
	MOVWF       _ch+0 
	BSF         PORTC+0, 2 
	BCF         ADCON0+0, 5 
	BSF         ADCON0+0, 4 
	BCF         ADCON0+0, 3 
	BCF         ADCON0+0, 2 
	GOTO        L_send_AD_result8
L_send_AD_result25:
;API.c,36 :: 		else if(ADC_channel_EN[0]){channel0;break;}
	MOVF        _ADC_channel_EN+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result30
	CLRF        _ch+0 
	BSF         PORTA+0, 4 
	BCF         ADCON0+0, 5 
	BCF         ADCON0+0, 4 
	BCF         ADCON0+0, 3 
	BCF         ADCON0+0, 2 
	GOTO        L_send_AD_result8
L_send_AD_result30:
;API.c,37 :: 		}
	GOTO        L_send_AD_result8
L_send_AD_result7:
	MOVF        _ch+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result9
	MOVF        _ch+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result14
	MOVF        _ch+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result19
	MOVF        _ch+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_send_AD_result24
L_send_AD_result8:
;API.c,38 :: 		return;
;API.c,39 :: 		}
L_end_send_AD_result:
	RETURN      0
; end of _send_AD_result

_read_ZB_frame:

;API.c,42 :: 		read_ZB_frame(void){
;API.c,45 :: 		if(RCREG == 0x7E)length=receive_frame(buf);
	MOVF        RCREG+0, 0 
	XORLW       126
	BTFSS       STATUS+0, 2 
	GOTO        L_read_ZB_frame34
	MOVLW       _buf+0
	MOVWF       FARG_receive_frame_buf+0 
	MOVLW       hi_addr(_buf+0)
	MOVWF       FARG_receive_frame_buf+1 
	CALL        _receive_frame+0, 0
	MOVF        R0, 0 
	MOVWF       read_ZB_frame_length_L0+0 
	MOVF        R1, 0 
	MOVWF       read_ZB_frame_length_L0+1 
	GOTO        L_read_ZB_frame35
L_read_ZB_frame34:
;API.c,46 :: 		else return;
	GOTO        L_end_read_ZB_frame
L_read_ZB_frame35:
;API.c,48 :: 		if(decode_API_frame(buf,length)!=NULL){
	MOVLW       _buf+0
	MOVWF       FARG_decode_API_frame_buf+0 
	MOVLW       hi_addr(_buf+0)
	MOVWF       FARG_decode_API_frame_buf+1 
	MOVF        read_ZB_frame_length_L0+0, 0 
	MOVWF       FARG_decode_API_frame_n+0 
	MOVF        read_ZB_frame_length_L0+1, 0 
	MOVWF       FARG_decode_API_frame_n+1 
	CALL        _decode_API_frame+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_ZB_frame106
	MOVLW       0
	XORWF       R0, 0 
L__read_ZB_frame106:
	BTFSC       STATUS+0, 2 
	GOTO        L_read_ZB_frame36
;API.c,50 :: 		switch(my_data.cmdID){
	GOTO        L_read_ZB_frame37
;API.c,52 :: 		case ZBRECVPCK:
L_read_ZB_frame39:
;API.c,53 :: 		length=get_ZBRCV_packet_data(&my_data,buf);
	MOVLW       _my_data+0
	MOVWF       FARG_get_ZBRCV_packet_data_my_data+0 
	MOVLW       hi_addr(_my_data+0)
	MOVWF       FARG_get_ZBRCV_packet_data_my_data+1 
	MOVLW       _buf+0
	MOVWF       FARG_get_ZBRCV_packet_data_buf+0 
	MOVLW       hi_addr(_buf+0)
	MOVWF       FARG_get_ZBRCV_packet_data_buf+1 
	CALL        _get_ZBRCV_packet_data+0, 0
	MOVF        R0, 0 
	MOVWF       read_ZB_frame_length_L0+0 
	MOVLW       0
	MOVWF       read_ZB_frame_length_L0+1 
;API.c,54 :: 		actions(buf, length);
	MOVLW       _buf+0
	MOVWF       FARG_actions_buf+0 
	MOVLW       hi_addr(_buf+0)
	MOVWF       FARG_actions_buf+1 
	MOVF        read_ZB_frame_length_L0+0, 0 
	MOVWF       FARG_actions_length+0 
	CALL        _actions+0, 0
;API.c,55 :: 		break;
	GOTO        L_read_ZB_frame38
;API.c,56 :: 		case ATRESPONSE:
L_read_ZB_frame40:
;API.c,57 :: 		if(get_AT_response_status(&my_data)==ATOK){}
	MOVLW       _my_data+0
	MOVWF       FARG_get_AT_response_status_my_data+0 
	MOVLW       hi_addr(_my_data+0)
	MOVWF       FARG_get_AT_response_status_my_data+1 
	CALL        _get_AT_response_status+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_read_ZB_frame41
	GOTO        L_read_ZB_frame42
L_read_ZB_frame41:
;API.c,58 :: 		else {connect=FALSE;handshake();}
	CLRF        _connect+0 
	CALL        _handshake+0, 0
L_read_ZB_frame42:
;API.c,59 :: 		default:break;
L_read_ZB_frame43:
	GOTO        L_read_ZB_frame38
;API.c,61 :: 		}
L_read_ZB_frame37:
	MOVF        _my_data+0, 0 
	XORLW       144
	BTFSC       STATUS+0, 2 
	GOTO        L_read_ZB_frame39
	MOVF        _my_data+0, 0 
	XORLW       136
	BTFSC       STATUS+0, 2 
	GOTO        L_read_ZB_frame40
	GOTO        L_read_ZB_frame43
L_read_ZB_frame38:
;API.c,62 :: 		}
L_read_ZB_frame36:
;API.c,63 :: 		return;
;API.c,65 :: 		}
L_end_read_ZB_frame:
	RETURN      0
; end of _read_ZB_frame

_actions:

;API.c,68 :: 		actions(unsigned char * buf, unsigned char length){
;API.c,69 :: 		switch(buf[0]){
	MOVF        FARG_actions_buf+0, 0 
	MOVWF       FLOC__actions+0 
	MOVF        FARG_actions_buf+1, 0 
	MOVWF       FLOC__actions+1 
	GOTO        L_actions44
;API.c,70 :: 		case 'S': //Set channel to ennable
L_actions46:
;API.c,71 :: 		if(length>=4){enable_channel(buf);
	MOVLW       4
	SUBWF       FARG_actions_length+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_actions47
	MOVLW       1
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_actions51
	MOVLW       1
	MOVWF       _ADC_channel_EN+0 
	GOTO        L_actions52
L_actions51:
	CLRF        _ADC_channel_EN+0 
L_actions52:
	MOVLW       2
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_actions53
	MOVLW       1
	MOVWF       _ADC_channel_EN+1 
	GOTO        L_actions54
L_actions53:
	CLRF        _ADC_channel_EN+1 
L_actions54:
	MOVLW       3
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_actions55
	MOVLW       1
	MOVWF       _ADC_channel_EN+2 
	GOTO        L_actions56
L_actions55:
	CLRF        _ADC_channel_EN+2 
L_actions56:
	MOVLW       4
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_actions57
	MOVLW       1
	MOVWF       _ADC_channel_EN+3 
	GOTO        L_actions58
L_actions57:
	CLRF        _ADC_channel_EN+3 
L_actions58:
;API.c,72 :: 		send("SOK",3);
	MOVLW       ?lstr1_API+0
	MOVWF       FARG_send_buf+0 
	MOVLW       hi_addr(?lstr1_API+0)
	MOVWF       FARG_send_buf+1 
	MOVLW       3
	MOVWF       FARG_send_len+0 
	CALL        _send+0, 0
;API.c,73 :: 		}
L_actions47:
;API.c,74 :: 		break;
	GOTO        L_actions45
;API.c,75 :: 		case 'T'://Set sample time in sec
L_actions59:
;API.c,76 :: 		if(length>=3){sample_time=((buf[1]<<8)|buf[2]);
	MOVLW       3
	SUBWF       FARG_actions_length+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_actions60
	MOVLW       1
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVLW       2
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	IORWF       R0, 0 
	MOVWF       _sample_time+0 
	MOVF        R1, 0 
	MOVWF       _sample_time+1 
	MOVLW       0
	IORWF       _sample_time+1, 1 
;API.c,77 :: 		send("TOK",3);
	MOVLW       ?lstr2_API+0
	MOVWF       FARG_send_buf+0 
	MOVLW       hi_addr(?lstr2_API+0)
	MOVWF       FARG_send_buf+1 
	MOVLW       3
	MOVWF       FARG_send_len+0 
	CALL        _send+0, 0
;API.c,78 :: 		}
L_actions60:
;API.c,79 :: 		break;
	GOTO        L_actions45
;API.c,80 :: 		case 'H'://Handshake
L_actions61:
;API.c,81 :: 		if(length>=2){
	MOVLW       2
	SUBWF       FARG_actions_length+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_actions62
;API.c,82 :: 		zigbee_id=buf[1];
	MOVLW       1
	ADDWF       FARG_actions_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_actions_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _zigbee_id+0 
;API.c,83 :: 		connect=TRUE;
	MOVLW       1
	MOVWF       _connect+0 
;API.c,84 :: 		send("HOK",3);
	MOVLW       ?lstr3_API+0
	MOVWF       FARG_send_buf+0 
	MOVLW       hi_addr(?lstr3_API+0)
	MOVWF       FARG_send_buf+1 
	MOVLW       3
	MOVWF       FARG_send_len+0 
	CALL        _send+0, 0
;API.c,85 :: 		}
L_actions62:
;API.c,86 :: 		break;
	GOTO        L_actions45
;API.c,87 :: 		default:
L_actions63:
;API.c,88 :: 		send("Received something else",23);
	MOVLW       ?lstr4_API+0
	MOVWF       FARG_send_buf+0 
	MOVLW       hi_addr(?lstr4_API+0)
	MOVWF       FARG_send_buf+1 
	MOVLW       23
	MOVWF       FARG_send_len+0 
	CALL        _send+0, 0
;API.c,89 :: 		break;
	GOTO        L_actions45
;API.c,90 :: 		}
L_actions44:
	MOVFF       FLOC__actions+0, FSR0
	MOVFF       FLOC__actions+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       83
	BTFSC       STATUS+0, 2 
	GOTO        L_actions46
	MOVFF       FLOC__actions+0, FSR0
	MOVFF       FLOC__actions+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       84
	BTFSC       STATUS+0, 2 
	GOTO        L_actions59
	MOVFF       FLOC__actions+0, FSR0
	MOVFF       FLOC__actions+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       72
	BTFSC       STATUS+0, 2 
	GOTO        L_actions61
	GOTO        L_actions63
L_actions45:
;API.c,91 :: 		return;
;API.c,92 :: 		}
L_end_actions:
	RETURN      0
; end of _actions

_init:

;API.c,97 :: 		init(void){
;API.c,99 :: 		TRISC = 0b11000000;
	MOVLW       192
	MOVWF       TRISC+0 
;API.c,100 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;API.c,101 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;API.c,102 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;API.c,103 :: 		PORTC.RC4 = 0;
	BCF         PORTC+0, 4 
;API.c,104 :: 		PORTC.RC5 = 0;
	BCF         PORTC+0, 5 
;API.c,105 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;API.c,106 :: 		BAUDCON.TXCKP = 1; //Tx Data is inverted
	BSF         BAUDCON+0, 4 
;API.c,107 :: 		BAUDCON.RXDTP = 1; //Rx Data is inverted
	BSF         BAUDCON+0, 5 
;API.c,108 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_init64:
	DECFSZ      R13, 1, 1
	BRA         L_init64
	DECFSZ      R12, 1, 1
	BRA         L_init64
	DECFSZ      R11, 1, 1
	BRA         L_init64
	NOP
	NOP
;API.c,111 :: 		TRISA = 0b00101111;
	MOVLW       47
	MOVWF       TRISA+0 
;API.c,112 :: 		PORTA.RA4=0;
	BCF         PORTA+0, 4 
;API.c,114 :: 		ADCON1.VCFG1 = 0;//VSS REFERENCE
	BCF         ADCON1+0, 5 
;API.c,115 :: 		ADCON1.VCFG0 = 1;//AN3 REFERENCE
	BSF         ADCON1+0, 4 
;API.c,116 :: 		ADCON1.PCFG3 = 1;//AN0-4 analog input
	BSF         ADCON1+0, 3 
;API.c,117 :: 		ADCON1.PCFG2 = 0;
	BCF         ADCON1+0, 2 
;API.c,118 :: 		ADCON1.PCFG1 = 1;
	BSF         ADCON1+0, 1 
;API.c,119 :: 		ADCON1.PCFG0 = 0;
	BCF         ADCON1+0, 0 
;API.c,121 :: 		channel0;
	CLRF        _ch+0 
	BSF         PORTA+0, 4 
	BCF         ADCON0+0, 5 
	BCF         ADCON0+0, 4 
	BCF         ADCON0+0, 3 
	BCF         ADCON0+0, 2 
;API.c,123 :: 		ADCON2.ACQT2 = 0; //2Tad
	BCF         ADCON2+0, 5 
;API.c,124 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;API.c,125 :: 		ADCON2.ACQT0 = 1;
	BSF         ADCON2+0, 3 
;API.c,127 :: 		ADCON2.ADCS2 = 1; //64Tosc
	BSF         ADCON2+0, 2 
;API.c,128 :: 		ADCON2.ADCS1 = 1;
	BSF         ADCON2+0, 1 
;API.c,129 :: 		ADCON2.ADCS0 = 0;
	BCF         ADCON2+0, 0 
;API.c,131 :: 		ADCON2.ADFM = 1;
	BSF         ADCON2+0, 7 
;API.c,133 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;API.c,135 :: 		turn_off_leds;
	BSF         PORTC+0, 2 
	BCF         PORTA+0, 4 
	BCF         PORTC+0, 0 
	BCF         PORTC+0, 1 
	BCF         PORTC+0, 2 
;API.c,138 :: 		T0CON.TMR0ON = 0; //Off
	BCF         T0CON+0, 7 
;API.c,139 :: 		T0CON.T08BIT = 0; //16 bit
	BCF         T0CON+0, 6 
;API.c,140 :: 		T0CON.T0CS = 0;//Internal instruction cycle clock (CLKO)
	BCF         T0CON+0, 5 
;API.c,141 :: 		T0CON.T0SE = 0;//Rising Edge
	BCF         T0CON+0, 4 
;API.c,142 :: 		T0CON.PSA = 0;//Timer0 clock input comes from prescaler output.
	BCF         T0CON+0, 3 
;API.c,143 :: 		T0CON.T0PS2 = 1; //Prescaler 64
	BSF         T0CON+0, 2 
;API.c,144 :: 		T0CON.T0PS1 = 0;
	BCF         T0CON+0, 1 
;API.c,145 :: 		T0CON.T0PS0 = 1;
	BSF         T0CON+0, 0 
;API.c,149 :: 		PIR1.ADIF = 0;//Clear A/D Conversion Flag
	BCF         PIR1+0, 6 
;API.c,150 :: 		PIR1.RCIF = 0;//The EUSART receive buffer(RCREG) is empty
	BCF         PIR1+0, 5 
;API.c,151 :: 		INTCON.TMR0IF = 0;//TMR0 register did not overflow
	BCF         INTCON+0, 2 
;API.c,153 :: 		PIE1.ADIE = 1;//Enables the A/D interrupt
	BSF         PIE1+0, 6 
;API.c,154 :: 		PIE1.RCIE = 1;//Enables the EUSART receive interrupt
	BSF         PIE1+0, 5 
;API.c,156 :: 		IPR1.ADIP = 0;//A/D Converter Interrupt Priority bit LOW
	BCF         IPR1+0, 6 
;API.c,157 :: 		IPR1.RCIP = 1;//EUSART Receive Interrupt Priority bit HIGH
	BSF         IPR1+0, 5 
;API.c,158 :: 		INTCON.TMR0IP = 0;//TMR0 Overflow Interrupt Priority bit LOW
	BCF         INTCON+0, 2 
;API.c,160 :: 		RCON.IPEN = 1;//Enable priority levels on interrupts
	BSF         RCON+0, 7 
;API.c,162 :: 		INTCON.GIEH = 1;//Enables all high-priority interrupts
	BSF         INTCON+0, 7 
;API.c,163 :: 		INTCON.GIEL = 1;//Enables all low-priority peripheral interrupts (if GIE/GIEH = 1)
	BSF         INTCON+0, 6 
;API.c,164 :: 		INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
	BSF         INTCON+0, 5 
;API.c,167 :: 		ATCMD_init();//AT commands structure to generate API frames
	CALL        _ATCMD_init+0, 0
;API.c,168 :: 		ZBTR_init(addr64,addr16);//Transmit structure to generate API frames
	MOVLW       _addr64+0
	MOVWF       FARG_ZBTR_init_addr64+0 
	MOVLW       hi_addr(_addr64+0)
	MOVWF       FARG_ZBTR_init_addr64+1 
	MOVLW       _addr16+0
	MOVWF       FARG_ZBTR_init_addr16+0 
	MOVLW       hi_addr(_addr16+0)
	MOVWF       FARG_ZBTR_init_addr16+1 
	CALL        _ZBTR_init+0, 0
;API.c,169 :: 		RATCMD_init(addr64,addr16);//Remote AT to generate API frames
	MOVLW       _addr64+0
	MOVWF       FARG_RATCMD_init_addr64+0 
	MOVLW       hi_addr(_addr64+0)
	MOVWF       FARG_RATCMD_init_addr64+1 
	MOVLW       _addr16+0
	MOVWF       FARG_RATCMD_init_addr16+0 
	MOVLW       hi_addr(_addr16+0)
	MOVWF       FARG_RATCMD_init_addr16+1 
	CALL        _RATCMD_init+0, 0
;API.c,171 :: 		return;
;API.c,172 :: 		}
L_end_init:
	RETURN      0
; end of _init

_interrupt:

;API.c,176 :: 		interrupt(void){
;API.c,177 :: 		int i, sum=0;
	CLRF        interrupt_sum_L0+0 
	CLRF        interrupt_sum_L0+1 
;API.c,180 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt71
;API.c,182 :: 		INTCON.TMR0IE = 0;//TMR0 Overflow Interrupt Enable
	BCF         INTCON+0, 5 
;API.c,184 :: 		if(connect!=TRUE)handshake();
	MOVF        _connect+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt72
	CALL        _handshake+0, 0
	GOTO        L_interrupt73
L_interrupt72:
;API.c,185 :: 		else if(connect==TRUE){
	MOVF        _connect+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt74
;API.c,187 :: 		for(i=0;i<4;i++)sum+=ADC_channel_EN[i];
	CLRF        interrupt_i_L0+0 
	CLRF        interrupt_i_L0+1 
L_interrupt75:
	MOVLW       128
	XORWF       interrupt_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt111
	MOVLW       4
	SUBWF       interrupt_i_L0+0, 0 
L__interrupt111:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt76
	MOVLW       _ADC_channel_EN+0
	ADDWF       interrupt_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_ADC_channel_EN+0)
	ADDWFC      interrupt_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       interrupt_sum_L0+0, 1 
	MOVLW       0
	ADDWFC      interrupt_sum_L0+1, 1 
	INFSNZ      interrupt_i_L0+0, 1 
	INCF        interrupt_i_L0+1, 1 
	GOTO        L_interrupt75
L_interrupt76:
;API.c,188 :: 		if(sum==0)ADCON0.GO=0;
	MOVLW       0
	XORWF       interrupt_sum_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt112
	MOVLW       0
	XORWF       interrupt_sum_L0+0, 0 
L__interrupt112:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt78
	BCF         ADCON0+0, 1 
	GOTO        L_interrupt79
L_interrupt78:
;API.c,189 :: 		else my_prescaler();
	CALL        _my_prescaler+0, 0
L_interrupt79:
;API.c,190 :: 		}
L_interrupt74:
L_interrupt73:
;API.c,192 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;API.c,194 :: 		INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
	BSF         INTCON+0, 5 
;API.c,195 :: 		return;
	GOTO        L__interrupt110
;API.c,196 :: 		}
L_interrupt71:
;API.c,199 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt80
;API.c,201 :: 		INTCON.GIEL = 0;//Disables all low-priority peripheral interrupts
	BCF         INTCON+0, 6 
;API.c,203 :: 		send_AD_result();
	CALL        _send_AD_result+0, 0
;API.c,205 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;API.c,207 :: 		INTCON.GIEL = 1;//Enables all low-priority peripheral interrupts
	BSF         INTCON+0, 6 
;API.c,208 :: 		return;
	GOTO        L__interrupt110
;API.c,209 :: 		}
L_interrupt80:
;API.c,212 :: 		if(PIR1.RCIF){
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt81
;API.c,214 :: 		INTCON.GIEH = 0;//Disables all interrupts
	BCF         INTCON+0, 7 
;API.c,216 :: 		read_ZB_frame();
	CALL        _read_ZB_frame+0, 0
;API.c,218 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;API.c,220 :: 		INTCON.GIEH = 1;//Enables all high-priority interrupts
	BSF         INTCON+0, 7 
;API.c,221 :: 		return;
	GOTO        L__interrupt110
;API.c,222 :: 		}
L_interrupt81:
;API.c,223 :: 		return;
;API.c,224 :: 		}
L_end_interrupt:
L__interrupt110:
	RETFIE      1
; end of _interrupt

_receive_frame:

;API.c,227 :: 		receive_frame(unsigned char * buf){
;API.c,229 :: 		buf[0]=0x7E;
	MOVFF       FARG_receive_frame_buf+0, FSR1
	MOVFF       FARG_receive_frame_buf+1, FSR1H
	MOVLW       126
	MOVWF       POSTINC1+0 
;API.c,230 :: 		for(i=1;i<3;i++){
	MOVLW       1
	MOVWF       receive_frame_i_L0+0 
	MOVLW       0
	MOVWF       receive_frame_i_L0+1 
L_receive_frame82:
	MOVLW       128
	XORWF       receive_frame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__receive_frame114
	MOVLW       3
	SUBWF       receive_frame_i_L0+0, 0 
L__receive_frame114:
	BTFSC       STATUS+0, 0 
	GOTO        L_receive_frame83
;API.c,231 :: 		while(!UART1_Data_Ready()){};
L_receive_frame85:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_receive_frame86
	GOTO        L_receive_frame85
L_receive_frame86:
;API.c,232 :: 		buf[i]=UART_Read();
	MOVF        receive_frame_i_L0+0, 0 
	ADDWF       FARG_receive_frame_buf+0, 0 
	MOVWF       FLOC__receive_frame+0 
	MOVF        receive_frame_i_L0+1, 0 
	ADDWFC      FARG_receive_frame_buf+1, 0 
	MOVWF       FLOC__receive_frame+1 
	CALL        _UART_Read+0, 0
	MOVFF       FLOC__receive_frame+0, FSR1
	MOVFF       FLOC__receive_frame+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;API.c,230 :: 		for(i=1;i<3;i++){
	INFSNZ      receive_frame_i_L0+0, 1 
	INCF        receive_frame_i_L0+1, 1 
;API.c,233 :: 		}
	GOTO        L_receive_frame82
L_receive_frame83:
;API.c,234 :: 		length=(((unsigned int)buf[1])<< 8)|((unsigned int)buf[2]);
	MOVLW       1
	ADDWF       FARG_receive_frame_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_receive_frame_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       receive_frame_length_L0+0 
	MOVLW       0
	MOVWF       receive_frame_length_L0+1 
	MOVF        receive_frame_length_L0+0, 0 
	MOVWF       receive_frame_length_L0+1 
	CLRF        receive_frame_length_L0+0 
	MOVLW       2
	ADDWF       FARG_receive_frame_buf+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_receive_frame_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       receive_frame_length_L0+0, 1 
	MOVF        R1, 0 
	IORWF       receive_frame_length_L0+1, 1 
;API.c,235 :: 		for(i=3;i<length+4;i++){
	MOVLW       3
	MOVWF       receive_frame_i_L0+0 
	MOVLW       0
	MOVWF       receive_frame_i_L0+1 
L_receive_frame87:
	MOVLW       4
	ADDWF       receive_frame_length_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      receive_frame_length_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       receive_frame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__receive_frame115
	MOVF        R1, 0 
	SUBWF       receive_frame_i_L0+0, 0 
L__receive_frame115:
	BTFSC       STATUS+0, 0 
	GOTO        L_receive_frame88
;API.c,236 :: 		while(!UART1_Data_Ready()){}
L_receive_frame90:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_receive_frame91
	GOTO        L_receive_frame90
L_receive_frame91:
;API.c,237 :: 		buf[i]=UART_Read();
	MOVF        receive_frame_i_L0+0, 0 
	ADDWF       FARG_receive_frame_buf+0, 0 
	MOVWF       FLOC__receive_frame+0 
	MOVF        receive_frame_i_L0+1, 0 
	ADDWFC      FARG_receive_frame_buf+1, 0 
	MOVWF       FLOC__receive_frame+1 
	CALL        _UART_Read+0, 0
	MOVFF       FLOC__receive_frame+0, FSR1
	MOVFF       FLOC__receive_frame+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;API.c,235 :: 		for(i=3;i<length+4;i++){
	INFSNZ      receive_frame_i_L0+0, 1 
	INCF        receive_frame_i_L0+1, 1 
;API.c,238 :: 		}
	GOTO        L_receive_frame87
L_receive_frame88:
;API.c,239 :: 		return length+4;
	MOVLW       4
	ADDWF       receive_frame_length_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      receive_frame_length_L0+1, 0 
	MOVWF       R1 
;API.c,240 :: 		}
L_end_receive_frame:
	RETURN      0
; end of _receive_frame

_send:

;API.c,243 :: 		send(unsigned char * buf, unsigned char len){
;API.c,246 :: 		API_frame=_zbtr.request(buf,len);
	MOVF        __zbtr+12, 0 
	MOVWF       FSR1 
	MOVF        __zbtr+13, 0 
	MOVWF       FSR1H 
	MOVF        FARG_send_buf+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_send_buf+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_send_len+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        __zbtr+10, 0 
	MOVWF       R0 
	MOVF        __zbtr+11, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
	MOVF        R0, 0 
	MOVWF       _API_frame+0 
	MOVF        R1, 0 
	MOVWF       _API_frame+1 
;API.c,247 :: 		for(i=0;i<API_frame_length(API_frame); i++)
	CLRF        send_i_L0+0 
	CLRF        send_i_L0+1 
L_send92:
	MOVF        _API_frame+0, 0 
	MOVWF       FARG_API_frame_length_API_frame+0 
	MOVF        _API_frame+1, 0 
	MOVWF       FARG_API_frame_length_API_frame+1 
	CALL        _API_frame_length+0, 0
	MOVLW       128
	XORWF       send_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       128
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__send117
	MOVF        R0, 0 
	SUBWF       send_i_L0+0, 0 
L__send117:
	BTFSC       STATUS+0, 0 
	GOTO        L_send93
;API.c,248 :: 		UART1_Write(API_frame[i]);
	MOVF        send_i_L0+0, 0 
	ADDWF       _API_frame+0, 0 
	MOVWF       FSR0 
	MOVF        send_i_L0+1, 0 
	ADDWFC      _API_frame+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;API.c,247 :: 		for(i=0;i<API_frame_length(API_frame); i++)
	INFSNZ      send_i_L0+0, 1 
	INCF        send_i_L0+1, 1 
;API.c,248 :: 		UART1_Write(API_frame[i]);
	GOTO        L_send92
L_send93:
;API.c,249 :: 		}
L_end_send:
	RETURN      0
; end of _send

_my_prescaler:

;API.c,251 :: 		my_prescaler(void){//Multiples of 0.84seconds
;API.c,252 :: 		presc++;
	MOVLW       1
	ADDWF       _presc+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _presc+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _presc+0 
	MOVF        R1, 0 
	MOVWF       _presc+1 
;API.c,253 :: 		if(presc>=(sample_time*100/84)){
	MOVF        _sample_time+0, 0 
	MOVWF       R0 
	MOVF        _sample_time+1, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       84
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R1, 0 
	SUBWF       _presc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__my_prescaler119
	MOVF        R0, 0 
	SUBWF       _presc+0, 0 
L__my_prescaler119:
	BTFSS       STATUS+0, 0 
	GOTO        L_my_prescaler95
;API.c,254 :: 		ADCON0.GO = 1;//RE-Start Conversion
	BSF         ADCON0+0, 1 
;API.c,255 :: 		presc=0;}
	CLRF        _presc+0 
	CLRF        _presc+1 
L_my_prescaler95:
;API.c,256 :: 		return;
;API.c,257 :: 		}
L_end_my_prescaler:
	RETURN      0
; end of _my_prescaler

_handshake:

;API.c,260 :: 		handshake(void){
;API.c,264 :: 		if(connect==FALSE){
	MOVF        _connect+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_handshake96
;API.c,265 :: 		buf[0]='C';
	MOVLW       67
	MOVWF       handshake_buf_L0+0 
;API.c,266 :: 		buf[1]='B';
	MOVLW       66
	MOVWF       handshake_buf_L0+1 
;API.c,267 :: 		buf[2]=1;
	MOVLW       1
	MOVWF       handshake_buf_L0+2 
;API.c,268 :: 		API_frame=_atcmd.request(buf,3);
	MOVF        __atcmd+9, 0 
	MOVWF       FSR1 
	MOVF        __atcmd+10, 0 
	MOVWF       FSR1H 
	MOVLW       handshake_buf_L0+0
	MOVWF       POSTINC1+0 
	MOVLW       hi_addr(handshake_buf_L0+0)
	MOVWF       POSTINC1+0 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVF        __atcmd+7, 0 
	MOVWF       R0 
	MOVF        __atcmd+8, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
	MOVF        R0, 0 
	MOVWF       _API_frame+0 
	MOVF        R1, 0 
	MOVWF       _API_frame+1 
;API.c,269 :: 		for(i=0;i<API_frame_length(API_frame); i++)
	CLRF        handshake_i_L0+0 
	CLRF        handshake_i_L0+1 
L_handshake97:
	MOVF        _API_frame+0, 0 
	MOVWF       FARG_API_frame_length_API_frame+0 
	MOVF        _API_frame+1, 0 
	MOVWF       FARG_API_frame_length_API_frame+1 
	CALL        _API_frame_length+0, 0
	MOVLW       128
	XORWF       handshake_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       128
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__handshake121
	MOVF        R0, 0 
	SUBWF       handshake_i_L0+0, 0 
L__handshake121:
	BTFSC       STATUS+0, 0 
	GOTO        L_handshake98
;API.c,270 :: 		UART1_Write(API_frame[i]);
	MOVF        handshake_i_L0+0, 0 
	ADDWF       _API_frame+0, 0 
	MOVWF       FSR0 
	MOVF        handshake_i_L0+1, 0 
	ADDWFC      _API_frame+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;API.c,269 :: 		for(i=0;i<API_frame_length(API_frame); i++)
	INFSNZ      handshake_i_L0+0, 1 
	INCF        handshake_i_L0+1, 1 
;API.c,270 :: 		UART1_Write(API_frame[i]);
	GOTO        L_handshake97
L_handshake98:
;API.c,271 :: 		connect=WAIT;
	MOVLW       2
	MOVWF       _connect+0 
;API.c,272 :: 		}
	GOTO        L_handshake100
L_handshake96:
;API.c,273 :: 		else if(connect==WAIT){
	MOVF        _connect+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_handshake101
;API.c,274 :: 		presc++;
	MOVLW       1
	ADDWF       _presc+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _presc+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _presc+0 
	MOVF        R1, 0 
	MOVWF       _presc+1 
;API.c,275 :: 		if(presc>=10){
	MOVLW       0
	SUBWF       _presc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__handshake122
	MOVLW       10
	SUBWF       _presc+0, 0 
L__handshake122:
	BTFSS       STATUS+0, 0 
	GOTO        L_handshake102
;API.c,276 :: 		connect = FALSE;//RE-Start Connection
	CLRF        _connect+0 
;API.c,277 :: 		presc=0;}
	CLRF        _presc+0 
	CLRF        _presc+1 
L_handshake102:
;API.c,278 :: 		}
L_handshake101:
L_handshake100:
;API.c,281 :: 		}
L_end_handshake:
	RETURN      0
; end of _handshake
