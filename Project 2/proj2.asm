one	.INT 1		#Variables 
four	.INT 4
int_i	.INT 0
int_ii	.INT 0
SIZE	.INT 10	
sum	.INT 0
result	.INT 0
TWO	.INT 2
rel	.BYT 0

>	.BYT 62		#Symbols and letters in ASCii
<	.BYT 60
=	.BYT 61
-	.BYT 45
sp	.BYT 32
nl	.BYT 10
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

	#------Part 1---------

WHILE	LDR R0 SIZE	#While loop begins
	LDR R1 int_i	#Load variable i = 0
	CMP R0 R1
	BRZ R0 END	


	LDA R7 ARR	#Load address ARR[i=0]
	LDR R0 four	#Integer size 4
	MUL R1 R0
	ADD R7 R1
	LDR R6 R7	#Load VALUE of ARR[i]
	LDR R4 sum	#Load sum
	ADD R4 R6	#ADD ARR value to sum 
	STR R4 sum	#Store sum
	
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
	TRP 3

	#------Part 2--------
	LDA R0 DAGS	#Load DAGS address
	LDR R1 R0	#to copy DAGS to GADS address
	LDA R2 GADS
	STR R1 R2
	
	LDA R1 GADS	#Swap the D and G in memory
	LDB R2 R1	#D
	MOV R0 R1
	ADI R0 2
	LDB R4 R0	#G
	STB R4 R1
	STB R2 R0

WHILE_2	LDR R0 four	#While loop begins
	LDR R1 int_ii	#Load variable ii = 0
	CMP R0 R1
	BRZ R0 STOP
	
	LDA R5 rel	#Load rel address
	LDA R7 DAGS	#Load address DAGS
	ADD R7 R1
	LDA R6 GADS	#Load address GADS
	ADD R6 R1

	LDB R0 R7	
	MOV R4 R0	#DAGS[i]
	LDB R2 R6	#GADS[i]
	CMP R4 R2
	BGT R4 ELSEIF
	BRZ R4 ELSE
	
	LDB R6 <
	STB R6 R5
	JMP PRINT
	
ELSEIF	LDB R6 >
	STB R6 R5
	JMP PRINT

ELSE	LDB R6 =
	STB R6 R5
	JMP PRINT

PRINT	MOV R3 R0
	TRP 3
	LDB R3 sp
	TRP 3
	LDB R3 rel
	TRP 3
	LDB R3 sp
	TRP 3
	MOV R3 R2
	TRP 3
	LDB R3 -
	TRP 3
	TRP 3
	
	ADI R1 1	#increment ii
	STR R1 int_ii
	JMP WHILE_2
	
	
STOP	LDB R3 nl
	TRP 3
	TRP 3

	LDR R0 DAGS	#Load DAGS address
	LDR R1 GADS	#Load GADS address
	MOV R3 R0	#Print them as integers
	SUB R0 R1	#and subtract
	TRP 1
	LDB R3 sp
	TRP 3
	LDB R3 -
	TRP 3
	LDB R3 sp
	TRP 3
	MOV R3 R1
	TRP 1
	LDB R3 sp
	TRP 3
	LDB R3 =
	TRP 3
	LDB R3 sp
	TRP 3
	MOV R3 R0
	TRP 1
	TRP 0