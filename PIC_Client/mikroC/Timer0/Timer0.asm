
_init:

;Timer0.c,3 :: 		void init(void){
;Timer0.c,7 :: 		TRISA = 0;
	CLRF        TRISA+0 
;Timer0.c,9 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;Timer0.c,10 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;Timer0.c,12 :: 		T0CON.TMR0ON = 0; //Off
	BCF         T0CON+0, 7 
;Timer0.c,13 :: 		T0CON.T08BIT = 0; //16 bit
	BCF         T0CON+0, 6 
;Timer0.c,14 :: 		T0CON.T0CS = 0;//Internal instruction cycle clock (CLKO)
	BCF         T0CON+0, 5 
;Timer0.c,15 :: 		T0CON.T0SE = 0;//Rising Edge
	BCF         T0CON+0, 4 
;Timer0.c,16 :: 		T0CON.PSA = 0;//Timer0 clock input comes from prescaler output.
	BCF         T0CON+0, 3 
;Timer0.c,17 :: 		T0CON.T0PS2 = 1; //Prescaler 32
	BSF         T0CON+0, 2 
;Timer0.c,18 :: 		T0CON.T0PS1 = 0;
	BCF         T0CON+0, 1 
;Timer0.c,19 :: 		T0CON.T0PS0 = 0;
	BCF         T0CON+0, 0 
;Timer0.c,21 :: 		INTCON.GIE = 1;//Global Interrupt Enable
	BSF         INTCON+0, 7 
;Timer0.c,22 :: 		INTCON.PEIE = 0;//Peripheral Interrupt Disable
	BCF         INTCON+0, 6 
;Timer0.c,23 :: 		INTCON.INT0IE = 0;//INT0 External Interrupt Disable
	BCF         INTCON+0, 4 
;Timer0.c,24 :: 		INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
	BSF         INTCON+0, 5 
;Timer0.c,25 :: 		}
L_end_init:
	RETURN      0
; end of _init

_interrupt:

;Timer0.c,28 :: 		void interrupt(void){
;Timer0.c,30 :: 		INTCON.TMR0IE = 0;//TMR0 Overflow Interrupt Enable
	BCF         INTCON+0, 5 
;Timer0.c,32 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;Timer0.c,34 :: 		PORTA.RA0 =  PORTA.RA0 > 0 ? 0:1;
	CLRF        R1 
	BTFSC       PORTA+0, 0 
	INCF        R1, 1 
	MOVF        R1, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
	CLRF        R0 
	GOTO        L_interrupt2
L_interrupt1:
	MOVLW       1
	MOVWF       R0 
L_interrupt2:
	BTFSC       R0, 0 
	GOTO        L__interrupt8
	BCF         PORTA+0, 0 
	GOTO        L__interrupt9
L__interrupt8:
	BSF         PORTA+0, 0 
L__interrupt9:
;Timer0.c,35 :: 		}
L_interrupt0:
;Timer0.c,37 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Timer0.c,39 :: 		INTCON.TMR0IE = 1;//TMR0 Overflow Interrupt Enable
	BSF         INTCON+0, 5 
;Timer0.c,40 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;Timer0.c,43 :: 		void main(){
;Timer0.c,44 :: 		init();
	CALL        _init+0, 0
;Timer0.c,46 :: 		T0CON.TMR0ON = 1; //On
	BSF         T0CON+0, 7 
;Timer0.c,47 :: 		PORTB=0xff;
	MOVLW       255
	MOVWF       PORTB+0 
;Timer0.c,48 :: 		while(1){};
L_main3:
	GOTO        L_main3
;Timer0.c,49 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
