# Variables
SIZE        .INT 7		# int SIZE = 7
cnt         .INT 7		# int cnt = 7
tenth       .INT 0		# int tenth = 0
c           .BYT 0		# char array c[]
            .BYT 0
            .BYT 0
            .BYT 0
            .BYT 0
            .BYT 0
            .BYT 0
data        .INT 0		# int data = 0
flag        .INT 0		# int flag = 0
opdv        .INT 0		# int opdv = 0


# Program Symbols and characters
PLUS        .BYT 43		# +
MINUS       .BYT 45		# -
spc         .BYT 32		# space
ret         .BYT 10		# newline or return
EMPTY       .BYT 3      # place holder
at          .BYT 64		# @

# Console messages
notaNum     .BYT 32
            .BYT 105	# i
            .BYT 115	# s
            .BYT 32		
            .BYT 110	# n
            .BYT 111	# o
            .BYT 116	# t
            .BYT 32		
            .BYT 97		# a
            .BYT 32		
            .BYT 110	# n
            .BYT 117	# u
            .BYT 109	# m
            .BYT 98		# b
            .BYT 101	# e
            .BYT 114	# r
            .BYT 10		
            .BYT 3      # EMPTY

num2Big  	.BYT 78		# N
            .BYT 117	# u
            .BYT 109	# m
            .BYT 98		# b
            .BYT 101	# e
            .BYT 114	# r
            .BYT 32
            .BYT 116	# t
            .BYT 111	# o
            .BYT 111	# o
            .BYT 32
            .BYT 66		# B
            .BYT 105	# i
            .BYT 103	# g
            .BYT 10
            .BYT 3      #EMPTY

goodnum     .BYT 111	# O
            .BYT 112	# p
            .BYT 101	# e
            .BYT 114	# r
            .BYT 97		# a
            .BYT 110	# n
            .BYT 100	# d
            .BYT 32
            .BYT 105	# i
            .BYT 115	# s
            .BYT 32
            .BYT 3		#EMPTY


# Other useful values
ZERO        .INT 0
I           .INT 1
X           .INT 10
Xero       	.BYT 48		# char 0
One        	.BYT 49		# char 1
Two        	.BYT 50		# char 2
Three      	.BYT 51		# char 3
Four       	.BYT 52		# char 4
Five       	.BYT 53		# char 5
Six        	.BYT 54		# char 6
Seven      	.BYT 55		# char 7
Eight      	.BYT 56		# char 8
Nine       	.BYT 57		# char 9
_s          .BYT 43	
_k          .INT 1
_j          .BYT 7

JMP  MAIN

#  Convert char j to an integer if possible.
#  If the flag is not set use the sign indicator s
#  and the tenths indicator to compute the actual
#  value of j.  Add the value to the accumulator opdv.
# __________________opd(char s, int k, char j)_________________________
opd			MOV  R7  SP        # Test for overflow SP < SL
      		ADI  R7  -20       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW

		#  Invoke function
            MOV  R7  FP			# Save FP in R7, this will be PFP
            ADI  R7  -12 		# Adjust for space needed (Rtn address & PFP)
            LDB  R0  (R7)        # Load char s
            ADI  R7  -4
            LDR  R1  (R7)        # Load int k
            ADI  R7  -4
            LDB  R2  (R7)        # Load char j
            LDR  R4  ZERO        # local int t = 0
            
		# if (j == '0')
            LDB  R5  Xero
            CMP  R5  R2         
            BNZ  R5  ELSE1
            ADI  R4  0           # t = 0
            JMP  ENDIF
            
		# else if (j == '1')
ELSE1		LDB  R5  One
            CMP  R5  R2          
            BNZ  R5  ELSE2
            ADI  R4  1			# t = 1
            JMP  ENDIF
            
		# else if (j == '2')
ELSE2		LDB  R5  Two
            CMP  R5  R2          
            BNZ  R5  ELSE3
            ADI  R4  2           # t = 2
            JMP  ENDIF
            
		# else if (j == '3')
ELSE3		LDB  R5  Three
            CMP  R5  R2         
            BNZ  R5  ELSE4
            ADI  R4  3          # t = 3
            JMP  ENDIF
            
		# else if (j == '4')
