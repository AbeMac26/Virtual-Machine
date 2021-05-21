//  Project 1
//
//  Created by Abel Macias on 2/4/21.
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
map <string,int> symbol_Table;
char mem[MEM_SIZE];
int pcounter=0;
int line_cnt=0;

// Enumeration for Register 1 - 7
enum{
    R0 = 0,
    R1,
    R2,
    R3,
    R4,
    R5,
    R6,
    R7,
    PC,
    RegSize
};

//Enumeration for Operator codes
enum{
    MOV = 7,
    LDR = 10,
    LDB = 12,
    ADD = 13,
    SUB = 15,
    MUL = 16,
    DIV = 17,
    TRP = 21,
};

// isOpdCode
// Parameter : String
// Retunr: bool
// This function will check if the string Operator code (op) is valid.
bool isInstruction(string op){
    if("MOV" == op){
        return true;
    }
    if("LDR" == op){
        return true;
    }
    if("LDB" == op){
        return true;
    }
    if("ADD" == op){
        return true;
    }
    if("SUB" == op){
        return true;
    }
    if("MUL" ==op){
        return true;
    }
    if("DIV" == op){
        return true;
    }
    if("TRP" == op){
        return true;
    }
    else
        return false;
};

// opCodeString
// Parameter : string
// Retunr: string
// This function will convert the enureration Operator to string.
string instType(string op){
    if("MOV" == op){
        return to_string(MOV);
    }
    if("LDR" == op){
        return to_string(LDR);
    }
    if("LDB" == op){
        return to_string(LDB);
    }
    if("ADD" == op){
        return to_string(ADD);
    }
    if("SUB" == op){
        return to_string(SUB);
    }
    if("MUL" ==op){
        return to_string(MUL);
    }
    if("DIV" == op){
        return to_string(DIV);
    }
    if("TRP" == op){
        return to_string(TRP);
    }
    else
        return "invalid";
};

// operandString
// Parameter : string
// Retunr: string
// This function will convert the enureration Registers to string.
string operandType(string operand){
    if("R0" == operand){
        return to_string(R0);
    }
    if("R1" == operand){
        return to_string(R1);
    }
    if("R2" == operand){
        return to_string(R2);
    }
    if("R3" == operand){
        return to_string(R3);
    }
    if("R4" == operand){
        return to_string(R4);
    }
    if("R5" == operand){
        return to_string(R5);
    }
    if("R6" == operand){
        return to_string(R6);
    }
    if("R7" == operand){
        return to_string(R7);
    }
    // Trap MMI codes
    if("0" == operand)
        return "0";
    if("1" == operand)
        return "1";
    if("2" == operand)
        return "2";
    if("3" == operand)
        return "3";
    else
        for (auto itr = symbol_Table.begin(); itr != symbol_Table.end();itr++)
            if(operand == itr ->first)
                return to_string(itr->second);
    
    return "invalid";
};

// write
// Parameters: string and int
// Return: void
// Write 4 BYTE integer operand value to memory address
void writeInt(string value, int location){
    try{
        if(value != ""|| location >= MEM_SIZE){
            char temp[4];
            strcpy_s(temp, value.c_str());
            int *ii = (int*)temp;
            int *size = (int*)(mem+location);
            *size = *ii;
        }
    }
    catch(string value){
        cerr << "Unable to write interger " << value << " to memory location " << location << endl;
    }
};

// writeByt
// Parameters: string and int
// Return: void
// Write one BYTE character operand value to memory address by conversting
// the string to char. If the value is NULL error message will printed.
void writeByte(string value, int location){
    try{
        if(value != ""|| location >= MEM_SIZE)
            mem[location]= (char)(strtol(value.c_str(),NULL,10));
        else
            throw value;
    }
    catch(string value){
        cerr << "Unable to write byte " << value << " to memory location " << location << endl;
    }
};

