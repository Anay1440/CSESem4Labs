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
	MOV R2, #0
	MOV R5, #0
	MOV R7, #10
loop	LDRB R3, [R0], #1
		AND R4,R3,#0x0F
		MOV R6, #1
		MOV R8, #0
raise1	CMP R2, R8
		BEQ exitraise1
		MUL R4, R4, R7
		ADD R8, #1
		B raise1
exitraise1	ADD R5, R4
			ADD R2, #1
		AND R4, R3, #0xF0
		LSR R4, #4 ;shift 4 bits
		MOV R6, #1
		MOV R8, #0
raise2	CMP R2, R8
		BEQ exitraise2
		MUL R4, R4, R7
		ADD R8, #1
		B raise2
exitraise2	ADD R5, R4
			ADD R2, #1
		CMP R2, #8
		BNE loop
	STR R5, [R1]
STOP B STOP
N DCD 2_00000000000000000000000000111001
	AREA mydata, DATA, READWRITE
DST DCD 1
	END