# TL13 Compiler
Compiler for the TL13 programming language. In development for Compiler Design
course.

The program makes use of Flex and Bison to implement lexical analysis and 
context-free grammar.

Written by: Britney Abner

## Make
The project is already compiled. The program located at ```bin/compiler```.  
<br/>
A Makefile is provided. To make, run ```make``` within the project directory

## Testing
The ```test``` directory provided 2 files for testing: ```test_success.txt```
and ```test_error.txt```.  
<br/>
To test for success, run:  
``` bash
./bin/compiler < test/test_success.txt
```
To test for error, run:  
``` bash
./bin/compiler < test/test_error.txt
```