ELSE4		LDB  R5  Four
            CMP  R5  R2          
            BNZ  R5  ELSE5
            ADI  R4  4           # t = 4
            JMP  ENDIF
            
		# else if (j == '5')
ELSE5		LDB  R5  Five
            CMP  R5  R2          
            BNZ  R5  ELSE6
            ADI  R4  5           # t = 5
            JMP  ENDIF

		# else if (j == '6')
ELSE6		LDB  R5  Six
            CMP  R5  R2          
            BNZ  R5  ELSE7
            ADI  R4  6           # t = 6
            JMP  ENDIF
            
		# else if (j == '7')
ELSE7		LDB  R5  Seven
            CMP  R5  R2          
            BNZ  R5  ELSE8
            ADI  R4  7           # t = 7
            JMP  ENDIF

		# else if (j == '8')
ELSE8		LDB  R5  Eight
            CMP  R5  R2          
            BNZ  R5  ELSE9
            ADI  R4  8           # t = 8
            JMP  ENDIF

		# else if (j == '9')
ELSE9		LDB  R5  Nine
            CMP  R5  R2          
            BNZ  R5  ELSE
            ADI  R4  9           # t = 9
            JMP  ENDIF

		# else set flag and print not a number
ELSE		MOV  R3  R2
            TRP  3

# __________________________Print()_________________________________
            LDA  R5  notaNum
            LDB  R3  (R5)
P1			LDB  R4  EMPTY
            CMP  R4  R3
            BRZ  R4  endP1
            TRP  3
            ADI  R5  1
            LDB  R3  (R5)
            JMP  P1
           

endP1		LDB  R5  flag
            ADI  R5  1
            STR  R5  flag       # flag = 1

ENDIF 		LDR  R5  flag

		# if (!flag)
            BNZ  R5  RETURN  
             
		# if (s == '+')
            LDB  R5  PLUS
            CMP  R5  R0
            BNZ  R5  SPLUSELSE   
            MUL  R4  R1          # t *= k
            JMP  ENDSPLUS
		# else
SPLUSELSE	MOV  R5  R1
            SUB  R5  R1
            SUB  R5  R1          
            MUL  R4  R5          # t *= -k

ENDSPLUS	LDR  R7  opdv
            ADD  R7  R4          # opdv + t
            STR  R7  opdv
            
		# Return
RETURN	    MOV  SP  FP			# Test for underflow  SP > SB
            MOV  R5  SP
            CMP  R5  SB
            BGT  R5  UNDERFLOW
            
	    MOV  R5  FP        	
            ADI  R5  -4
            LDR  R5  (R5)

            JMR  R5
#__________________________END______________________________________


# Discard keyboard input untill a newline '\n' is
# Ecountered
#_________________________flush()___________________________________
flush		MOV  R7  SP			# Test for overflow SP < SL
			ADI  R7  -8			# Adjust for Return address, variables and PFP
			CMP  R7  SL
			BLT  R7  OVERFLOW

			LDR  R0  ZERO
			STR  R0  data

f_while		TRP  4
			STB  R3  c
			LDB  R0  ret
			CMP  R0  R3
			BNZ  R0  f_while
			
		# begin return call
			MOV  SP  FP        # Test for underflow
			MOV  R5  SP
			CMP  R5  SB
			BGT  R5  UNDERFLOW
      
		# Store Return value
      		LDR  R7  ZERO      
      
		# Return
      		MOV  R6  FP        
      		ADI  R6  -4
      		LDR  R6  (R6)
      		JMR  R6
#__________________________END______________________________________


