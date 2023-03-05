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
	LDR R10, =N2
	LDR R1, =DST
	LDR R11, =CARRY
	MOV R2, #0
	MOV R5, #0
	MOV R7, #10
	MOV R12, #0
loop	LDRB R3, [R0]
		AND R4, R3, #0x0F
		LDRB R3, [R10]
		AND R6, R3, #0x0F
		BL subroutine
		BL raise
		ADD R5, R4
		ADD R2, #1
		LDRB R3, [R0], #1
		AND R4, R3, #0xF0
		LSR R4, #4 ;shift 4 bits
		LDRB R3, [R10], #1
		AND R6, R3, #0xF0
		LSR R6, #4 ;shift 4 bits
		BL subroutine
		BL raise
		ADD R5, R4
		ADD R2, #1
		CMP R2, #8
		BNE loop
	STR R5, [R1]
	STR R12, [R11]
	B STOP
subroutine	ADD R4, R12
		MOV R12, #0
		ADD R4, R6
		CMP R4, #10
		BLT skip
		SUB R4, #10
		MOV R12, #1
skip	MOV R6, #1
		MOV R8, #0
		BX LR
raise	CMP R2, R8
		BEQ exitraise
		MUL R4, R4, R7
		ADD R8, #1
		B raise
exitraise BX LR
STOP B STOP
N1 DCD 2_00000000000000000000000000111001
N2 DCD 2_00000000000000000000000000010010
	AREA mydata, DATA, READWRITE
DST DCD 1
CARRY DCD 1
	END