;@autor  DIEGO ADOLFO DELGADO OJEDA 
;@fecha   09/01/2023
;@file    retardos.inc
;@Version  MPLAB X IDE v6.00
;@Descripcion   Este es una libreria de retardos
;Frecuencia a trabajar = 4MHz
;TCY = 1us
 ;----------------------------;
PSECT udata_acs
contador1:  DS 1	    ;reserva 1 byte en access ram
contador2:  DS 1	    ;reserva 1 byte en access ram
    
PSECT code  

Delay_10us:		    		   
    MOVLW   	1	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop1:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop1	    ; (k-1)+2Tcy 
    RETURN
 
Delay_25us:		    		   
    MOVLW   	5	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop2:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop2	    ; (k-1)+2Tcy 
    RETURN		    ; 2Tcy

Delay_50us:		    	   
    MOVLW   	11	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop3:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop3	    ; (k-1)+2Tcy 
    RETURN		    ; 2Tcy 
 
Delay_100us:		    		   
    MOVLW   	24	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop4:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop4	    ; (k-1)+2Tcy 
    RETURN		    ; 2Tcy 
    
Delay_250us:		    		   
    MOVLW   	61	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop5:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop5	    ; (k-1)+2Tcy 
    RETURN		    ; 2Tcy 
   
Delay_500us:		    		   
    MOVLW   	124	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop6:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop6	    ; (k-1)+2Tcy 
    RETURN		    ; 2Tcy 
    
Delay_1ms:		    		   
    MOVLW   	249	    ; 1Tcy
    MOVWF   contador1,0	    ; 1Tcy    
Delay_Loop7:
    Nop			    ; k*Tcy  
    DECFSZ  contador1,1,0   ; (k-1)+ 3Tcy 
    GOTO    Delay_Loop7	    ; (k-1)+2Tcy 
    RETURN		    ; 2Tcy 
 
Delay_5ms:		   
    MOVLW   5		    ; 1Tct
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop1:		   
    MOVLW   	249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2  
Int_Loop1:
    Nop			    ;k2*k1*Tcy
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop1	    ; k2((k1-1)*2Tcy)
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop1	    ; (k2-1)+2Tcy
    RETURN		    ; 2Tcy
  
 Delay_10ms:		    
    MOVLW   10		    ; 1Tcy
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop2:		   
    MOVLW   	249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2  
Int_Loop2:
    Nop			    ; k2*k1*Tcy
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy) 
    GOTO    Int_Loop2	    ; k2((k1-1)*2Tcy)
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop2	    ; (k2-1)+2Tcy
    RETURN		    ; 2Tcy 

Delay_25ms:		    
    MOVLW   25	    ; 1Tct
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop3:		   
    MOVLW   	249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2  
Int_Loop3:
    Nop			    ; k2*k1*Tcy 
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop3	    ; k2((k1-1)*2Tcy) 
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy 
    GOTO    Ext_Loop3	    ; (k2-1)+2Tcy
    RETURN		    ; 2Tcy 
    
Delay_50ms:		    
    MOVLW   50		    ; 1Tcy
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop4:		   
    MOVLW   	249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2   
Int_Loop4:
    Nop			    ; k2*k1*Tcy 
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop4	    ; k2((k1-1)*2Tcy) 
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop4	    ; (k2-1)+2Tcy
    RETURN		    ; 2Tcy 

Delay_100ms:		    
    MOVLW   100		    ; 1Tct
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop5:		   
    MOVLW   	249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2    
Int_Loop5:
    Nop			    ; k2*k1*Tcy 
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop5	    ; k2((k1-1)*2Tcy)
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop5	    ; (k2-1)+2Tcy
    RETURN		    ; 2Tcy 
    
Delay_200ms:		    
    MOVLW   200		    ; 1Tct
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop6:		   
    MOVLW   	249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2   
Int_Loop6:
    Nop			    ; k2*k1*Tcy 
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop6	    ; k2((k1-1)*2Tcy)
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop6	    ; (k2-1)+2Tcy
    RETURN		    ; 2Tcy 
    
Delay_250ms:	
    MOVLW   250	    ; 1Tcy
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop7:		   
    MOVLW   249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2
Int_Loop7:
    Nop			    ;k2*k1*Tcy
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop7	    ; k2((k1-1)*2Tcy)
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop7	    ; (k2-1)+2Tcy
 RETURN			    ; 2Tcy
 
Delay_500ms:
    MOVLW   500	     ; 1Tcy
    MOVWF   contador2,0	    ; 1Tcy
;   T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop8:		   
    MOVLW   249	    ; 1Tcy*k2
    MOVWF   contador1,0	    ; 1Tcy*k2
Int_Loop8:
    Nop			    ;k2*k1*Tcy
    DECFSZ  contador1,1,0   ; k2* (k1-1) + 3*Tcy)
    GOTO    Int_Loop8	    ; k2((k1-1)*2Tcy)
    DECFSZ  contador2,1,0   ; (k2-1) + 3Tcy
    GOTO    Ext_Loop8	    ; (k2-1)+2Tcy
 RETURN			    ; 2Tcy

