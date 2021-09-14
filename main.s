; PIC18F4550 Configuration Bit Settings

; Assembly source line config statements

#include <xc.inc>

; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = HSPLL_HS      ; Oscillator Selection bits (Internal oscillator, HS oscillator used by USB (INTHS))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = ON          ; Power-up Timer Enable bit (PWRT disabled)
//  CONFIG  BOR = OFF              ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF              ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = OFF           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = OFF           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF              ; Single-Supply ICSP Enable bit (Single-Supply ICSP enabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)

PSECT	    udata_acs
	TEMP:
		DS	1
	SEC_UNIT:	
		DS	1
	SEC_DEC:
		DS	1
	MIN:
		DS	1
	TIME:	
		DS	1
	TIME_2:	
		DS	1

;CONSTANT	MASK	0xF
;*************************************************
PSECT	    CODE
	    
ORG	    0x000			;vector de reset 
	    GOTO	MAIN		;goes to main program
	    
ORG	    0x200
DISPLAY:
	    ADDWF	PCL, F, C
	    ;DT 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67,0x77,0x7C,0x39,0x5E,0x79,0x71
	    RETLW	0x67		;9
	    RETLW	0x7F		;8
	    RETLW	0x07		;7
	    RETLW	0x7D		;6
	    RETLW	0x6D		;5
	    RETLW	0x66		;4
	    RETLW	0x4F		;3
	    RETLW	0x5B		;2
	    RETLW	0x06		;1
	    RETLW	0x3F		;0
	    RETLW	0x77		;A
	    RETLW	0x7C		;B
	    RETLW	0x39		;C
	    RETLW	0x5E		;D
	    RETLW	0x79		;E
	    RETLW	0x71		;F 

ORG	    0x020
INIT:	    
	    MOVLB	0x0F
	    
	    CLRF	LATD, C
	    CLRF	LATB, C
	    CLRF	LATA, C
	    
	    CLRF	TRISD, C
	    CLRF	TRISB, C
	    CLRF	TRISA, C
	    
	    BSF		TRISC, 0, C
	    BSF		TRISC, 1, C
	    BSF		TRISC, 2, C
	    
	    MOVLW	0
	    MOVWF	SEC_UNIT, C
	    MOVLW	8
	    MOVWF	SEC_DEC, C
	    MOVLW	14
	    MOVWF	MIN, C
	    
	    MOVLB	0x0F
	    MOVWF	ADCON1, C
	    
	    RETURN			;leaving initialization subroutine

			    
MAIN:	    CALL	INIT
    
SETUP:
	    MOVF	SEC_UNIT, W, C
	    CALL	DISPLAY
	    MOVWF	LATD, C
	    MOVF	SEC_DEC, W, C
	    CALL	DISPLAY
	    MOVWF	LATB, C
	    MOVF	MIN, W, C
	    CALL	DISPLAY
	    MOVWF	LATA, C 
			    
LOOP:	    
	    
	    CALL	DELAY
	    BTFSC	PORTC, 0, C
	    GOTO	PAUSE
	    BTFSC	PORTC, 1, C
	    GOTO	CLR_SEC
	    BTFSC	PORTC, 2, C
	    GOTO	CONFIG_1
	    GOTO	UNITS	
	    
	    
	    
UNITS:
	    MOVF	SEC_UNIT, W, C
	    CALL	DISPLAY
	    MOVWF	LATD, C
	    
	    MOVLW	18
	    SUBWF	SEC_UNIT, W, C
	    BZ		DECS
	    
	    GOTO	SECOND
		   
DECS:
	    MOVLW	0
	    MOVWF	SEC_UNIT, C
    
	    MOVLW	2
	    ADDWF	SEC_DEC, F, C	
	    
	    MOVLW	20
	    SUBWF	SEC_DEC, W, C
	    BZ		MINS
	    
	    MOVF	SEC_DEC, W, C
	    CALL	DISPLAY
	    MOVWF	LATB, C
	    MOVF	SEC_UNIT, W, C
	    CALL	DISPLAY
	    MOVWF	LATD, C
	    
	    GOTO	SECOND
	    
MINS:	    
	    MOVLW	0
	    MOVWF	SEC_UNIT, C
	    MOVLW	8
	    MOVWF	SEC_DEC, C
	    
	    MOVLW	2
	    ADDWF	MIN, F, C
	    
	    MOVF	SEC_UNIT, W, C
	    CALL	DISPLAY
	    MOVWF	LATD, C
	    MOVF	SEC_DEC, W, C
	    CALL	DISPLAY
	    MOVWF	LATB, C
	    MOVF	MIN, W, C
	    CALL	DISPLAY
	    MOVWF	LATA, C 
	    
	    MOVLW	18
	    SUBWF	MIN, W, C
	    BZ		CLR_SEC
	    
	    GOTO	LOOP

	    
