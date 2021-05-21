SIZE		.INT 7		#Symbols using ASCII values 
int		.INT 0
tenth		.INT 0
data		.INT 0
flag		.INT 0
opdv		.INT 0

C		.BYT 0		#Char Array of SIZE
		.BYT 0
		.BYT 0
		.BYT 0
		.BYT 0
		.BYT 0
		.BYT 0

nl		.BYT 10		#New line/
PLUS		.BYT 43		#+ sign
MINUS		.BYT 45		#- sign
spc		.BYT 32		#space
@		.BYT 64		#@ symbol
i		.BYT 105
s		.BYT 115
n		.BYT 110	
o		.BYT 111
t		.BYT 116
a		.BYT 97
u		.BYT 117
m		.BYT 109
b		.BYT 98
e		.BYT 101
r		.BYT 114
N		.BYT 78
B		.BYT 66
g		.BYT 103
p		.BYT 112
d		.BYT 100
j		.BYT 106
k		.BYT 107

MAIN		LDB R0 j	#Parameters
		STR R0 (R2)
		ADI R2 -4
		LDA R1 k
		STR R1 (R2)
		ADI R2 -4
		LDB R3 s
		STR R1 (R3)
		
		JMP opd
		TRP 0		


#Test for overflow
opd		MOV R1 SP
		ADI R1 -16
		CMP R1 SL
		BLT R1 OVERFLOW
		
#create Activation record
		MOV R2 SP	#R2 holds FP = SP
		ADI R2 -4	
		STR FP (SP)	#PFP = FP
		ADI R2 -4
		
		
#Test for underflow
		MOV SP FP
		MOV R2 SP
		CMP R2 SB
		BGT R2 UNDERFLOW
		
		MOV FP R2	#set FP before jumping to the function
		MOV R1 PC
		ADI R1 12
		STR R1 (FP)
		
		LDR R4 (FP)	#Set previous frame to current frame
		ADI R4 -4
		LDR R4 (R4)
		JMR R4	




OVERFLOW	TRP 0

UNDERFLOW	TRP 0

		
		TRP 0