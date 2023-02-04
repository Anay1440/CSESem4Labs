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
	LDR R0, =SRC1;
	LDR R1, =SRC2;
	LDR R2, [R0] ;
	LDR R3, [R1] ;
STOP
	B STOP;
	AREA mydata, DATA, READWRITE
SRC1 DCD 8;
SRC2 DCD 9;
	END