SECOND:	    
	    MOVLW	2
	    ADDWF	SEC_UNIT, F, C
	    GOTO	LOOP

DELAY_:	    
	    MOVLW	0xFF
	    MOVWF	TIME, C
	    MOVLW	0xFF
	    MOVWF	TIME_2, C
	    MOVLW	0x09
	    MOVWF	TEMP, C	 
	    GOTO	DELAY_1
	    
DELAY:	    
	    MOVLW	0xFF
	    MOVWF	TIME, C
	    MOVLW	0xFF
	    MOVWF	TIME_2, C
	    MOVLW	0x15
	    MOVWF	TEMP, C
	    
DELAY_1:	    	    
	    DECFSZ	TIME, C
	    GOTO	DELAY_1
	    GOTO	DELAY_2
	    
DELAY_2:
	    MOVLW	0xFF
	    MOVWF	TIME, C

	    DECFSZ	TIME_2, C
	    GOTO	DELAY_1
	    GOTO	DELAY_3
	    
DELAY_3:	  
	    MOVLW	0xFD
	    MOVWF	TIME_2, C
	    
	    DECFSZ	TEMP, C
	    GOTO	DELAY_2
	    RETURN
	    
PAUSE:
	    CALL	DELAY_
	    BTFSC	PORTC, 0, C
	    GOTO	LOOP
	    GOTO	PAUSE   
	    
CLR_SEC:	    
	    MOVLW	0
	    MOVWF	SEC_UNIT, C
	    MOVLW	8
	    MOVWF	SEC_DEC, C
	    MOVLW	14
	    MOVWF	MIN, C
	    
	    GOTO	SETUP
	    
CONFIG_1:	
	    CALL	DELAY_
	    BTFSC	PORTC, 0, C
	    GOTO	SUM
	    BTFSC	PORTC, 2, C
	    GOTO	CONFIG_2
	    GOTO	CONFIG_1
	
SUM:	   
	    MOVLW	18
	    SUBWF	MIN, W, C
	    BZ		CLR
    
	    MOVLW	2
	    ADDWF	MIN, F, C
	    
	    MOVF	MIN, W, C
	    CALL	DISPLAY
	    MOVWF	LATA, C
	    	    
	    GOTO	CONFIG_1

CLR:	    
	    MOVLW	14
	    MOVWF	MIN, C
	    
	    MOVF	MIN, W, C
	    CALL	DISPLAY
	    MOVWF	LATA, C
	    
	    GOTO	CONFIG_1
	    
CONFIG_2:	
	    CALL	DELAY_
	    BTFSC	PORTC, 0, C
	    GOTO	SUM_2
	    BTFSC	PORTC, 2, C
	    GOTO	CONFIG_3
	    GOTO	CONFIG_2
	
SUM_2:	   
	    MOVLW	18
	    SUBWF	SEC_DEC, W, C
	    BZ		CLR_2
    
	    MOVLW	2
	    ADDWF	SEC_DEC, F, C
	    
	    MOVF	SEC_DEC, W, C
	    CALL	DISPLAY
	    MOVWF	LATB, C
	    
	    GOTO	CONFIG_2

CLR_2:	    
	    MOVLW	8
	    MOVWF	SEC_DEC, C
	    
	    MOVF	SEC_DEC, W, C
	    CALL	DISPLAY
	    MOVWF	LATB, C
	    
	    GOTO	CONFIG_2
	    
CONFIG_3:	
	    CALL	DELAY_
	    BTFSC	PORTC, 0, C
	    GOTO	SUM_3
	    BTFSC	PORTC, 2, C
	    GOTO	SETUP
	    GOTO	CONFIG_3
	
SUM_3:	   
	    MOVLW	18
	    SUBWF	SEC_UNIT, W, C
	    BZ		CLR_3
    
	    MOVLW	2
	    ADDWF	SEC_UNIT, F, C
	    
	    MOVF	SEC_UNIT, W, C
	    CALL	DISPLAY
	    MOVWF	LATD, C
	    
	    GOTO	CONFIG_3

CLR_3:	    
	    MOVLW	0
	    MOVWF	SEC_UNIT, C
	    
	    MOVF	SEC_UNIT, W, C
	    CALL	DISPLAY
	    MOVWF	LATD, C
	    
	    GOTO	CONFIG_3	    
