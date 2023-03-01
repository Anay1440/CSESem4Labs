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
	LDR R1, =SUM 
	LDR R2, [R0]
	MLA R2,R2,R2,R2 ;n^2 + n
	LSR R2,#1 ; dividing by 2 to get (n^2 + n)/2
	STR R2, [R1]
STOP
	B STOP
N DCD 7
	AREA mydata, DATA, READWRITE
SUM DCD 1 
	END