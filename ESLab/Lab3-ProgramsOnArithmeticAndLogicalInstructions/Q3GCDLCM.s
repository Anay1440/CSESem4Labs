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
	LDR R6, =GCD
	LDR R7, =LCM
	LDR R2, [R0]
	LDR R3, [R1]
	MOV R5,R1
div1	CMP R2, R5
		BLT exitDiv1
		SUB R2,R5
		B div1
exitDiv1	CMP R2, #0
		BNE loopSet
		
div2 CMP R3, R5
	BLT exitDiv2
	SUB R3,R5
	B div2
	
exitDiv2	CMP R3, #0
			BEQ exitGCDCalc
			B loopSet

loopSet CMP R5,#1
		BEQ exitGCDCalc
		SUB R5,#1
		LDR R2, [R0]
		LDR R3, [R1]
		B div1
exitGCDCalc
	STR R5, [R6]
	LDR R2, [R0]
	LDR R3, [R1]
	MUL R8, R2, R3
	MOV R9, #0
lcmDiv	CMP R8, R5
		BLT exit
		SUB R8, R5
		ADD R9, #1
		B lcmDiv
exit
	STR R9, [R7]
STOP
	B STOP
N1 DCD 30
N2 DCD 8
	AREA mydata, DATA, READWRITE
GCD DCD 1
LCM DCD 1
	END