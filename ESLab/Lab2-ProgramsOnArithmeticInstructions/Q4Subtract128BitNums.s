	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors 
	DCD 0x10001000 ; stack pointer value when stack is empty
	DCD Reset_Handler ; reset vector
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =NUM1 
	LDR R1, =NUM2
	LDR R2, =DST 
	MOV R3, #4
	MOV R6, #0
	MOV R7, #0
	LDR R8, =CARRY
loop	LDR R4, [R0], #4
		LDR R5, [R1], #4
		SUBS R4, R6
		MOV R7, #0
		ADC R7, #0
		SUBS R4, R5
		MOV R6, #0
		ADC R6, #0
		ADD R6, R7
		CMP R6, #2
		MOV R6, #0
		BEQ aftercarryset
		MOV R6, #1		
aftercarryset	STR R4, [R2], #4
		SUBS R3, #1
		BNE loop
		STR R6, [R8]
STOP
	B STOP
NUM1 DCD 1,0xFFFFFFFF,3,4
NUM2 DCD 5,6,0xFFFFFFFF,8
	AREA mydata, DATA, READWRITE
DST DCD 1 ;DST location in data memory
CARRY DCD 1
	END