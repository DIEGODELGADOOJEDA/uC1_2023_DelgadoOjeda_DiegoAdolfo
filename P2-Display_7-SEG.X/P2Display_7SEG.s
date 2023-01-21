;    
;ARCHIVO:  P2-Display_7SEG
;DESCRIPCION: Este codigo permite esarrollar un programa que permita mostrar los
		;valores alfanuméricos(0-9 y A-F) en un display de
		;7 segmentos ánodo común, si el botón de la placa no esta presionado,
		;se muestran los valores numéricos del 0
		;al 9 y si el botón de la placa se mantiene
		;presionado, se muestran los valores de A
		;hasta F. Con una transicion de 1S
;FECHA:  21/01/2023
;AUTOR: DIEGO ADOLFO DELGADO OJEDA
PROCESSOR 18F57Q84
#include "Bit_Config.inc"  /config statements should precede project file includes./
#include <xc.inc>
#include "retardoos.inc"

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
PSECT CODE
Main:
 Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 8MHz
    BANKSEL OSCCON1 
    MOVLW 0x60     ; SELECCIONAMOS OSCILADOR Y DIVISOR = 1
    MOVWF OSCCON1,1
    MOVLW 0x02     ; Seleccionamos una frecuencia de 4MHZ
    MOVWF OSCFRQ,1
 Config_PORTA_BOTON:
    ;RA3_Entrada(Boton)
    BANKSEL PORTA           ;Seleccionamos todo el puerto A (por seguridad)
    CLRF    PORTA,1         ;LIMPIAMOS PUERTO A
    CLRF    ANSELA,1        ;8 BIT COMO ENTRADA DIGITAL
    BSF     TRISA,3,1       ;LEERA BIT 3 COMO ENTRADA
    BSF     WPUA,3,1        ;HABILTAMOS RESISTENCIA PULL UP
Boton:  
    BTFSC   PORTA,3,1
    GOTO   No_preseed
Pressed:
  ;LETRAS (A,B,C,D,E,F) 
  ;PD1=A, PD1=B, PD1=C, PD1=D, PD1=E, PD1=F
  ;A
  BANKSEL  PORTD
  CLRF     PORTD,1          ;LIMPIO PUERTO D
  CLRF     ANSELD,1	    ;8 BIT COMO ENTRADA DIGITAL
  CLRF     LATD,1	    ;ESTADO 0 PUERTO D
  CLRF     TRISD,1	    ;CONFIGURAMOS PUERTO COMO SALIDA
  MOVLW    00001000B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSC   PORTA,3,0	    ;VERIFICA SI ES 0, SALTA
  GOTO    No_preseed
  ;b
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00000011B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSC   PORTA,3,0	    ;VERIFICA SI ES 0, SALTA
  GOTO    No_preseed
;C
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    01000110B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSC   PORTA,3,0	    ;VERIFICA SI ES 0, SALTA
  GOTO    No_preseed
 ;d
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00100001B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSC   PORTA,3,0	    ;VERIFICA SI ES 0, SALTA
  GOTO    No_preseed
  ;E  
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00000110B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSC   PORTA,3,0        ;VERIFICA SI ES 0, SALTA
  GOTO    No_preseed
;F
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00001110B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSC   PORTA,3,0	   ;VERIFICA SI ES 0, SALTA
  GOTO    No_preseed
  GOTO Boton
  
No_preseed:
   ;Valores (0_9)
  ;RD0(a),RD1(b),RD2(c),RD3(d);RD4(e);RD5(f);RD6(g);RD7(.) 
;0
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    01000000B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;VERIFICA SI ES 1, SALTA
  GOTO    Pressed
;1
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    01111001B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO	    Pressed
;2
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00100100B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
;3
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00110000B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
;4
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00011001B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
;5
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00010010B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
;6
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00000010B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
;7
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    01111000B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
;8
  BANKSEL  PORTD
  CLRF     PORTD,1
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00000000B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		; VERITICA SI ES 1,SALTA
  GOTO    Pressed
;9
  BANKSEL  PORTD
  CLRF     PORTD,1              ;
  CLRF     ANSELD,1
  CLRF     LATD,1
  CLRF     TRISD,1
  MOVLW    00011000B
  MOVWF    PORTD,1
  CALL     Delay_500ms
  CALL     Delay_500ms
  BTFSS   PORTA,3,0		;  VERITICA SI ES 1,SALTA
  GOTO    Pressed
  GOTO     Boton
END resetVect
