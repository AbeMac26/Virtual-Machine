// Abel Macias
//  main.cpp
//  Project3
//
//  Created by Abel Macias on 3/18/21.
//  Copyright © 2021 Abel Macias. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <string>
#include <regex>
#include <map>
#include <vector>
#include <cstring>
#include<string.h>

using namespace std;
const int MEM_SIZE = 20000;
map <string, int> symbol_Table;
char mem[MEM_SIZE];
int pcounter = 0;
int line_cnt = 0;
int sl_count = 0;
int operand = 0;

enum {
    op1 = 4,
    op2 = 8,
};

// Enumeration for Register 1 - 7
enum {
    R0 = 0,
    R1,
    R2,
    R3,
    R4,
    R5,
    R6,
    R7,
    PC,
    SL,
    SP,
    FP,
    SB,
    RegSize
};

//Enumeration for Operator codes
enum {
    JMP = 1,
    JMR = 2,
    BNZ = 3,
    BGT = 4,
    BLT = 5,
    BRZ = 6,
    MOV = 7,
    LDA = 8,
    STR = 9,
    LDR = 10,
    STB = 11,
    LDB = 12,
    ADD = 13,
    ADI = 14,
    SUB = 15,
    MUL = 16,
    DIV = 17,
    CMP = 20,
    TRP = 21,
    iSTR = 22,
    iLDR = 23,
    iSTB = 24,
    iLDB = 25,
};

// isOpdCode
// Parameter : String
// Retunr: bool
// This function will check if the string Operator code (op) is valid.
bool isInstruction(string op) {
    if ("JMP" == op) {
        return true;
    }
    if ("JMR" == op) {
        return true;
    }
    if ("BNZ" == op) {
        return true;
    }
    if ("BGT" == op) {
        return true;
    }
    if ("BLT" == op) {
        return true;
    }
    if ("BRZ" == op) {
        return true;
    }
    if ("MOV" == op) {
        return true;
    }
    if ("LDA" == op) {
        return true;
    }
    if ("STR" == op) {
        return true;
    }
    if ("LDR" == op) {
        return true;
    }
    if ("STB" == op) {
        return true;
    }
    if ("LDB" == op) {
        return true;
    }
    if ("ADD" == op) {
        return true;
    }
    if ("ADI" == op) {
        return true;
    }
    if ("SUB" == op) {
        return true;
    }
    if ("MUL" == op) {
        return true;
    }
    if ("DIV" == op) {
        return true;
    }
    if ("CMP" == op) {
        return true;
    }
    if ("TRP" == op) {
        return true;
    }
    else
        return false;
};

// opCodeString
// Parameter : string
// Retunr: string
// This function will convert the enumeration Operator to string.
string instType(string op) {
    if ("JMP" == op) {
        return to_string(JMP);
    }
    if ("JMR" == op) {
        return to_string(JMR);
    }
    if ("BNZ" == op) {
        return to_string(BNZ);
    }
    if ("BGT" == op) {
        return to_string(BGT);
    }
    if ("BLT" == op) {
        return to_string(BLT);
    }
    if ("BRZ" == op) {
        return to_string(BRZ);
    }
    if ("MOV" == op) {
        return to_string(MOV);
    }
    if ("LDA" == op) {
        return to_string(LDA);
    }
    if ("STR" == op) {
        return to_string(STR);
    }
    if ("LDR" == op) {
        return to_string(LDR);
    }
    if ("STB" == op) {
        return to_string(STB);
    }
    if ("LDB" == op) {
        return to_string(LDB);
    }
    if ("ADD" == op) {
        return to_string(ADD);
    }
    if ("ADI" == op) {
        return to_string(ADI);
    }
    if ("SUB" == op) {
        return to_string(SUB);
    }
    if ("MUL" == op) {
        return to_string(MUL);
    }
    if ("DIV" == op) {
        return to_string(DIV);
    }
    if ("CMP" == op) {
        return to_string(CMP);
    }
    if ("TRP" == op) {
        return to_string(TRP);
    }
    else
        return "invalid";
};

string inderectAddress(string op) {
    if ("STR" == op) {
        return to_string(iSTR);
    }
    if ("LDR" == op) {
        return to_string(iLDR);
    }
    if ("STB" == op) {
        return to_string(iSTB);
    }
    if ("LDB" == op) {
        return to_string(iLDB);
    }
    else
        return "invalid";
}

