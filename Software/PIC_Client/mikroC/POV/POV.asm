
_init:

;POV.c,252 :: 		void init(void){
;POV.c,256 :: 		TRISA.RA0 = 0;
	BCF         TRISA+0, 0 
;POV.c,257 :: 		TRISA.RA1 = 0;
	BCF         TRISA+0, 1 
;POV.c,258 :: 		TRISA.RA2 = 0;
	BCF         TRISA+0, 2 
;POV.c,259 :: 		TRISA.RA3 = 0;
	BCF         TRISA+0, 3 
;POV.c,260 :: 		TRISA.RA4 = 0;
	BCF         TRISA+0, 4 
;POV.c,261 :: 		TRISA.RA5 = 0;
	BCF         TRISA+0, 5 
;POV.c,263 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;POV.c,264 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;POV.c,266 :: 		T0CON.TMR0ON = 0; //Off
	BCF         T0CON+0, 7 
;POV.c,267 :: 		T0CON.T08BIT = 0; //16 bit
	BCF         T0CON+0, 6 
;POV.c,268 :: 		T0CON.T0CS = 0;//Internal instruction cycle clock (CLKO)
	BCF         T0CON+0, 5 
;POV.c,269 :: 		T0CON.T0SE = 0;//Rising Edge
	BCF         T0CON+0, 4 
;POV.c,270 :: 		T0CON.PSA = 0;//Timer0 clock input comes from prescaler output.
	BCF         T0CON+0, 3 
;POV.c,271 :: 		T0CON.T0PS2 = 0; //Prescaler 256
	BCF         T0CON+0, 2 
;POV.c,272 :: 		T0CON.T0PS1 = 1;
	BSF         T0CON+0, 1 
;POV.c,273 :: 		T0CON.T0PS0 = 0;
	BCF         T0CON+0, 0 
;POV.c,275 :: 		INTCON.GIE = 1;//Global Interrupt Enable
	BSF         INTCON+0, 7 
;POV.c,276 :: 		INTCON.PEIE = 0;//Peripheral Interrupt Disable
	BCF         INTCON+0, 6 
;POV.c,277 :: 		INTCON.INT0IE = 0;//INT0 External Interrupt Disable
	BCF         INTCON+0, 4 
;POV.c,278 :: 		INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
	BSF         INTCON+0, 5 
;POV.c,280 :: 		return;
;POV.c,281 :: 		}
L_end_init:
	RETURN      0
; end of _init

_printLetter:

;POV.c,284 :: 		void printLetter(int * letter){
;POV.c,286 :: 		for(i=1; i<letter[0]; i++){
	MOVLW       1
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
L_printLetter0:
	MOVFF       FARG_printLetter_letter+0, FSR0
	MOVFF       FARG_printLetter_letter+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R6, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__printLetter12
	MOVF        R1, 0 
	SUBWF       R5, 0 
L__printLetter12:
	BTFSC       STATUS+0, 0 
	GOTO        L_printLetter1
;POV.c,287 :: 		PORTA = letter[i] & 0x3F;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_printLetter_letter+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_printLetter_letter+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVLW       63
	ANDWF       POSTINC0+0, 0 
	MOVWF       PORTA+0 
;POV.c,288 :: 		PORTC = (letter[i]&0xC0)>>6;
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVLW       192
	ANDWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVLW       6
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__printLetter13:
	BZ          L__printLetter14
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__printLetter13
L__printLetter14:
	MOVF        R0, 0 
	MOVWF       PORTC+0 
;POV.c,289 :: 		delay_ms(3);//Ancho letra
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       201
	MOVWF       R13, 0
L_printLetter3:
	DECFSZ      R13, 1, 1
	BRA         L_printLetter3
	DECFSZ      R12, 1, 1
	BRA         L_printLetter3
	NOP
	NOP
;POV.c,286 :: 		for(i=1; i<letter[0]; i++){
	INFSNZ      R5, 1 
	INCF        R6, 1 
;POV.c,290 :: 		}
	GOTO        L_printLetter0
L_printLetter1:
;POV.c,292 :: 		return;
;POV.c,293 :: 		}
L_end_printLetter:
	RETURN      0
; end of _printLetter

_interrupt:

;POV.c,295 :: 		void interrupt(void){
;POV.c,298 :: 		INTCON.TMR0IE = 0;//TMR0 Overflow Interrupt Enable
	BCF         INTCON+0, 5 
;POV.c,300 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;POV.c,301 :: 		for(i=0; i<MsgLen; i++)printLetter(Msg[i]);
	CLRF        interrupt_i_L0+0 
	CLRF        interrupt_i_L0+1 
L_interrupt5:
	MOVLW       128
	XORWF       interrupt_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _MsgLen+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVF        _MsgLen+0, 0 
	SUBWF       interrupt_i_L0+0, 0 
L__interrupt17:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt6
	MOVF        interrupt_i_L0+0, 0 
	MOVWF       R0 
	MOVF        interrupt_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _Msg+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_Msg+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_printLetter_letter+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_printLetter_letter+1 
	CALL        _printLetter+0, 0
	INFSNZ      interrupt_i_L0+0, 1 
	INCF        interrupt_i_L0+1, 1 
	GOTO        L_interrupt5
L_interrupt6:
;POV.c,302 :: 		}
L_interrupt4:
;POV.c,304 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;POV.c,306 :: 		INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
	BSF         INTCON+0, 5 
;POV.c,307 :: 		}
L_end_interrupt:
L__interrupt16:
	RETFIE      1
; end of _interrupt

_main:

;POV.c,311 :: 		void main(){
;POV.c,313 :: 		init();
	CALL        _init+0, 0
;POV.c,315 :: 		T0CON.TMR0ON = 1; //On
	BSF         T0CON+0, 7 
;POV.c,316 :: 		while(1){};
L_main8:
	GOTO        L_main8
;POV.c,318 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
