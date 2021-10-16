;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            
;
; export symbols
;
            XDEF _Startup
            ABSENTRY _Startup

;
; variable/data section
;
            ORG    $60         ; Insert your data definition here
M60: DS.B   1
M61: DS.B   1
M62: DS.B   1
M63: DS.B   1

;
; code section
;
            ORG    ROMStart
            

_Startup:
			LDA	   	#$12			;Inmediato 	A=$12 hexa Quitar el WATCHDOG
			STA		SOPT1			;Directo 	Guardar A en SOPT1
			
			;Numeros sin signo
			MOV		#$7F, 	M60		;Mover a la direccion 60 el valor inmediato
			MOV		#$02, 	M61		;Mover a la direccion 61 el valor inmediato
			LDA		M60				;Cargar en el acumulador el valor de la direccio 60
			SUB		M61				;Restar el acumulador con el valor de la direccion 61
			STA		M62				;Guardar en la direccion 62 el valor del acumulador
			
			;Numeros con signo
			MOV		#$FF, 	M60		;Mover a la direccion 60 el valor inmediato
			LDA		M60				;Cargar en el acumulador el valor de la direccio 60
			SUB		M61				;Restar el acumulador con el valor de la direccion 61
			STA		M62				;Guardar en la direccion 62 el valor del acumulador
			
			;Complemento a dos
			MOV		#$7C, 	M62		;Mover a la direccion 62 el valor inmediato
			NEG		M62				;Complemento a dos de la direccio 62 y se guarda en la direccion 62
			
			
			
			
mainLoop:
            BRA    mainLoop
			
;**************************************************************
;* spurious - Spurious Interrupt Service Routine.             *
;*             (unwanted interrupt)                           *
;**************************************************************

spurious:				; placed here so that security value
			NOP			; does not change all the time.
			RTI

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************

            ORG	$FFFA

			DC.W  spurious			;
			DC.W  spurious			; SWI
			DC.W  _Startup			; Reset
