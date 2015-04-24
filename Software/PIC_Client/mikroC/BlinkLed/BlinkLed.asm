
_main:

;BlinkLed.c,1 :: 		void main() {
;BlinkLed.c,4 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;BlinkLed.c,5 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;BlinkLed.c,8 :: 		while(1) {
L_main0:
;BlinkLed.c,10 :: 		PORTC.RC0 = 1;
	BSF         PORTC+0, 0 
;BlinkLed.c,11 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;BlinkLed.c,12 :: 		Delay_ms(1000);    // 1 second delay
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;BlinkLed.c,15 :: 		PORTC.RC0 = 1;
	BSF         PORTC+0, 0 
;BlinkLed.c,16 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;BlinkLed.c,17 :: 		Delay_ms(1000);    // 1 second delay
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;BlinkLed.c,18 :: 		}         // Endless loop
	GOTO        L_main0
;BlinkLed.c,20 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
