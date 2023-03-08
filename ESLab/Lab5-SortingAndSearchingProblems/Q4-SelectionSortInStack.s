	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors 
	DCD 0x40001000 ; stack pointer value when stack is empty
	DCD Reset_Handler ; reset vector
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =ARR
	
	;storing data in array (10 to 1 descending order)
	MOV R9, #10
loop	STR R9, [R0], #4
		SUBS R9, #1
		BNE loop
	LDR R0, =ARR
	
	LDM R0, {R1-R10}
	STM R13!, {R1-R10}
	MOV R0, R13
	SUB R0, #40
	ADD R7, R0, #36 ;index for last element
	;selection sort starts here
loopI	LDM R0, {R3}
		MOV R4, R0
		MOV R6, R0
loopJ	ADD R6, #4
		CMP R6, R7
		BGT exitloopJ
		LDM R6, {R5}
		CMP R5, R3
		BGT skip
		MOV R3, R5
		MOV R4, R6 ;storing index for smallest found
skip	B loopJ
exitloopJ	LDM R0, {R8}
			STM R0, {R3}
			STM R4, {R8}
			ADD R0, #4
			CMP R0, R7
			BEQ exit
			B loopI
exit	SUB R0, #36	
		LDM R0, {R1-R10}
STOP B STOP
	AREA mydata, DATA, READWRITE
ARR DCD 1
	END