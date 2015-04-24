
_init:

;ADC.c,8 :: 		void init(void){
;ADC.c,10 :: 		TRISC = 0b11000000;
	MOVLW       192
	MOVWF       TRISC+0 
;ADC.c,11 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ADC.c,12 :: 		BAUDCON.TXCKP = 1;
	BSF         BAUDCON+0, 4 
;ADC.c,13 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_init0:
	DECFSZ      R13, 1, 1
	BRA         L_init0
	DECFSZ      R12, 1, 1
	BRA         L_init0
	DECFSZ      R11, 1, 1
	BRA         L_init0
	NOP
;ADC.c,15 :: 		TRISA = 0b00001111;
	MOVLW       15
	MOVWF       TRISA+0 
;ADC.c,17 :: 		ADCON1.VCFG1 = 0;//VSS REFERENCE
	BCF         ADCON1+0, 5 
;ADC.c,18 :: 		ADCON1.VCFG0 = 1;//AN3 REFERENCE
	BSF         ADCON1+0, 4 
;ADC.c,19 :: 		ADCON1.PCFG3 = 1;//AN0-3 analog input
	BSF         ADCON1+0, 3 
;ADC.c,20 :: 		ADCON1.PCFG2 = 0;
	BCF         ADCON1+0, 2 
;ADC.c,21 :: 		ADCON1.PCFG1 = 1;
	BSF         ADCON1+0, 1 
;ADC.c,22 :: 		ADCON1.PCFG0 = 1;
	BSF         ADCON1+0, 0 
;ADC.c,24 :: 		ADCON0.CHS3 = 0;  //Channel AN1
	BCF         ADCON0+0, 5 
;ADC.c,25 :: 		ADCON0.CHS2 = 0;
	BCF         ADCON0+0, 4 
;ADC.c,26 :: 		ADCON0.CHS1 = 0;
	BCF         ADCON0+0, 3 
;ADC.c,27 :: 		ADCON0.CHS0 = 1;
	BSF         ADCON0+0, 2 
;ADC.c,29 :: 		ADCON2.ACQT2 = 0; //2Tad
	BCF         ADCON2+0, 5 
;ADC.c,30 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;ADC.c,31 :: 		ADCON2.ACQT0 = 1;
	BSF         ADCON2+0, 3 
;ADC.c,33 :: 		ADCON2.ADCS2 = 1; //16Tosc
	BSF         ADCON2+0, 2 
;ADC.c,34 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;ADC.c,35 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;ADC.c,37 :: 		ADCON2.ADFM = 1;
	BSF         ADCON2+0, 7 
;ADC.c,39 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;ADC.c,42 :: 		PIR1.ADIF = 0;//Clear A/D Conversion Flag
	BCF         PIR1+0, 6 
;ADC.c,44 :: 		PIE1.ADIE = 1;//Enables the A/D interrupt
	BSF         PIE1+0, 6 
;ADC.c,46 :: 		INTCON.GIE = 1;//Global Interrupt Enable
	BSF         INTCON+0, 7 
;ADC.c,47 :: 		INTCON.PEIE = 1;//Peripheral Interrupt Enable
	BSF         INTCON+0, 6 
;ADC.c,49 :: 		return;
;ADC.c,50 :: 		}
L_end_init:
	RETURN      0
; end of _init

_interrupt:

;ADC.c,52 :: 		void interrupt(void){
;ADC.c,55 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;ADC.c,57 :: 		PIE1.ADIE = 0;
	BCF         PIE1+0, 6 
;ADC.c,61 :: 		WordToStr(ceil(((ADRESH<<8)+ADRESL)*1.25), buffer);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ceil_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_ceil_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_ceil_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_ceil_x+3 
	CALL        _ceil+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       interrupt_buffer_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(interrupt_buffer_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;ADC.c,62 :: 		UART1_Write_Text(buffer);
	MOVLW       interrupt_buffer_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(interrupt_buffer_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ADC.c,63 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ADC.c,64 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ADC.c,65 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_interrupt2:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt2
	DECFSZ      R12, 1, 1
	BRA         L_interrupt2
	DECFSZ      R11, 1, 1
	BRA         L_interrupt2
	NOP
;ADC.c,67 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;ADC.c,69 :: 		PIE1.ADIE = 1;//Enables the A/D interrupt
	BSF         PIE1+0, 6 
;ADC.c,71 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 1 
;ADC.c,72 :: 		}
L_interrupt1:
;ADC.c,73 :: 		return;
;ADC.c,74 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt

_main:

;ADC.c,79 :: 		void main(void)
;ADC.c,82 :: 		init();
	CALL        _init+0, 0
;ADC.c,83 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;ADC.c,85 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 1 
;ADC.c,86 :: 		while(1){}
L_main4:
	GOTO        L_main4
;ADC.c,88 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