// isDirective
// Parameter: string
// Return: bool
// Check if string is type .INT or .BYT derictive
bool isDirective(string s){
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
int createTable(string label, string dir, int address){
    if (dir == ".INT"){
        symbol_Table.insert({label, address});
        return 4;
    }
    else if (dir == ".BYT"){
        symbol_Table.insert({label, address});
        return 1;
    }
    else if(isInstruction(dir))
        symbol_Table.insert({label,address});
    return 0;
};

// storeToMem
// Parameters: string, string, int
// Return: int
// Will check the type of instruction. If its a
// derective type .INT or .BYTE and write to memory address or
// If its a operator and operand(s) it will store to memory
// and return the integer value of bytes used.
int storeToMem(string dir, string op, int location){
    if (dir == ".INT"){
        writeInt(op, location);
        return 4;
    }
    else if (dir == ".BYT"){
        writeByte(op, location);
        return 1;
    }
    else if(isInstruction(dir)){
        string s = instType(op);
        if (s == "invalid"){
            s = operandType(op);
            if(s == "invalid"){
                cerr << "error with operand " << op << " at line #" << line_cnt << endl;
                exit(0);
            }
            else
                writeInt(s,location);
        }
        else{
            writeInt(s,location);
        }
        return 4;
    }
    else{
        cerr << "error with operand " << op << " at line #" << line_cnt << endl;
        exit(0);
    }
    return 0;
};

void ReadTextFile(string fileName, bool &pass1) {
    string line;
    bool eRRor = false;
    //string fileName, line;
    //cout << "Enter file name (i.e. test.tx): ";
    //cin >> fileName;
    fstream file(fileName);
    int count =0;
    
    if (file.is_open()) {
        while (file.good()) {
            getline(file, line); //read lines
            line_cnt ++;
            string str = line.substr(0, line.find("#",0));
            regex re(R"([\s|\t|\']+)"); //breaks the string up to tokens
            vector<string> out(sregex_token_iterator(str.begin(), str.end(), re, -1), sregex_token_iterator()); //stores tokens in vector
            out.erase(remove_if(out.begin(), out.end(),[](string const& s){return s.size()==0;}), out.end());
            
            /* Firs Pass: will read file and creadt Sympbol Table */
            if (pass1){
                if (!out.empty() && out.size() >= 2){
                    if(isDirective(out.at(0))){//no label
                        cout << "error at line #" << line_cnt << " " << out.at(0) << " " << out.at(1) << endl;
                        eRRor = true;
                        //count += createTable(to_string(count), out.at(0),count);
                        //pcounter = count;
                    }
                    else if(isDirective(out.at(1))){
                        count += createTable(out.at(0), out.at(1),count);
                        pcounter = count;
                    }
                    else if(!(isInstruction(out.at(0)))){
                        count += createTable(out.at(0), out.at(1),count);
                    }
                }
            }
            /* Second pass: Will store instrcution to memory */
            else{
                if (!out.empty() && out.size() >= 2){
                    if(isDirective(out.at(0)))//no Label on Directive
                        count+=storeToMem(out.at(0), out.at(1), count);
                    else if(isDirective(out.at(1))){
                        count+=storeToMem(out.at(1), out.at(2), count);
                    }
                    else {
                        if(isInstruction(out.at(0))){//no label on instruction
                            int j =0;
                            for(j=0; j<out.size();j++)
                                count+=storeToMem(out.at(0),out.at(j), count);
                            if(3-j != 0)
                                count+=(4*(3-j));
                        }
                        else if (isInstruction(out.at(1))){//maybe a label or space
                            int n =0;
                            for(n=1; n<out.size();n++)
                                count+=storeToMem(out.at(1),out.at(n), count);
                            if((3+1)-n != 0)
                                count+=(4*((3+1)-n));
                        }
                        else
                            cout << "Instruction at line " << line_cnt << " does not exist." << endl;
                    }
                }
            }
            if (file.peek() == EOF) {
                break;
            }
        }
        
    }
    if (!file.eof() && file.fail())
        cout << "error reading file " << fileName << endl;
    
    file.close();
    if(eRRor){
        pass1 = true;
        cerr << "Pass 1 failed" << endl;
    }
    else{
        pass1 =false;
        line_cnt = 0;
    }
    
};

int read(int location){
    char *in = (mem+location);
    char*t;
    return (int)(strtol(in,&t,10) );
};

int readMem(int location){
    char *cc = (mem+location);
    return atoi(cc);
};

int main(int argc, const char * argv[]) {
    bool pass1 = true;
    int reg[RegSize];
    reg[PC] = -1;
    bool running = true;
    if (argc < 2) {
        cerr << "Usage: vm.exe <File Name>" << endl;
    }
    ReadTextFile(argv[1], pass1);
    if(!pass1){
        reg[PC] = pcounter;
        ReadTextFile(argv[1], pass1);
        
        while (running){
            int IR = readMem(reg[PC]);
            switch (IR) {
                case MOV:
                    reg[readMem(reg[PC]+4)] = reg[readMem(reg[PC]+8)];
                    reg[PC]+=12;
                    break;
                case LDR:
                    reg[readMem(reg[PC]+4)] = read(readMem(reg[PC]+8));
                    reg[PC]+=12;
                    break;
                case LDB:
                    reg[readMem(reg[PC]+4)] = mem[readMem(reg[PC]+8)];
                    reg[PC]+=12;
                    break;
                case ADD:
                    reg[readMem(reg[PC]+4)] = reg[readMem(reg[PC]+4)]  + reg[readMem(reg[PC]+8)] ;
                    reg[PC]+=12;
                    break;
                case SUB:
                    reg[readMem(reg[PC]+4)] = reg[readMem(reg[PC]+4)] - reg[readMem(reg[PC]+8)];
                    reg[PC]+=12;
                    break;
                case MUL:
                    reg[readMem(reg[PC]+4)] = reg[readMem(reg[PC]+4)] * reg[readMem(reg[PC]+8)];
                    reg[PC]+=12;
                    break;
                case DIV:
                    reg[readMem(reg[PC]+4)] = reg[readMem(reg[PC]+4)] / reg[readMem(reg[PC]+8)];
                    reg[PC]+=12;
                    break;
                case TRP:
                    if (readMem(reg[PC]+4) == 0){ // Stop machine
                        running = false;
                        reg[PC]+=12;
                        break;
                    }
                    if (readMem(reg[PC]+4) == 1) {//write integer
                        cout << reg[3] << " ";
                        reg[PC]+=12;
                        break;
                    }
                    if (readMem(reg[PC]+4) == 2){// read integer
                        cout<< "read int" << endl;
                    }
                    if (readMem(reg[PC]+4) == 3){// write single character
                        
                        cout << (char) reg[R3];
                        
                        reg[PC]+=12;
                        break;
                    }
                    if (readMem(reg[PC]+4) == 4){//read a sincle character
                        //cout<< "rading single char" << endl;
                        reg[PC]+=12;
                        break;
                    }
                    else
                        cout << "error with instructions at line " << line_cnt << endl;
                    
                    break;
                default:
                    reg[PC]++;
                    break;
                    
            }
            
        }
    }
    return 0;
}

