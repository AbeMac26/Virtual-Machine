# int array [30]
array	.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0
		.INT 0		
				
# Values
ZERO    .INT 0
ONE     .INT 1
FOUR	.INT 4
TWO		.INT 2

#Variables
CNT		.INT 0
_i		.INT 0
_j		.INT 0
_n      .INT 0
T1    	.INT 0
T2    	.INT 0
T3    	.INT 0
T4    	.INT 0
T5		.INT 0
spc     .BYT 32
nl		.BYT 10
A_lock	.INT -42
Ray_LK	.INT -1

#Charaster 
F		.BYT 70
i		.BYT 105
b		.BYT 98
o		.BYT 111
n		.BYT 110
a		.BYT 97
c		.BYT 99
f		.BYT 102
s		.BYT 115

##_______________________________PART 1 & 2 __________________________________
	#_____ while (n !=0)______________
while       TRP  2	
	    LDR R5 ZERO
			BRZ  R3  prtArray
			MOV  R0  R3	       
			
    #______fib(int n)__________________
        	MOV R7 SP    			# Test for overflow SP < SL
        	ADI R7 -32    			# Adjust for space needed (Rtn address & PFP)
        	CMP R7 SL
        	BLT R7 OVERFLOW

     # Create Activation record  and Invoke function
			MOV  R7  FP        		# Save FP in R7, this will be PFP
			MOV  FP  SP        		# Point at current activation record
			MOV  R6  PC        		# PC incremented by 1 instruction
			ADI  R6  108       		# Compute return address
			STR  R6  (SP)     	 	# Store return address
			ADI  SP  -4        		# Adjust for PFP
			STR  R7  (SP)      		# PFP to top of stack
			ADI  SP  -4
        	STR  R0  (SP)      		# n
        	ADI  SP  -24       		# space for temp
        		 	 	    
        	JMP fib
			
			MOV R7 SP	   			# Value from address return
			LDR R4 (R7)
			STR R4 T5
			STR R0 _n
			
	# ____Print Fibonacci X is Y________
        	LDB R3 F
        	TRP 3
        	LDB R3 i
        	TRP 3
        	LDB R3 b
        	TRP 3
        	LDB R3 o
        	TRP 3
		LDB R3 n
        	TRP 3
        	LDB R3 a
        	TRP 3
        	LDB R3 c
        	TRP 3
        	TRP 3
        	LDB R3 i
        	TRP 3
		LDB R3 spc
        	TRP 3
		LDB R3 o
        	TRP 3
		LDB R3 f
        	TRP 3
        	LDB R3 spc
        	TRP 3
        	MOV R3 R0
        	TRP 1
        	LDB R3 spc
        	TRP 3
        	LDB R3 i
        	TRP 3
        	LDB R3 s
        	TRP 3
        	LDB R3 spc
        	TRP 3
        	LDR R3 T5 
        	TRP 1
        	LDB R3 nl
        	TRP 3

	#____Load X and Y into Array[30]_________
        	LDR R7 CNT
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
        	LDR R5 _n				# X value
        	STR R5 (R6)		
        	
        	LDR R7 CNT				#increment i
        	ADI R7 1
        	STR R7 CNT
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
        	LDR R5 T5				# Y value
        	STR R5 (R6)
        	
        	LDR R7 CNT				#increment i
        	ADI R7 1
        	STR R7 CNT
		LDR R5 ZERO
        	
         	JMP while

prtArray	LDR R0 CNT
			LDR R2 TWO
			MOV R3 R0
			DIV R0 R2
			STR R0 CNT
			LDR R1 _i
			STR R3 _i

for_I		LDR R6 CNT
			LDR R7 _j
			CMP R6 R7
			BRZ R6 PART3
						
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
			LDR R3 (R6)
			TRP 1
			LDB R3 spc
			TRP 3
			
			LDR R7 _i
        	ADI R7 -1
        	STR R7 _i
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
        	LDR R3 (R6)
			TRP 1
			LDB R3 spc
			TRP 3
			
			LDR R7 _j				#increment i
        	ADI R7 1
        	STR R7 _j
        	JMP for_I

#______________________________PART 3_______________________________________________

