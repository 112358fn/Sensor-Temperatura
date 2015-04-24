
_main:

;EUART.c,6 :: 		void main(void)
;EUART.c,8 :: 		TRISC = 0b11000000;
	MOVLW       192
	MOVWF       TRISC+0 
;EUART.c,9 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;EUART.c,10 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;EUART.c,11 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;EUART.c,12 :: 		PORTC.RC4 = 0;
	BCF         PORTC+0, 4 
;EUART.c,13 :: 		PORTC.RC5 = 0;
	BCF         PORTC+0, 5 
;EUART.c,15 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;EUART.c,16 :: 		BAUDCON.TXCKP = 1; //Tx Data is inverted
	BSF         BAUDCON+0, 4 
;EUART.c,17 :: 		BAUDCON.RXDTP = 1; //Rx Data is inverted
	BSF         BAUDCON+0, 5 
;EUART.c,18 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
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
;EUART.c,19 :: 		while(1){
L_main1:
;EUART.c,20 :: 		while(!UART1_Data_Ready()){}
L_main3:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	GOTO        L_main3
L_main4:
;EUART.c,24 :: 		dataRx = RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       _dataRx+0 
;EUART.c,25 :: 		if(dataRx == 0x41)   // "A"
	MOVF        _dataRx+0, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;EUART.c,27 :: 		UART1_Write_Text(data1);
	MOVLW       _data1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_data1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;EUART.c,28 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;EUART.c,29 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;EUART.c,30 :: 		}
	GOTO        L_main6
L_main5:
;EUART.c,31 :: 		else if(dataRx == 0x42)    // "B"
	MOVF        _dataRx+0, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;EUART.c,33 :: 		UART1_Write_Text(data2);
	MOVLW       _data2+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_data2+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;EUART.c,34 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;EUART.c,35 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;EUART.c,36 :: 		}
	GOTO        L_main8
L_main7:
;EUART.c,39 :: 		UART1_Write_Text(uhOh);
	MOVLW       _uhOh+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_uhOh+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;EUART.c,40 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;EUART.c,41 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;EUART.c,42 :: 		}
L_main8:
L_main6:
;EUART.c,43 :: 		}
	GOTO        L_main1
;EUART.c,44 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
