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
	LDR R0, =N1 
	LDR R1, =N2 
	LDR R6, =QUO
	LDR R7, =REM
	LDR R2, [R0]
	LDR R3, [R1]
	MOV R4,#0
loop	CMP R2, R3
		BLT exit
		SUB R2,R3
		ADD	R4,#1
		B loop
exit	STR R4, [R6]
		STR R2, [R7]
STOP
	B STOP
N1 DCD 13
N2 DCD 2
	AREA mydata, DATA, READWRITE
QUO DCD 1
REM DCD 1
	END