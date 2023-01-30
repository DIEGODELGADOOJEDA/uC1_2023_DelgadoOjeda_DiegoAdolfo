;    
;ARCHIVO:  Corrimiento_leds_int
;DESCRIPCION: este codigo permite hacer un programa en cual primeto aplicar 
	; interrupciones de baja (RA3) y alta prioridad (RB4 y RF2) a un 
	; corrimiento de leds, el programa iniciara con un toggle en el 
	; led de la placa, al activar la primera interrupcion iniciara un 
	; corrimiento de una secuncia de 8 leds,se detendra al culminar 
	; 5 veces dicha secuenca, al activar la segunda interrupcion de alta
	; prioridad capturara los leds y de dirigira al toggle, la ultima 
	;interrupcion de alta prioridad apagara los leds y reinicara el programa 
;FECHA:  29/01/2023
;AUTOR: DIEGO ADOLFO DELGADO OJEDA	
PROCESSOR 18F57Q84
#include "BitConfig.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT BajaPrioridad,class=CODE,reloc=2
BAJAPRIORIDAD:
    BTFSS   PIR1,0,0	; ¿Se ha producido la INT0?
    GOTO    Exit0
Leds_on:
    BCF	    PIR1,0,0	; limpiamos el flag de INT0
    GOTO    Reload
Exit0:
    RETFIE

PSECT AltaPrioridad,class=CODE,reloc=2
AltaPrioridad:   
    BTFSS   PIR6,0,0	; ¿Se ha producido la INT1?
    GOTO    AltaPrioridad1 
captura: 
    BCF	    PIR6,0,0	; limpiamos el flag de INT1
    goto    toggle
Exit1:
    RETFIE
    
PSECT udata_acs
contador1:  DS 1	    
contador2:  DS 1
offset:	    DS 1
counter:    DS 1
counter1:   DS 1
    
PSECT CODE    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_PPS,1
    CALL    Config_INT0_INT1,1
    GOTO    toggle   
