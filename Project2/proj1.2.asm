SIZE	.INT 10		#Symbols using ASCII values
int_i	.INT 0
sum	.INT 0
result	.INT 0
IV	.INT 4
TWO	.INT 2

i 	.BYT 105
s	.BYT 115
o	.BYT 111
d	.BYT 100
e	.BYT 101
v	.BYT 118
n	.BYT 110
u	.BYT 117
m	.BYT 109
S	.BYT 83
sp	.BYT 32
nl	.BYT 10

ARR	.INT 10		#Array of int{10,2,3,4,15,-6,7,8,9,10}
	.INT 2
	.INT 3
	.INT 4
	.INT 15
	.INT -6
	.INT 7
	.INT 8
	.INT 9
	.INT 10

DAGS	.BYT 68		#D
	.BYT 65		#A
	.BYT 71		#G
	.BYT 83		#S

GADS 	.INT -99
	
WHILE	LDR R0 SIZE	#While loop begins
	LDR R1 int_i	#Load variable i = 0 to R1
	CMP R0 R1
	BRZ R0 END	


	LDA R7 ARR	#Load address ARR[i=0] R2
	LDR R0 IV	# 4 to R0
	MUL R1 R0
	ADD R7 R1

	LDR R6 R7	#Load VALUE of ARR[i] R0
	
	LDR R4 sum	#Load sum to R4
	ADD R4 R6	#ADD to ARR value to sum 
	STR R4 sum	#Store from R4 to sum
	
	LDR R0 result	#Calculate modulus 
	LDR R1 TWO	#store result
	DIV R6 R1
	MUL R6 R1
	STR R6 result

	LDR R1 R7	#If result == 0
	LDA R0 result	#then its even
	LDR R2 R0	#branch to even 
	CMP R1 R2	
	LDR R3 R7
	TRP 1
	LDB R3 sp
	TRP 3
	LDB R3 i
	TRP 3
	LDB R3 s
	TRP 3
	LDB R3 sp
	TRP 3
	BRZ R1 EVEN	

	LDB R3 o	#else is odd
	TRP 3
	LDB R3 d
	TRP 3
	TRP 3
	JMP NEXT	#Jump to next
	
	
EVEN	LDB R3 e	#Is even
	TRP 3
	LDB R3 v
	TRP 3
	LDB R3 e
	TRP 3
	LDB R3 n
	TRP 3

NEXT	LDB R3 nl	#end of if
	TRP 3			
	LDR R1 int_i
	ADI R1 1	#increment 
	STR R1 int_i	#++i
	JMP WHILE	#jump to beginning of loop
	
END	LDB R3 S	#End of loop and print out sum of ARR
	TRP 3
	LDB R3 u
	TRP 3
	LDB R3 m
	TRP 3
	LDB R3 sp
	TRP 3
	LDB R3 i
	TRP 3
	LDB R3 s
	TRP 3
	LDB R3 sp
	TRP 3
	LDR R3 sum
	TRP 1
	LDB R3 nl
	TRP 3

	TRP 0