# Read one char at a time from the keyboard after a
# newline ‘\n’ has been entered. If there is room
# place the char in the array c
# otherwise indicate the number is too big and
# flush the keyboard input.
#______________________getdata()____________________________________
getdata		MOV  R7  SP        # Test for overflow SP < SL
      		ADI  R7  -8        # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
     		BLT  R7  OVERFLOW

		# if (cnt < SIZE)
			LDR  R0  cnt		
			LDR  R1  SIZE		
			CMP  R0  R1
			BLT  R0  ifYes  

		#____________________print()________________________
			MOV  R7  SP        # Test for overflow SP < SL
			ADI  R7  -12       # Adjust for space needed (Rtn address & PFP)
			CMP  R7  SL
			BLT  R7  OVERFLOW
      
		# Create Activation record  and Invoce function
			MOV  R7  FP        # Save FP in R7, this will be PFP
			MOV  FP  SP        # Point at current activation record
			ADI  SP  -4        # Adjust SP for return address
			MOV  R6  PC        # PC incremented by 1 instruction
			ADI  R6  108       # Compute return address
			STR  R6  (SP)      # Store return address
			ADI  SP  -4        # Adjust for PFP
			STR  R7  (SP)      # PFP to top of stack
			ADI  SP  -4
			LDA  R6  num2Big
			STR  R6  (SP)

		# Jump to Print ()
			JMP  print
      
		# Set FP before jumping
			MOV  SP  FP
			ADI  FP  -8
			LDR  FP  (FP)

		# ___________________flush()___________________________
 eps2		MOV  R7  SP			# Test for overflow SP < SL
			ADI  R7  -8			# Adjust for Return address, variables and PFP
			CMP  R7  SL
			BLT  R7  OVERFLOW
			
		# Create Activation record  and Invoce function
			MOV  R7  FP			# Save FP in R7, this will be PFP
			MOV  FP  SP			# Point at current activation record
			ADI  SP  -4			# Adjust SP for return address
			MOV  R6  PC			# PC incremented by 1 instruction
			ADI  R6  72			# Compute return address
			STR  R6  (SP)		# Store return address
			ADI  SP  -4			# Adjust for PFP
			STR  R7  (SP)		# PFP to top of stack

		# Jump to flush()
			JMP  flush

		# Set FP before jumping
			MOV  SP  FP
			ADI  FP  -8
			LDR  FP  (FP)
			JMP  ifend

ifYes		LDA  R5  c
			LDR  R4  cnt
			ADD  R5  R4
			TRP  4
			STB  R3  (R5)
			ADI  R4  1
			STR  R4  cnt
			
		# Test for underflow SP > SB
ifend		MOV  SP  FP        
         	MOV  R5  SP
         	CMP  R5  SB
         	BGT  R5  UNDERFLOW
         	
		# Store Return address value
         	LDR  R7  ZERO
         
		# Return
         	MOV  R6  FP
         	ADI  R6  -4
         	LDR  R6  (R6)
         	JMR  R6
# _________________________END______________________________________

# Reset c to all 0's
# Assign values to data, opdv, cnt, and flag
# _______________reset(int w, int x, int y, int z)__________________
reset		MOV  R7  SP        # Test for overflow SP < SL
     		ADI  R7  -24       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW

		# Load Parameters
			MOV  R6  FP			
      		ADI  R6  -12		# w
      		LDR  R0  (R6)
      		ADI  R6  -4			# x
      		LDR  R1  (R6)
      		ADI  R6  -4			# y
      		LDR  R2  (R6)
      		ADI  R6  -4			# z
      		LDR  R4  (R6)
      
     		 LDR  R6  ZERO
     		 LDA  R5  c			# Char c 
 
 for0		LDR  R7  SIZE		# For loop
      		CMP  R7  R6
    		BRZ  R7  ef0
      		LDR  R7  ZERO
     		STB  R7  (R5)
      		ADI  R6  1
      		ADI  R5  1
      		JMP  for0

ef0			STR  R0  data		# int data
      		STR  R1  opdv		# int opdv
      		STR  R2  cnt		# int cnt
      		STR  R4  flag		# int flag
      
		# Test for underflow SP > SB
      		MOV  SP  FP			
      		MOV  R5  SP
    		CMP  R5  SB
      		BGT  R5  UNDERFLOW
      		
		# Store Return value
      		LDR  R7  ZERO
      
		# Return
      		MOV  R6  FP
      		ADI  R6  -4
      		LDR  R6  (R6)
      		JMR  R6
# _________________________END______________________________________

# Will print string to console
# ____________________print()________________________________________
print		MOV  R1  FP        # Copy FP to R1
			ADI  R1  -12       # Adjust for space needed (Rtn address & PFP)
			LDR  R2  (R1)      # Load in the value
			LDB  R3  (R2)      

start		LDB  R0  EMPTY
			CMP  R0  R3
			BRZ  R0  donePrint
			TRP  3
			ADI  R2  1
			LDB  R3  (R2)
			JMP  start

		#Test for underflow SP > SB
 donePrint	MOV  SP  FP			
			MOV  R5  SP
			CMP  R5  SB
			BGT  R5  UNDERFLOW
			
		# Store Return value
			LDR  R7  ZERO	
			
		# Return
			MOV  R6  FP			
			ADI  R6  -4
			LDR  R6  (R6)
			JMR  R6
