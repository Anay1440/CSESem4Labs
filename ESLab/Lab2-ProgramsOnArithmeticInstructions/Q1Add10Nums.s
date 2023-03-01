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
	LDR R0, =SRC 
	LDR R1, =DST 
	LDR R6, =CARRY
	MOV R2, #10
	MOV R4, #0 
	MOV R5, #0
loop	LDR R3, [R0], #4
		ADDS R4, R3
		ADC R5, #0
		SUBS R2, #1
		BNE loop
	STR R4, [R1]
	STR R5, [R6]
STOP
	B STOP
SRC DCD 0xFFFFFFFF,2,3,4,5,6,7,8,9,0xFFFFFFFF
	AREA mydata, DATA, READWRITE
DST DCD 1 ;DST location in data memory
CARRY DCD 1
	END