// operandString
// Parameter : string
// Retunr: string
// This function will convert the enureration Registers to string.
string operandType(string operand) {
    if ("R0" == operand) {
        return to_string(R0);
    }
    if ("R1" == operand) {
        return to_string(R1);
    }
    if ("R2" == operand) {
        return to_string(R2);
    }
    if ("R3" == operand) {
        return to_string(R3);
    }
    if ("R4" == operand) {
        return to_string(R4);
    }
    if ("R5" == operand) {
        return to_string(R5);
    }
    if ("R6" == operand) {
        return to_string(R6);
    }
    if ("R7" == operand) {
        return to_string(R7);
    }
    if ("PC" == operand) {
        return to_string(PC);
    }
    if ("SL" == operand) {
        return to_string(SL);
    }
    if ("SP" == operand) {
        return to_string(SP);
    }
    if ("FP" == operand) {
        return to_string(FP);
    }
    if ("SB" == operand) {
        return to_string(SB);
    }
    // Trap MMI codes
    if ("0" == operand)
        return "0";
    if ("1" == operand)
        return "1";
    if ("2" == operand)
        return "2";
    if ("3" == operand)
        return "3";
    if ("4" == operand)
        return "4";
    else
        for (auto itr = symbol_Table.begin(); itr != symbol_Table.end(); itr++)
            if (operand == itr->first)
                return to_string(itr->second);
    
    return "invalid";
};

bool isReg(string op) {
    string r[] = { "R0","R1","R2","R3","R4","R5","R6","R7","PC","SL","SP","FP","SB"};
    for (int t = 0; t < 13; t++)
        if (op == r[t])
            return true;
    return false;
}

// write
// Parameters: string and int
// Return: void
// Write 4 BYTE integer operand value to memory address
void writeInt(string value, int location) {
    try {
        if (value != "" || location >= MEM_SIZE) {
            char* ptr = (mem + location);
            (*(int*)ptr) = (int)strtol(value.c_str(), NULL, 10);
        }
    }
    catch (string value) {
        cerr << "Unable to write interger " << value << " to memory location " << location << endl;
    }
};

// writeByt
// Parameters: string and int
// Return: void
// Write one BYTE character operand value to memory address by conversting
// the string to char. If the value is NULL error message will printed.
void writeByte(string value, int location) {
    try {
        if (value != "" || location >= MEM_SIZE)
            mem[location] = (char)(strtol(value.c_str(), NULL, 10));
        else
            throw value;
    }
    catch (string value) {
        cerr << "Unable to write byte " << value << " to memory location " << location << endl;
    }
};

// isDirective
// Parameter: string
// Return: bool
// Check if string is type .INT or .BYT derictive
bool isDirective(string s) {
    if (s == ".INT")
        return true;
    if (s == ".BYT")
        return true;
    else
        return false;
};

// createTabel
// Parameter: string, string , int
// Return: int
// Will create table of the type map<string,int>. Will store key
// string label and int value address.
int createTable(string label, string dir, int address) {
    if (dir == ".INT") {
        symbol_Table.insert({ label, address });
        return 4;
    }
    else if (dir == ".BYT") {
        symbol_Table.insert({ label, address });
        return 1;
    }
    else if (isInstruction(dir)) {
        symbol_Table.insert({ label,address });
        return 12;
    }
    else
        cout << "error at line #" << line_cnt << " " << label << " " << dir << " " << address << endl;
    exit(0);
    return 0;
};

// storeToMem
// Parameters: string, string, int
// Return: int
// Will check the type of instruction. If its a
// derective type .INT or .BYTE and write to memory address or
// If its a operator and operand(s) it will store to memory
// and return the integer value of bytes used.
int storeToMem(string dir, string op, int location) {
    if (dir == ".INT") {
        writeInt(op, location);
        return 4;
    }
    else if (dir == ".BYT") {
        writeByte(op, location);
        return 1;
    }
    else if (isInstruction(dir)) {
        string s = instType(op);
        if (s == "invalid") {
            s = operandType(op);
            if (s == "invalid") {
                char *p;
                long converted = strtol(op.c_str(), &p, 10);
                if(*p){
                cerr << "error with operand " << op << " at line #" << line_cnt << endl;
                exit(0);
                }
                else
                    writeInt(op, location);
            }
            else { // if s is a Register or Label
                operand++;
                if (operand == 2 && isReg(op)) {
                    string newINS = inderectAddress(dir);
                    if (newINS != "invalid")
                        writeInt(newINS, location - 8);
                }
                writeInt(s, location);
            }
        }
        else {
            writeInt(s, location);
            operand = 0;
        }
        return 4;
    }
    else {
        cerr << "error with operand " << op << " at line #" << line_cnt << endl;
        exit(0);
    }
    return 0;
};