# _________________________END______________________________________


# Get input from the keyboard until the symbol '@' is encountered.
# Convert the data input from keyboard to an integer be
# Sure to account for the sign of the number. If no sign is used
# always assume the number is positive.
#_________________________main()____________________________________

		#_________________reset()__________________________
MAIN 		MOV  R7  SP        # Test for overflow SP < SL
     		ADI  R7  -24       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW
      		
		# Create Activation record  and Invoce function
      		MOV  R7  FP        # Save FP in R7, this will be PFP
      		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for return address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  216       # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack
      		ADI  SP  -4
      		LDR  R6  I
      		STR  R6  (SP)      # w
      		ADI  SP  -4
     		LDR  R6  ZERO
      		STR  R6  (SP)      # x
      		ADI  SP  -4
     		LDR  R6  ZERO
      		STR  R6  (SP)      # y
      		ADI  SP  -4
      		LDR  R6  ZERO
      		STR  R6  (SP)      # z
      		
		# Jump to reset() 
      		JMP  reset

		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)

		#________________getdata()____________________________
      		MOV  R7  SP        # Test for overflow SP < SL
      		ADI  R7  -8       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
     		BLT  R7  OVERFLOW
     		
		# Create Activation record  and Invoce function
      		MOV  R7  FP        # Save FP in R7, this will be PFP
     		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for return address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  72        # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack

		# Jump to getdata()
      		JMP  getdata
      
		# Set FP before jumping
     		MOV  SP  FP
      		ADI  FP  -8
     		LDR  FP  (FP)

		# while(c[0]!= @)
whi1e		LDB  R0  c
    		LDB  R1  at
      		CMP  R1  R0
      		BRZ  R1  w1_end      
      		LDB  R1  PLUS
      		LDB  R2  MINUS
      		CMP  R1  R0
      		CMP  R2  R0

		#if(c[0] == + || c[0] == -)
			BRZ  R1  if_gdata
      		BRZ  R2  if_gdata       
      		JMP  m_else1		# Jump to else
      
		# _______________getdata()_____________________________
if_gdata	MOV  R7  SP         # Test for overflow SP < SL
      		ADI  R7  -8        # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW
      		
		# Create Activation record  and Invoce function
      		MOV  R7  FP         # Save FP in R7, this will be PFP
     		MOV  FP  SP         # Point at current activation record
      		ADI  SP  -4         # Adjust SP for return address
      		MOV  R6  PC         # PC incremented by 1 instruction
      		ADI  R6  72			# Compute return address
      		STR  R6  (SP)       # Store return address
      		ADI  SP  -4         # Adjust for PFP
      		STR  R7  (SP)       # PFP to top of stack

		# Jump to getdata()
      		JMP  getdata
      
		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)
      		JMP  whi2e
      		
		# else
m_else1		LDA  R1  c          # c[1] = c[0]
      		ADI  R1  1
      		STB  R0  (R1)
      		LDB  R1  PLUS       # c[0] = '+'
      		STB  R1  c
      		LDR  R1  cnt        # cnt++
      		ADI  R1  1
      		STR  R1  cnt
      
		# while(data)
whi2e		LDR  R0  data
    		BRZ  R0  w2_end       # end while loop

		# if(c[cnt-1] == '\n')
      		LDR  R1  cnt
      		ADI  R1  -1
      		LDA  R2  c
      		ADD  R2  R1
      		LDB  R2  (R2)
      		LDB  R4  ret
      		CMP  R2  R4
      		BNZ  R2  els2   	# Jump to else    

      		LDR  R0  ZERO     	# data = 0
      		STR  R0  data
      		LDR  R0  I        	# tenth = 1
      		STR  R0  tenth
      		ADI  R1  -1       	# cnt = cnt - 2
      		STR  R1  cnt

		# while(!flag && cnt != 0)
