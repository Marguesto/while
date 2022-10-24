%baseclass-preinclude <iostream>

%lsp-needed

%token T_PROGRAM
%token T_BEGIN
%token T_END
%token T_INTEGER 
%token T_BOOLEAN
%token T_SKIP
%token T_IF
%token T_THEN
%token T_ELSE
%token T_ENDIF
%token T_WHILE
%token T_DO
%token T_DONE
%token T_READ
%token T_WRITE
%token T_SEMICOLON
%token T_ASSIGN
%token T_OPEN
%token T_CLOSE
%token T_NUM
%token T_TRUE
%token T_FALSE
%token T_ID

%token T_DUPLICATE
%token T_LIST
%token T_APPEND

%token T_QUESTIONMARK
%token T_COLON

%token T_PARALLELIZATION
%token T_SOPEN
%token T_SCLOSE
%token T_COMMA
%token T_DOT

%left T_OR T_AND
%left T_EQ
%left T_LESS T_GR
%left T_ADD T_SUB
%left T_MUL T_DIV T_MOD
%nonassoc T_NOT

%right T_SHIFT
%right T_CONCAT

%start program

%%

program:
    T_PROGRAM T_ID declarations T_BEGIN statements T_END
    {
        std::cout << "start -> T_PROGRAM T_ID declarations T_BEGIN statements T_END" << std::endl;
    }
;

declarations:
    // empty
    {
        std::cout << "declarations -> epsilon" << std::endl;
    }
|
    declaration declarations
    {
        std::cout << "declarations -> declaration declarations" << std::endl;
    }
;

declaration:
    T_INTEGER T_ID T_SEMICOLON
    {
        std::cout << "declaration -> T_INTEGER T_ID T_SEMICOLON" << std::endl;
    }
|
    T_BOOLEAN T_ID T_SEMICOLON
    {
        std::cout << "declaration -> T_BOOLEAN T_ID T_SEMICOLON" << std::endl;
    }
|
    T_INTEGER multi_decl
    {
        std::cout << "declaration -> T_INTEGER multi_decl" << std::endl;
    }
|
    T_BOOLEAN multi_decl
    {
        std::cout << "declaration -> T_BOOLEAN multi_decl" << std::endl;
    }
|
    T_INTEGER T_LIST T_ID T_SEMICOLON
    {
        std::cout << "declarartion -> T_INTEGER T_LIST T_ID T_SEMICOLON" << std::endl;
    }
|
    T_BOOLEAN T_LIST T_ID T_SEMICOLON
    {
        std::cout << "declarartion -> T_BOOLEAN T_LIST T_ID T_SEMICOLON" << std::endl;
    }
|
    T_LESS tuple_types T_GR T_ID T_SEMICOLON
    {
        std::cout <<"T_LESS tuple_types T_GR T_ID T_SEMICOLON" << std::endl;
    }
;

tuple_types:
    type
    {
        std::cout << "tuple_types -> type" << std::endl;
    }
|
    type T_COMMA tuple_types
    {
        std::cout << "tuple_types -> types T_COMMA tuple_types" << std::endl;
    }
;

type:
    T_INTEGER
    {
        std::cout << "type -> T_INTEGER" << std::endl;
    }
|
    T_BOOLEAN
    {
        std::cout << "type -> T_BOOLEAN" << std::endl;
    }

;

multi_decl:
    T_ID T_COMMA T_ID T_SEMICOLON
    {
        std::cout << "multi_decl -> T_ID T_COMMA T_ID T_SEMICOLON" << std::endl;
    }
|
    T_ID T_COMMA multi_decl
    {
        std::cout << "multi_decl -> T_ID T_COMMA multi_decl" << std::endl;
    }
;

statements:
    statement
    {
        std::cout << "statements -> statement" << std::endl;
    }
|
    statement statements
    {
        std::cout << "statements -> statement statements" << std::endl;
    }
;

statement:
    T_SKIP T_SEMICOLON
    {
        std::cout << "statement -> T_SKIP T_SEMICOLON" << std::endl;
    }
|
    assignment
    {
        std::cout << "statement -> assignment" << std::endl;
    }