# R0 = X		     
#___________Multithreading______________
PART3		LDB R3 nl
			TRP 3
			LDR R0 ZERO
			LDR R1 ZERO
			LDR R2 ZERO
			LDR R3 ZERO
			LDR R4 ZERO
			LDR R5 ZERO
			LDR R6 ZERO
			LDR R7 ZERO
			STR R0 _j
			STR R0 CNT
			STR R0 _i
			
			LCK  A_lock
whil2 		TRP  2	
			BRZ  R3  stop
			MOV  R0  R3	
       		RUN  R7  NewThread
       		JMP  whil2

stop 		ULK  A_lock
			BLK
			LDB R3 nl
			TRP 3
			
			LDR R0 CNT
			LDR R2 TWO
			MOV R3 R0
			DIV R0 R2
			STR R0 CNT
			LDR R1 _i
			STR R3 _i
			
#___________Print Array_________________
for			LDR R6 CNT
			LDR R7 _j
			CMP R6 R7
			BRZ R6 exit
						
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
			LDR R3 (R6)
			TRP 1
			LDB R3 spc
			TRP 3
			
			LDR R7 _i
        	ADI R7 -1
        	STR R7 _i
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
        	LDR R3 (R6)
			TRP 1
			LDB R3 spc
			TRP 3
			
			LDR R7 _j				#increment i
        	ADI R7 1
        	STR R7 _j
        	JMP for
        	
exit		TRP 0
       	
#__________________END_____________________	

#____________Creat New Thread______________

NewThread	LCK A_lock
			ULK A_lock
			
		    MOV R7 SP          		# Test for overflow SP < SL
        	ADI R7 -32    	   		# Adjust for space needed (Rtn address & PFP)
        	CMP R7 SL
        	BLT R7 OVERFLOW
        	
		
    # Create Activation record  and Invoke function
			MOV  R7  FP        		# Save FP in R7, this will be PFP
			MOV  FP  SP        		# Point at current activation record
			MOV  R6  PC        		# PC incremented by 1 instruction
			ADI  R6  108       		# Compute return address
			STR  R6  (SP)     	 	# Store return address
			ADI  SP  -4        		# Adjust for PFP
			STR  R7  (SP)      		# PFP to top of stack
			ADI  SP  -4
        	STR  R0  (SP)      		# n
        	ADI  SP  -24       		# space for temp
        		 	 	    
        	JMP fib
		
			
			MOV R7 SP	   			# Value from address return
			LDR R4 (R7)
			STR R4 T5
			STR R0 _n
			
	# ____Print Fibonacci X is Y________
        	LDB R3 F
        	TRP 3
        	LDB R3 i
        	TRP 3
        	LDB R3 b
        	TRP 3
        	LDB R3 o
        	TRP 3
		LDB R3 n
        	TRP 3
        	LDB R3 a
        	TRP 3
        	LDB R3 c
        	TRP 3
        	TRP 3
        	LDB R3 i
        	TRP 3
        	LDB R3 spc
        	TRP 3
		LDB R3 o
        	TRP 3
		LDB R3 f
        	TRP 3
		LDB R3 spc
        	TRP 3
        	MOV R3 R0
        	TRP 1
        	LDB R3 spc
        	TRP 3
        	LDB R3 i
        	TRP 3
        	LDB R3 s
        	TRP 3
        	LDB R3 spc
        	TRP 3
        	LDR R3 T5 
        	TRP 1
        	LDB R3 nl
        	TRP 3

	#____Load X and Y into Array[30]_________
			LCK Ray_LK
        	LDR R7 CNT
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
        	LDR R5 _n				# X value
        	STR R5 (R6)		
        	
        	LDR R7 CNT				#increment i
        	ADI R7 1
        	STR R7 CNT
        	LDR R5 FOUR
        	LDA R6 array			#address of array[i+4]
        	MUL R7 R5
        	ADD R6 R7
        	LDR R5 T5				# Y value
        	STR R5 (R6)
        	
        	LDR R7 CNT				#increment i
        	ADI R7 1
        	STR R7 CNT
			ULK Ray_LK
		
		# Set FP before jumping
			MOV  SP  FP
			ADI  FP  -4
			LDR  FP  (FP)

         	END
#________________END________________________	


#_______________fib(int n)___________________
fib 		MOV R7 SP           	# Test for overflow SP < SL
           	ADI R7 -32         		# Adjust for space needed (Rtn address & PFP)
            CMP R7 SL
           	BLT R7 OVERFLOW
			
		# if (n <= 1)