whi3e		LDR  R4  flag
      		LDR  R5  cnt
      		BNZ  R4  w3_end
      		BRZ  R5  w3_end

		#___________opd(char s, int k, char j)________________
      		MOV  R7  SP        # Test for overflow SP < SL
      		ADI  R7  -20       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW
      
		# # Create Activation record  and Invoce function
      		MOV  R7  FP        # Save FP in R7, this will be PFP
      		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for return address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  216       # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack
      		ADI  SP  -4
      		LDB  R6  c
      		STB  R6  (SP)
      		ADI  SP  -4
      		LDR  R6  tenth
      		STR  R6  (SP)
      		ADI  SP  -4
      		LDA  R6  c
      		LDR  R7  cnt
      		ADD  R6  R7
      		LDB  R6  (R6)
      		STB  R6  (SP)
      		
		# Jump to opd()
      		JMP  opd
      
		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)

		# decrement cnt
      		LDR  R1  cnt       # cnt--
      		ADI  R1  -1
      		STR  R1  cnt
      		
		# tenth *= 10
      		LDR  R1  tenth
      		LDR  R2  X
      		MUL  R1  R2
      		STR  R1  tenth
      		JMP  whi3e			# return begining loop

		w3_end LDR  R0  flag
      		BRZ  R0  print_f
      		JMP  end_pinrtf
      
		# ________print()_____________________________
print_f		MOV  R7  SP        # Test for overflow SP < SL
      		ADI  R7  -12       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW

		# Create Activation record  and Invoce function
     		MOV  R7  FP        # Save FP in R7, this will be PFP
     		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for return address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  108       # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack
      		ADI  SP  -4
      		LDA  R6  goodnum
      		STR  R6  (SP)
      		
		# Jump to print()
      		JMP  print
      
		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)
      		
		# End function call
      		LDR  R3  opdv
      		TRP  1
      		LDB  R3  ret
      		TRP  3
 
end_pinrtf  JMP  whi2e			# Jump back to whi2e loop

		# else
		# ______________ getdata()__________________________
els2		MOV  R7  SP			# Test for overflow
      		ADI  R7  -8        # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW
      		
		# Create Activation record  and Invoke function
      		MOV  R7  FP        # Save FP in R7, this will be PFP
      		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for return address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  72        # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack

		# Jump to getdata()
      		JMP  getdata
      
		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)
      		JMP  whi2e         # Jump back to whi2e loop

		# ___________reset()__________________________________
w2_end		MOV  R7  SP        # Test for overflow SP < SL
      		ADI  R7  -24       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW
      		
		# Create Activation record  and Invoke function
      		MOV  R7  FP        # Save FP in R7, this will be PFP
     		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for ret address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  216       # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack
      		ADI  SP  -4
      		LDR  R6  I
      		STR  R6  (SP)      # w
      		ADI  SP  -4
      		LDR  R6  ZERO
      		STR  R6  (SP)      # x
      		ADI  SP  -4
      		LDR  R6  ZERO
      		STR  R6  (SP)      # y
      		ADI  SP  -4
      		LDR  R6  ZERO
      		STR  R6  (SP)      # z
      		
		# Jump to reset()
      		JMP  reset
      		
		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)


		# _______________getdata()_______________________
      		MOV  R7  SP        # Test for overflow SP < SL 
      		ADI  R7  -8       # Adjust for space needed (Rtn address & PFP)
      		CMP  R7  SL
      		BLT  R7  OVERFLOW
      		
		# Create Activation record  and Invoke function
     		MOV  R7  FP        # Save FP in R7, this will be PFP
      		MOV  FP  SP        # Point at current activation record
      		ADI  SP  -4        # Adjust SP for return address
      		MOV  R6  PC        # PC incremented by 1 instruction
      		ADI  R6  72        # Compute return address
      		STR  R6  (SP)      # Store return address
      		ADI  SP  -4        # Adjust for PFP
      		STR  R7  (SP)      # PFP to top of stack

		# Jump to getdata()
      		JMP  getdata
      
		# Set FP before jumping
      		MOV  SP  FP
      		ADI  FP  -8
      		LDR  FP  (FP)
      		
      		JMP  whi1e			# Jump to begining of whi1e loop

w1_end		ADI  R0  0			
			TRP  0				# Terminate

UNDERFLOW	LDB  R3  Six
			TRP  3
			TRP  3
			TRP  3 
			TRP  0
			
OVERFLOW   	LDB  R3  Nine
			TRP  3
			TRP  3
			TRP  3
			TRP  0