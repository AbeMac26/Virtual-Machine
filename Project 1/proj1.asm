A .BYT 65	#Symbols using ASCII values
a .BYT 97
b .BYT 98
e .BYT 101
l .BYT 108
M .BYT 77
c .BYT 99
i .BYT 105
s .BYT 115
cm .BYT 44	#Comma
sp .BYT 32	#space
nl .BYT 10	#new line
	
A1 .INT 1	#integer for A set
A2 .INT 2
A3 .INT 3
A4 .INT 4
A5 .INT 5
A6 .INT 6

B1 .INT 300	#integer for B set
B2 .INT 150
B3 .INT 50
B4 .INT 20
B5 .INT 10
B6 .INT 5

C1 .INT 500	#integer for C set
C2 .INT 2
C3 .INT 5
C4 .INT 10

LDB R3 M	#instructions to print name
TRP 3
LDB R3 a
TRP 3
LDB R3 c
TRP 3
LDB R3 i
TRP 3
LDB R3 a
TRP 3
LDB R3 s
TRP 3
LDB R3 cm
TRP 3
LDB R3 sp
TRP 3
LDB R3 A
TRP 3
LDB R3 b
TRP 3
LDB R3 e
TRP 3
LDB R3 l
TRP 3
LDB R3 nl
TRP 3
TRP 3

LDR R0 B1	#instructions to ADD and print B set
LDR R1 B2
ADD R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 B3
ADD R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 B4
ADD R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 B5
ADD R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 B6
ADD R0 R1
MOV R3 R0
MOV R2 R0
TRP 1
LDB R3 nl
TRP 3
TRP 3


LDR R0 A1	#instructions to MUL and print A set
LDR R1 A2
MUL R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 A3
MUL R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 A4
MUL R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 A5
MUL R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
LDR R1 A6
MUL R0 R1
MOV R3 R0
MOV R4 R0
TRP 1
LDB R3 nl
TRP 3
TRP 3

MOV R0 R2	#instruction to DIV results from B by B set
LDR R1 B1
DIV R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R2
LDR R1 B2
DIV R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R2
LDR R1 B3
DIV R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R2
LDR R1 B4
DIV R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R2
LDR R1 B5
DIV R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R2
LDR R1 B6
DIV R0 R1
MOV R3 R0
TRP 1
LDB R3 nl
TRP 3
TRP 3


MOV R0 R4	#instructions to SUB result from A with C set
LDR R1 C1
SUB R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R4
LDR R1 C2
SUB R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R4
LDR R1 C3
SUB R0 R1
MOV R3 R0
TRP 1
LDB R3 sp
TRP 3
TRP 3
MOV R0 R4
LDR R1 C4
SUB R0 R1
MOV R3 R0
TRP 1

TRP 0		#Stop machine