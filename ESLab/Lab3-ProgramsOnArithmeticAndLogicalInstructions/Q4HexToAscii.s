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
	LDR R0, =N
	LDR R1, =DST 
	LDRB R2, [R0]
	MOV R3,#0
	MOV R4,#10
	MOV R7,#0x30
loop	CMP R2,R4
		BLT exitDiv
		SUB R2,R4
		ADD R3,#1
		B loop
exitDiv	CMP R3,	#0
		BEQ exit
		ADD R5, R2, R7
		MOV R2, R3
		MOV R3,#0
		STR R5, [R1], #1
		B loop
exit	ADD R5,R2,R7
		STR R5, [R1]
STOP
	B STOP
N DCD 0x9B
	AREA mydata, DATA, READWRITE
DST DCD 1 ;DST location in data memory
	END