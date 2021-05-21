# Virtual Machine in C++ and Assembler
This was a class project that was used to presents theory and concepts of high-performance computer architectures and focus on designing and implementing a simple assembler and virtual machine. I choose to write this project in C++, but can be written in any language of your choice.  The purpose of this is to provide you with some assistance in understanding NOT for reuse or copy.

**I. PROJECT 1**
  
  Implement a Two-Pass Assembler, meaning the VM will read the assembly file twice. 
  
  Used the following instruction - Move: MOV, Arithmetic: ADD, Trap: TRP 3, TRP 0. 
  
  **First pass:**
  
  VM  will create a Symbol Table the key of the Symbol Table is a Label (Code, Data) from an assembly program(file) by reading one line at a time and breaking into tokens. The       value associated with the key is the location of the Label (Label-> Address). Compute the address of the Label during the first pass.  
  
  **Second pass:**
  
  Create bytecode for your program(Op Code, Operand 1 Operand 2) size 12 byte. Using the Symbol Table convert Labels to addresses. Your byte code must be all numeric data: (e.g.,   ADD is 13, R7 is 7, Label A is 1024, etc.) and stored to memory.
  
  **Test Code**
  
  Write the following assembly program using your assembly language.
  Place the following list of integers in memory 
  
  A = (1,2,3,4,5,6)
  
  B = (300, 150, 50, 20, 10, 5)
  
  C = (500, 2, 5, 10)
  
  Place your full name “Last Name, First Name” in contiguous memory.
  