// ReadTextFile
// Parameters: string, bool
// Returns: none
// Will read the file line by line, convert them to tokens
// and create a symbol table on pass 1 and pass 2 will
// store directives and instructions to memory array
// according to .INT, .BYT, operator and operand 1 and operand 2.
// Also set the PC counter.
void ReadTextFile(string fileName, bool& pass1) {
    string line;
    //string fileName, line;
    //cout << "Enter file name (i.e. test.tx): ";
    //cin >> fileName;
    fstream file(fileName);
    int count = 0;
    
    if (file.is_open()) {
        while (file.good()) {
            getline(file, line);
            line_cnt++;
            string str = line.substr(0, line.find("#", 0));
            regex re(R"([\s|\t|\'|\(|\)]+)"); //breaks the string up to tokens
            vector<string> out(sregex_token_iterator(str.begin(), str.end(), re, -1), sregex_token_iterator()); //stores tokens in vector
            out.erase(remove_if(out.begin(), out.end(), [](string const& s) {return s.size() == 0; }), out.end());
            
            /* Firs Pass: will read file and creadt Sympbol Table */
            if (pass1) {
                if (!out.empty() && out.size() >= 2) {
                    if (isDirective(out.at(0))) {//no label
                        if (out.at(0) == ".BYT")
                            count += 1;
                        if (out.at(0) == ".INT")
                            count += 4;
                        pcounter = count;
                    }
                    else if (isDirective(out.at(1))) {
                        count += createTable(out.at(0), out.at(1), count);
                        pcounter = count;
                    }
                    else if (!(isInstruction(out.at(0)))) {
                        count += createTable(out.at(0), out.at(1), count);
                    }
                    else if (isInstruction(out.at(0)))
                        count += 12;
                }
            }
            /* Second pass: Will store instrcution to memory*/
            else {
                if (!out.empty() && out.size() >= 2) {
                    if (isDirective(out.at(0)))//no Label on Directive
                        count += storeToMem(out.at(0), out.at(1), count);
                    else if (isDirective(out.at(1))) {
                        count += storeToMem(out.at(1), out.at(2), count);
                    }
                    else {
                        if (isInstruction(out.at(0))) {//no label on instruction
                            int j = 0;
                            for (j = 0; j < out.size(); j++)
                                count += storeToMem(out.at(0), out.at(j), count);
                            if (3 - j != 0)
                                count += (4 * (3 - j));
                        }
                        else if (isInstruction(out.at(1))) {//maybe a label
                            int n = 0;
                            for (n = 1; n < out.size(); n++)
                                count += storeToMem(out.at(1), out.at(n), count);
                            if ((3 + 1) - n != 0)
                                count += (4 * ((3 + 1) - n));
                        }
                    }
                }
            }
            if (file.peek() == EOF) {
                break;
            }
        }
    }
    if (!file.eof() && file.fail()){
        cout << "error reading file " << fileName << endl;
        exit(0);
    }
    file.close();
    pass1 = false;
    sl_count = count;
    line_cnt = 0;
    
};

//readInt
// Parameters: int
// Returns: int
// Will take the location to read from memory array
// and return the data in interger type
int readInt(int location) {
    char* ptr = (mem + location);
    return (*(int*)ptr);
};

