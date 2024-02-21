# Lexical Analyzer
Lexical Analyzer for the TL13 programming language. Written for Compiler Design course project 1a.

Lexical Analyzer uses flex to generate a C file that reads TL13 code and prints the token and value pairs of the code.

Written by: Britney Abner

## Make
The project is already made. To make again using the provided makefile, run the following:
```bash
make
```

To make without the makefile, use:
```
flex src/lexical_analyzer.l
gcc lex.yy.c -lfl -o a.out
```

## Testing
The file ```test.txt``` is provided for testing. To test, run the following:
```bash
./a.out < test.txt