|
    read
    {
        std::cout << "statement -> read" << std::endl;
    }
|
    write
    {
        std::cout << "statement -> write" << std::endl;
    }
|
    branch
    {
        std::cout << "statement -> branch" << std::endl;
    }
|
    loop
    {
        std::cout << "statement -> loop" << std::endl;
    }
|

    T_DUPLICATE statement
    {
        std::cout << "statement -> T_DUPLICATE statement" << std::endl;
    }
|
    T_SOPEN statement_no_semicolon T_PARALLELIZATION statement_no_semicolon T_SCLOSE T_SEMICOLON
    {
        std::cout << "STATEMENT T_PARALLELIZATION STATEMENT" << std::endl;
    }
;

statement_no_semicolon:
    T_SKIP
    {
        std::cout << "statement -> T_SKIP T_SEMICOLON" << std::endl;
    }
|
    T_ID T_ASSIGN expression
    {
        std::cout << "statement_no_semicolon -> T_ID T_ASSIGN expression" << std::endl;
    }
|
    T_READ T_OPEN T_ID T_CLOSE
    {
        std::cout << "statement_no_semicolon -> T_READ T_OPEN T_ID T_CLOSE" << std::endl;
    }
|
    T_WRITE T_OPEN expression T_CLOSE
    {
        std::cout << "statement_no_semicolon -> T_WRITE T_OPEN expression T_CLOSE" << std::endl;
    }
|
    branch
    {
        std::cout << "statement_no_semicolon -> branch" << std::endl;
    }
|
    loop
    {
        std::cout << "statement_no_semicolon -> loop" << std::endl;
    }
|
    T_SOPEN statement_no_semicolon T_PARALLELIZATION statement_no_semicolon T_SCLOSE
    {
        std::cout << "statement_no_semicolon -> T_SOPEN statement_no_semicolon T_PARRA statement_no_semicolon T_SCLOSE" << std::endl;
    }
;

assignment:
    T_ID T_ASSIGN expression T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_ASSIGN expression T_SEMICOLON" << std::endl;
    }
|
    T_ID T_APPEND list_literal T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_ASSIGN list_literal T_SEMICOLON" << std::endl;
    }
|
    T_ID T_SOPEN T_NUM T_SCLOSE T_ASSIGN expression T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_SOPEN (NUM) T_SCLOSE exp ; " << std::endl;
    }
|
    T_ID T_DOT T_NUM T_ASSIGN expression T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_DOT T_NUM T_ASSIGN expression T_SEMICOLON" << std::endl;
    }
|
    simultan T_SEMICOLON
    {
        std::cout << "assignment -> simultan T_SEMICOLON" << std::endl;
    }
;

simultan:
    T_ID T_COMMA T_ID T_ASSIGN expression T_COMMA expression
    {
        std::cout << "simultan -> T_ID T_COMMA T_ID T_ASSIGN expression T_COMMA expression" << std::endl;
    }
|
    T_ID T_COMMA simultan T_COMMA expression
{

    std::cout << "simultan -> T_ID T_COMMA simultan T_COMMA expression" << std::endl;
}
;

list_literal:
    T_SOPEN list_values T_SCLOSE
    {
        std::cout << "list_literal -> T_SOPEN list_values T_SCLOSE" << std::endl;
    }
;

list_values:
    //empty
    {
        std::cout << "list_values -> epsilon" << std::endl;
    }
|
    expression
    {
        std::cout << "list_values -> expression" << std::endl;
    }
|
    multi_list_values
    {
        std::cout << "list_values -> multi_list_valuse" << std::endl;
    }
;

multi_list_values:
    expression T_COMMA expression
    {
        std::cout << "multi_list_values -> expression T_COMMA expression" << std::endl;
    }
|
    expression T_COMMA multi_list_values
    {
        std::cout << "multi_list_values -> expression T_COMMA expression" << std::endl;
    }
;

read:
    T_READ T_OPEN T_ID T_CLOSE T_SEMICOLON
    {
        std::cout << "read -> T_READ T_OPEN T_ID T_CLOSE T_SEMICOLON" << std::endl;
    }