int main(int argc, const char* argv[]) {
    bool pass1 = true;
    int reg[RegSize];
    int stack = MEM_SIZE;
    reg[PC] = -1;
    reg[SB] = stack;
    reg[FP] = 0;
    reg[SP] = stack;
    
    bool running = true;
    if (argc < 2) {
        cerr << "Usage: vm.exe <File Name>" << endl;
        exit(0);
    }
    ReadTextFile(argv[1], pass1);
    reg[PC] = pcounter;
    reg[SL] = sl_count;
    ReadTextFile(argv[1], pass1);
    
    // Virtual Machine
    while (running) {
        int IR = readInt(reg[PC]);
        switch (IR) {
            case JMP:
                reg[PC] = readInt(reg[PC] + op1);
                break;
                
            case JMR:
                reg[PC] = reg[readInt(reg[PC] + op1)];
                break;
                
            case BNZ:
                if (reg[readInt(reg[PC] + op1)] != 0)
                    reg[PC] = readInt(reg[PC] + op2);
                else
                    reg[PC] += 12;
                break;
                
            case BGT:
                if (reg[readInt(reg[PC] + op1)] > 0)
                    reg[PC] = readInt(reg[PC] + op2);
                else
                    reg[PC] += 12;
                break;
                
            case BLT:
                if (reg[readInt(reg[PC] + op1)] < 0)
                    reg[PC] = readInt(reg[PC] + op2);
                else
                    reg[PC] += 12;
                break;
                
            case BRZ:
                if (reg[readInt(reg[PC] + op1)] == 0)
                    reg[PC] = readInt(reg[PC] + op2);
                else
                    reg[PC] += 12;
                break;
                
            case MOV:
                reg[readInt(reg[PC] + op1)] = reg[readInt(reg[PC] + op2)];
                reg[PC] += 12;
                break;
                
            case LDA:
                reg[readInt(reg[PC] + op1)] = readInt(reg[PC] + op2);
                reg[PC] += 12;
                break;
                
            case STR:
                writeInt(to_string(reg[readInt(reg[PC] + op1)]), readInt(reg[PC] + op2));
                reg[PC] += 12;
                break;
                
            case iSTR:
                writeInt(to_string(reg[readInt(reg[PC] + op1)]), reg[readInt(reg[PC] + op2)]);;
                reg[PC] += 12;
                break;
                
            case LDR:

                reg[readInt(reg[PC] + op1)] = readInt(readInt(reg[PC] + op2));
                reg[PC] += 12;
                break;
                
            case iLDR:
                reg[readInt(reg[PC] + op1)] = readInt(reg[readInt(reg[PC] + op2)]);
                reg[PC] += 12;
                break;
                
            case STB:
                writeByte(to_string(reg[readInt(reg[PC] + op1)]), readInt(reg[PC] + op2));
                reg[PC] += 12;
                break;
                
            case iSTB:
                writeByte(to_string(reg[readInt(reg[PC] + op1)]), reg[readInt(reg[PC] + op2)]);
                reg[PC] += 12;
                break;
                
            case LDB:
                reg[readInt(reg[PC] + op1)] = mem[readInt(reg[PC] + op2)];
                reg[PC] += 12;
                break;
                
            case iLDB:
                reg[readInt(reg[PC] + op1)] = mem[reg[readInt(reg[PC] + op2)]];
                reg[PC] += 12;
                break;
            case ADD:
                reg[readInt(reg[PC] + op1)] = reg[readInt(reg[PC] + op1)] + reg[readInt(reg[PC] + op2)];
                reg[PC] += 12;
                break;
            case ADI:
                reg[readInt(reg[PC] + op1)] += readInt(reg[PC] + op2);
                reg[PC] += 12;
                break;
            case SUB:
                reg[readInt(reg[PC] + op1)] = reg[readInt(reg[PC] + op1)] - reg[readInt(reg[PC] + op2)];
                reg[PC] += 12;
                break;
            case MUL:
                reg[readInt(reg[PC] + op1)] = reg[readInt(reg[PC] + op1)] * reg[readInt(reg[PC] + op2)];
                reg[PC] += 12;
                break;
            case DIV:
                reg[readInt(reg[PC] + op1)] = reg[readInt(reg[PC] + op1)] / reg[readInt(reg[PC] + op2)];
                reg[PC] += 12;
                break;
            case CMP:
                if (reg[readInt(reg[PC] + op1)] == reg[readInt(reg[PC] + op2)])
                    reg[readInt(reg[PC] + op1)] = 0;
                else if (reg[readInt(reg[PC] + op1)] > reg[readInt(reg[PC] + op2)])
                    reg[readInt(reg[PC] + op1)] = 1;
                else
                    reg[readInt(reg[PC] + op1)] = -1;
                reg[PC] += 12;
                break;
            case TRP:
                if (readInt(reg[PC] + op1) == 0) { // Stop machine
                    running = false;
                    reg[PC] += 12;
                    break;
                }
                if (readInt(reg[PC] + op1) == 1) {//write integer
                    cout << reg[R3];
                    reg[PC] += 12;
                    break;
                }
                if (readInt(reg[PC] + op1) == 2) {// read integer
                    cout << "read int" << endl;
                    reg[PC] += 4;
                }
                if (readInt(reg[PC] + op1) == 3) {// write single character
                    cout << (char)reg[R3];
                    reg[PC] += 12;
                    break;
                }
                if (readInt(reg[PC] + op1) == 4) {//read a sincle character
                    reg[3] = (int)getchar();
                    reg[PC] += 12;
                    break;
                }
                else
                    cout << "error with instructions at line " << TRP << endl;
                
                break;
            default:
                cout << "error with instructions " << reg[PC] << endl;
                exit(0);
                
        }
        
    }
    return 0;
}

