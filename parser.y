%{
#include <iostream>
#include <string>
#include <vector>
#include <utility>
#include <cmath>
#include <FlexLexer.h>
#include <fstream>
%}

%require "3.7.4"
%language "C++"
%defines "Parser.hpp"
%output "Parser.cpp"

%define api.parser.class {Parser}
%define api.namespace {lib}
%define api.value.type variant
%parse-param {Scanner* scanner}

%code requires{
    #include "struct.h"
    namespace lib{
        class Scanner;
        struct library;
        struct operating_conditions;
        class db;
    }
}

%code{
    #include "Scanner.hpp"
    #include "struct.h"
    #define yylex(x) scanner->lex(x)
}


%token LIB OPC LBRACE RBRACE LPAREN RPAREN COL SEMICOL COMMA

%token <double> NUMBER
%token <std::string>  STRING IDENTIFIER

%nterm <lib::library*> library
%nterm <lib::operating_conditions*> operating_condition
%nterm <std::pair<std::string, std::string>> stuff
%nterm <std::unordered_map<std::string, std::string>*> stuffs
%nterm <std::vector<lib::operating_conditions*>*> operating_conditions


%code{
    namespace lib{
        db db_asd;
    }
}


%%

library : LIB LPAREN IDENTIFIER RPAREN LBRACE stuffs operating_conditions RBRACE {
            $$ = new lib::library;
            $$->name = $3;
            $$->m = *$6;
            std::cout <<  $$->name << std::endl;
            for(const auto& pair : $$->m){
                std::cout << pair.first << " : " << pair.second << std::endl;
            }

            /*
            for(const auto& opc : $7){
                std::cout <<  opc->name << std::endl;
                for(const auto& pair : opc->m){
                    std::cout << pair.first << " " << pair.second << std::endl;
                }
            }

            db_asd.lib_vec.emplace_bakc($$);
            */
          }
        ;


stuffs : stuff { $$ = new std::unordered_map<std::string, std::string>; $$->insert($1); }
       | stuffs stuff  {$$ = $1; $$->insert($2); }
       ;
operating_conditions : operating_condition { $$ = new std::vector<operating_conditions*>; $$->emplace_back($1); }
       | operating_conditions operating_condition  {$$ = $1; $$->emplace_back($2); }
       ;
stuff :  IDENTIFIER COL STRING SEMICOL { $$ = {$1, $3}; }
      |  IDENTIFIER COL NUMBER SEMICOL { $$ = {$1, std::to_string($3)}; }
      | IDENTIFIER COL IDENTIFIER SEMICOL  { $$ = {$1, $3}; }
      | IDENTIFIER LPAREN NUMBER COMMA IDENTIFIER RPAREN SEMICOL {$$ = {$1, std::to_string($3) + $5}; }
      | IDENTIFIER LPAREN IDENTIFIER RPAREN SEMICOL { $$ = {$1,$3}; }
      ;
operating_condition : OPC LPAREN IDENTIFIER RPAREN LBRACE stuffs RBRACE {
                        $$ = new lib::operating_conditions;
                        $$->name = $3;
                        $$->m = *$6;
                    }
                    ;


%%

void lib::Parser::error(const std::string& msg){
    std::cerr << msg << '\n';
}