|
    T_READ T_OPEN T_ID T_SOPEN T_NUM T_SCLOSE T_CLOSE T_SEMICOLON
    {
        std::cout << "T_READ T_OPEN T_ID T_SOPEN T_NUM T_SCLOSE T_CLOSE T_SEMICOLON" << std::endl;
    }
|
    T_READ T_OPEN T_ID T_DOT T_NUM T_CLOSE T_SEMICOLON
    {
        std::cout << "read -> T_READ T_OPEN T_ID T_DOT T_NUM T_CLOSE T_SEMICOLON" << std::endl;
    }
;

write:
    T_WRITE T_OPEN expression T_CLOSE T_SEMICOLON
    {
        std::cout << "write -> T_WRITE T_OPEN expression T_CLOSE T_SEMICOLON" << std::endl;
    }
;

branch:
    T_IF expression T_THEN statements T_ENDIF
    {
        std::cout << "branch -> T_IF expression T_THEN statements T_ENDIF" << std::endl;
    }
|
    T_IF expression T_THEN statements T_ELSE statements T_ENDIF
    {
        std::cout << "branch -> T_IF expression T_THEN statements T_ELSE statements T_ENDIF" << std::endl;
    }
;

loop:
    T_WHILE expression T_DO statements T_DONE
    {
        std::cout << "loop -> T_WHILE expression T_DO statements T_DONE" << std::endl;
    }
;

expression:
    T_NUM
    {
        std::cout << "expression -> T_NUM" << std::endl;
    }
|
    T_TRUE
    {
        std::cout << "expression -> T_TRUE" << std::endl;
    }
|
    T_FALSE
    {
        std::cout << "expression -> T_FALSE" << std::endl;
    }
|
    T_ID
    {
        std::cout << "expression -> T_ID" << std::endl;
    }
|
    expression T_ADD expression
    {
        std::cout << "expression -> expression T_ADD expression" << std::endl;
    }
|
    expression T_SUB expression
    {
        std::cout << "expression -> expression T_SUB expression" << std::endl;
    }
|
    expression T_MUL expression
    {
        std::cout << "expression -> expression T_MUL expression" << std::endl;
    }
|
    expression T_DIV expression
    {
        std::cout << "expression -> expression T_DIV expression" << std::endl;
    }
|
    expression T_MOD expression
    {
        std::cout << "expression -> expression T_MOD expression" << std::endl;
    }
|
    expression T_LESS expression
    {
        std::cout << "expression -> expression T_LESS expression" << std::endl;
    }
|
    expression T_GR expression
    {
        std::cout << "expression -> expression T_GR expression" << std::endl;
    }
|
    expression T_EQ expression
    {
        std::cout << "expression -> expression T_EQ expression" << std::endl;
    }
|
    expression T_AND expression
    {
        std::cout << "expression -> expression T_AND expression" << std::endl;
    }
|
    expression T_OR expression
    {
        std::cout << "expression -> expression T_OR expression" << std::endl;
    }
|
    T_NOT expression
    {
        std::cout << "expression -> T_NOT expression" << std::endl;
    }
|
    T_OPEN expression T_CLOSE
    {
        std::cout << "expression -> T_OPEN expression T_CLOSE" << std::endl;
    }
|
    expression T_SHIFT expression
    {
        std::cout << "expression -> expression T_SHIFT expression" << std::endl;
        
    }
|
    T_OPEN expression T_QUESTIONMARK expression T_COLON expression T_CLOSE
    {
        std::cout << "expression -> expression T_QUESTIONMARK expression T_COLON expression" << std::endl;
    }
|

    list_literal
    {
        std::cout << "assignment -> " << std::endl;
    }
|
    T_ID T_SOPEN T_NUM T_SCLOSE
    {
        std::cout << "ass -> T_ID T_SOPEN T_NUM T_SCLOSE" << std::endl;
    }
|
    expression T_CONCAT expression
    {
        std::cout << "ass -> expression T_CONCAT expression" << std::endl;
    }
|
    T_ID T_DOT T_NUM
    {
        std::cout << "expression -> T_ID T_DOT T_NUM" << std::endl;
    }
;
