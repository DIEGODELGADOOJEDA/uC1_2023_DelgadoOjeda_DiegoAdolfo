;    
;ARCHIVO:  P1-Corrimiento_Leds
;DESCRIPCION: Este codigo permite el corrimiento de leds conectados al puerto C, con
	    ;un retardo de 500 ms en un numero de corrimientos pares
	    ;y un retardo de 250ms en un numero de corrimientos impares.
	    ;El corrimiento inicia cuando se presiona el pulsador de la placa
	    ;una vez y se detiene cuando se vuelve a presionar.
;FECHA:  21/01/2023
;AUTOR: DIEGO ADOLFO DELGADO OJEDA
    PROCESSOR 18F57Q84
#include "Bit_config.inc"
#include <xc.inc>
#include "retardos.inc"

PSECT udata_acs
F1 EQU 00000001B
F2 EQU 00000010B
F3 EQU 00000100B
F4 EQU 00001000B
F5 EQU 00010000B
F6 EQU 00100000B
F7 EQU 01000000B
F8 EQU 10000000B
    
PSECT resetVect, class=code, reloc=2
resetVect:
    goto Main
PSECT code
Main:
    CALL confi_osc,1
    CALL confi_port,1
boton:
    BTFSC PORTA,3,0
    goto APAGADO   
INICIO:
LED1:
    MOVLW F1
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF  LATE,0,1
    BTFSS PORTA,3,0
    goto  DELAY1
    goto CONTINUE1
CONTINUE1:
    BTFSC PORTA,3,0
    goto REINICIO1
    DELAY1:
    CALL Delay_500ms
    CALL Delay_500ms
    capture:
    BSF  LATE,0,1
    MOVLW F1
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,0,1
    BTFSC PORTA,3,0
    goto capture
    goto REINICIO1
REINICIO1:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,0
    BCF   LATE,0,1
    CALL Delay_250ms,1
LED2:
    MOVLW F2
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF  LATE,1,1
    BTFSS PORTA,3,0
    goto  DELAY2
    goto CONTINUE2
CONTINUE2:
    BTFSC PORTA,3,0
    goto REINICIO2
    DELAY2:
    CALL Delay_500ms
    CALL Delay_500ms
    capture1:
    BSF  LATE,1,1
    MOVLW F2
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,1,1
    BTFSC PORTA,3,0
    goto capture1
    goto REINICIO2
REINICIO2:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,0
    BCF   LATE,1,1
    CALL Delay_250ms,1
LED3:
    MOVLW F3
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF  LATE,0,1
    BTFSS PORTA,3,0
    goto  DELAY3
    goto CONTINUE3
CONTINUE3:
    BTFSC PORTA,3,0
    goto REINICIO3
    DELAY3:
    CALL Delay_500ms
    CALL Delay_500ms
    capture2:
    BSF  LATE,0,1
    MOVLW F3
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,2,1
    BTFSC PORTA,3,0
    goto capture2
    goto REINICIO3
REINICIO3:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,0
    BCF   LATE,0,1
    CALL Delay_250ms,1
LED4:
    
    MOVLW F4
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF	  LATE,1,1
    BTFSS PORTA,3,0
    goto  DELAY4
    goto CONTINUE4
CONTINUE4:
    BTFSC PORTA,3,0
    goto REINICIO4
    DELAY4:
    CALL Delay_500ms
    CALL Delay_500ms
    capture4:
    BSF  LATE,1,1
    MOVLW F4
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,3,1
    BTFSC PORTA,3,0
    goto capture4
    goto REINICIO4 
REINICIO4:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,0
    BCF   LATE,1,1
    CALL Delay_250ms,1 
LED5:
    BSF  LATE,0,1
    MOVLW F5
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF  LATE,0,1
    BTFSS PORTA,3,0
    goto  DELAY5
    goto CONTINUE5
CONTINUE5:
    BTFSC PORTA,3,0
    goto REINICIO5
    DELAY5:
    CALL Delay_500ms
    CALL Delay_500ms
    capture5:
    BSF  LATE,0,1
    MOVLW F5
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,4,1
    BTFSC PORTA,3,0
    goto capture5
    goto REINICIO5
REINICIO5:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,0
    BCF   LATE,0,1
    CALL Delay_250ms,1
LED6:
    
    MOVLW F6
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATE,1,1
    BTFSS PORTA,3,0
    goto  DELAY6
    goto CONTINUE6
CONTINUE6:
    BTFSC PORTA,3,0
    goto REINICIO6
    DELAY6:
    CALL Delay_500ms
    CALL Delay_500ms
    capture6:
    BSF  LATE,1,1
    MOVLW F6
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,4,1
    BTFSC PORTA,3,0
    goto capture6
    goto REINICIO6
REINICIO6:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,a
    BCF   LATE,1,1
    CALL Delay_250ms,1
LED7:
    BSF  LATE,0,1
    MOVLW F7
    MOVWF 0x501,0
    MOVWF PORTC,0
    BTFSS PORTA,3,0
    goto  DELAY7
    goto CONTINUE7
CONTINUE7:
    BTFSC PORTA,3,0
    goto REINICIO7
    DELAY7:
    CALL Delay_500ms
    CALL Delay_500ms
    capture7:
    BSF  LATE,0,1
    MOVLW F7
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,6,1
    BTFSC PORTA,3,0
    goto capture7
    goto REINICIO7 
REINICIO7:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,a
    BCF   LATE,0,1
    CALL Delay_250ms,1
LED8:
    BSF  LATE,1,1
    MOVLW F8
    MOVWF 0x501,0
    MOVWF PORTC,0
    BTFSS PORTA,3,0
    goto  DELAY8
    goto CONTINUE8
CONTINUE8:
    BTFSC PORTA,3,0
    goto REINICIO8
    DELAY8:
    CALL Delay_500ms
    CALL Delay_500ms
    capture8:
    BSF  LATE,1,1
    MOVLW F8
    MOVWF 0x501,0
    MOVWF PORTC,0
    BSF   LATC,7,1
    BTFSC PORTA,3,0
    goto capture8
    goto REINICIO8
REINICIO8:
    CALL Delay_500ms,1
    MOVLW 0
    MOVWF PORTC,a
    BCF   LATE,1,1
    CALL Delay_250ms,1
    goto INICIO
APAGADO:
    CLRF PORTC,1
    goto boton   
confi_osc:  
    BANKSEL OSCCON1
    MOVLW   0x60 
    MOVWF   OSCCON1,1
    MOVLW   0x02 
    MOVWF   OSCFRQ,1
    RETURN
confi_port:
    ; Conf. de puertos C
    BANKSEL PORTC   
    CLRF    PORTC,1	;PORTC=0
    CLRF    LATC,1	;LATC=0, Leds apagado
    CLRF    ANSELC,1	;ANSELC como Digital
    CLRF    TRISC,1	;puerto c como salidas 
    ;CONFIGURACION PUERTO E PARA VISUALIZAR PAR O IMPAR
    BANKSEL PORTE   
    CLRF    PORTE,1	;PORTC=0
    BCF     LATE,0,1	; Led RE0 apagado
    BCF     LATE,1,1    ; Led RE1 apagado
    CLRF    ANSELE,1	;ANSELC=0, Digital
    CLRF    TRISE,1	;Todos salidas 
    ;CONFIGURACION DEL BOTOn
    BANKSEL PORTA
    CLRF    PORTA,1	;
    CLRF    ANSELA,1	;ANSELA=0, Digital
    BSF	    TRISA,3,1	; TRISA=1 -> entrada
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up
    RETURN      
    
END resetVect