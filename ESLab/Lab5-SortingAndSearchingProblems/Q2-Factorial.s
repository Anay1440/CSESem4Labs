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
	LDR R1, [R0]
	MOV R2, #1
recur	BL fact
		CMP R1, #0
		BEQ exit
		B recur
exit	LDR R5, =FACT
		STR R2, [R5]
fact	MUL R2, R2, R1
		SUB R1, #1
		B loop
exit	BX LR
STOP	B STOP

N DCD 6
	AREA mydata, DATA, READWRITE
FACT DCD 1 ;DST location in data memory
	END