Loop:
    BANKSEL PCLATU
    MOVLW   low highword(Table)
    MOVWF   PCLATU,1
    MOVLW   high(Table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
    CALL    Table 
    MOVWF   LATC,0
    CALL    Delay_250ms,1
    DECFSZ  counter,1,0
    GOTO    Next_Seq
 Counter5:
    DECFSZ  counter1,1,0
    GOTO    Reload1
    GOTO    off
 Next_Seq:
    INCF    offset,1,0
    GOTO    Loop
Reload:
    MOVLW   0x05	
    MOVWF   counter1,0	; carga del contador con el numero de offsets
    MOVLW   0x00	
    MOVWF   offset,0	; definimos el valor del offset inicial
Reload1:
    MOVLW   0x0A	
    MOVWF   counter,0	; carga del contador con el numero de offsets
    MOVLW   0x00	
    MOVWF   offset,0	; definimos el valor del offset inicial
    GOTO    Loop   
off:
    SETF    LATC,0
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    goto    exit
Config_OSC:
    ;Configuracion del Oscilador Interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60    ;seleccionamos el bloque del osc interno(HFINTOSC) con DIV=1
    MOVWF   OSCCON1,1 
    MOVLW   0x02    ;seleccionamos una frecuencia de Clock = 4MHz
    MOVWF   OSCFRQ,1
    RETURN
Config_Port:	
    ;Config Led
    BANKSEL PORTF
    CLRF    PORTF,1	
    BSF	    LATF,3,1
    BSF	    LATF,2,1
    CLRF    ANSELF,1	
    BCF	    TRISF,3,1
    BCF	    TRISF,2,1
    
    ;Config RA3
    BANKSEL PORTA
    CLRF    PORTA,1	
    CLRF    ANSELA,1	
    BSF	    TRISA,3,1	
    BSF	    WPUA,3,1
    
    ;Config RB4
    BANKSEL PORTB
    CLRF    PORTB,1	
    CLRF    ANSELB,1	
    BSF	    TRISB,4,1	
    BSF	    WPUB,4,1
    
    ;Config RF2
    BANKSEL PORTF
    CLRF    PORTF,1	
    CLRF    ANSELF,1	
    BSF	    TRISF,2,1	
    BSF	    WPUF,2,1
    
    ;Config PORTC
    BANKSEL PORTC
    SETF    PORTC,1	
    SETF    LATC,1	
    CLRF    ANSELC,1	
    CLRF    TRISC,1
    RETURN
    
Config_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	; INT0 --> RA3
    
    ;Config INT1
    BANKSEL INT1PPS
    MOVLW   0x0C
    MOVWF   INT1PPS,1	; INT1 --> RB4
    
    ;Config INT2
    BANKSEL INT2PPS
    MOVLW   0x2A
    MOVWF   INT2PPS,1	; INT2 --> RF2
    
    RETURN
    
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0_INT1:
    ;Configuracion de prioridades
    BSF	INTCON0,5,0 ; INTCON0<IPEN> = 1 -- Habilitamos las prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1    ; IPR1<INT0IP> = 0 -- INT0 de baja prioridad
    BSF	IPR6,0,1    ; IPR6<INT1IP> = 1 -- INT1 de alta prioridad
    BSF	IPR10,0,1    ; IPR10<INT2IP> = 1 -- INT2 de alta prioridad
    
    ;Config INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1 -- habilitamos la interrupcion ext0
    
    ;Config INT1
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de bajada
    BCF	PIR6,0,0    ; PIR6<INT1IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE6,0,0    ; PIE6<INT1IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Config INT2
    BCF	INTCON0,2,0 ; INTCON0<INT2EDG> = 0 -- INT2 por flanco de bajada
    BCF	PIR10,0,0    ; PIR10<INT2IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE10,0,0    ; PIE10<INT2IE> = 1 -- habilitamos la interrupcion ext2
    
    ;Habilitacion de interrupciones
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global y de alta prioridad
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 -- habilitamos las interrupciones de baja prioridad
    RETURN

Table:
    ADDWF   PCL,1,0
    RETLW   01111110B	; offset: 0
    RETLW   10111101B	; offset: 1
    RETLW   11011011B	; offset: 2
    RETLW   11100111B	; offset: 3
    RETLW   11111111B	; offset: 4  
    RETLW   11100111B	; offset: 5
    RETLW   11011011B	; offset: 6
    RETLW   10111101B	; offset: 7
    RETLW   01111110B	; offset: 8
    RETLW   11111111B	; offset: 9
    
;====RF2=====
AltaPrioridad1:
    BTFSS   PIR10,0,0	    ; ¿Se ha producido la INT0?
    GOTO    Exit1
Int3:
    BCF	    PIR10,0,0	    ; Limpiamos flags del INT2
    goto    off
    
;=====DELAY 125ms=====    
Delay_250ms:		    
    MOVLW   250		    
    MOVWF   contador2,0	    
Ext_Loop:		    
    MOVLW   249		    
    MOVWF   contador1,0	    
Int_Loop:
    NOP			    
    DECFSZ  contador1,1,0   
    GOTO    Int_Loop	    
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop
    RETURN
    
;====DELAY 125ms=====
Delay_125ms:		    
    MOVLW   125	    
    MOVWF   contador2,0	    
Ext_Loop1:		    
    MOVLW   249		    
    MOVWF   contador1,0	    
Int_Loop1:
    NOP			    
    DECFSZ  contador1,1,0   
    GOTO    Int_Loop1	    
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop1
    RETURN
    
toggle:
   BTFSC   PORTF,2,0 
   BTG	   LATF,3,0
   BTFSC   PORTF,2,0
   CALL    Delay_125ms,1
   BTFSC   PORTF,2,0
   CALL    Delay_125ms,1
   BTFSC   PORTF,2,0
   CALL    Delay_125ms,1
   BTFSC   PORTF,2,0
   CALL    Delay_125ms,1
   BTFSC   PORTF,2,0
   goto	   toggle
   goto	   AltaPrioridad
   
exit:  
End resetVect