if			MOV R7 FP    			# Save FP in R7 this is PFP
            ADI R7 -8    			# Adjust for space needed (Rtn address & PFP)
            LDR R6 (R7)  			# load n
	        LDR R1 ONE   			# load 1
            CMP R6 R1
            BGT R6 ELSE

		#return n
			MOV R7 FP
			MOV R6 R7
			ADI R6 -8
			LDR R2 (R6)  			# load n
			ADD R5 R2
        	LDR R7 (R7)
			STR R5 (SP)		 
        	JMR R7


ELSE		MOV R7 FP 		
			ADI R7 -8
			LDR R1 (R7)  			# load n
			MOV R2 R1
			
	# Calculate T1 = n-1
			ADI R1 -1
			ADI R7 -4
			STR R1 (R7)
			
	# Calculate T2 = n-2
			ADI R2 -2
			ADI R7 -4
			STR R2 (R7)
		
	
	#______________fib(T1)___________________
			MOV  R7  SP        		# Test for overflow SP < SL
			ADI  R7  -32       		# Adjust for space needed (Rtn address & PFP)
			CMP  R7  SL
			BLT  R7  OVERFLOW
      		

	# Create Activation record  and Invoce function
			MOV  R7  FP       	 	# Save FP in R7, this will be PFP
			MOV  FP  SP        		# Point at current activation record
			MOV  R6  PC        		# PC incremented by 1 instruction
			ADI  R6  108       		# Compute return address
			STR  R6  (SP)      		# Store return address
			ADI  SP  -4        		# Adjust for PFP
			STR  R7  (SP)      		# PFP to top of stack
			ADI  SP  -4
        	STR  R1  (SP)      		# n-1
       		ADI  SP  -24       		# space for temp

	# Jump to fib ()
			JMP  fib     
		   
    # T3 = fib(T1)
       		LDR  R2 (SP)      		# value in return address
        
        		
	# Set FP before jumping
	   		MOV  SP  FP
	   		ADI  FP  -4
	    	LDR  FP  (FP)
 		
			MOV  R7 FP 
			ADI  R7 -16
        	LDR  R1 (R7)        		# Get from mem value T2
       		MOV  R2	R1	       		# store in T2 variable for f(n-2)
       
    #if (n-2) > 2 jump to else
     		LDR  R3 ONE
			CMP  R1 R3
			BGT  R1 LOAD
			
		
	# _____________fib(T2)____________________
   			MOV  R7  SP		 		# Test for overflow SP < SL
			ADI  R7  -32			# Adjust for Return address, variables and PFP
			CMP  R7  SL
			BLT  R7  OVERFLOW
			
	# Create Activation record  and Invoce function
			MOV  R7  FP	   			# Save FP in R7, this will be PFP
			MOV  FP  SP	   			# Point at current activation record
			MOV  R6  PC	   			# PC incremented by 1 instruction
			ADI  R6  108	   		# Compute return address
			STR  R6  (SP)	   		# Store return address
			ADI  SP  -4	   	   		# Adjust for PFP
			STR  R7  (SP)	   		# PFP to top of stack
        	ADI  SP  -4
        	STR  R2  (SP)      		# n-2
        	ADI  SP  -24       		# space for temp
		
	# Jump to fib()
			JMP  fib
        
    # T4 = fib(T2)
	    	LDR R6 (SP)         	# value in return address
	   		
    
    # Set FP before jumping
        	MOV SP  FP
        	ADI FP  -4
        	LDR FP  (FP)
    		
   	# Test for underflow SP > SB
       		MOV SP  FP
        	MOV R7  SP
        	CMP R7  SB
        	BGT	R7  UNDERFLOW
	 
	# Return
	    	MOV R7 FP
        	LDR R7 (R7)
			STR R6 (SP)
        	JMR	R7

LOAD		MOV R7 FP
			ADI R7 -8
			STR R2 (R7)      		# return value
			BGT R1 if
       
# _____________PART 3 END____________________________________________________


OVERFLOW 	LDR R3 FOUR
			TRP 1
			TRP 1
			TRP 1
			TRP 0
			
UNDERFLOW 	LDR R3 ZERO
			TRP 1
			TRP 1
			TRP 1
			TRP 0


        		