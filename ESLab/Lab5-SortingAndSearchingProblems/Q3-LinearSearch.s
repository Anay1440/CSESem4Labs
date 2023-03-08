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
	LDR R0, =ARR
	LDR R3, =KEY
	LDR R2, [R3]
	MOV R1, #0 ;loop counter 
	ADD R7, R0, #36 ;index for last element
	
loop	LDR R3, [R0], #4
		CMP R0, R7
		BGT exit
		CMP R3, R2
		BEQ exit
		ADD R1, #1
		B loop
exit	LDR R0, =INDEX
		STR R1, [R0] 
STOP B STOP
ARR DCD 10,9,8,7,6,5,4,3,2,1
KEY DCD 4
	AREA mydata, DATA, READWRITE
INDEX DCD 1
	END