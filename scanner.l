%{
#include "Parser.hpp" // 包含Bison生成的头文件
#include "Scanner.hpp"
#include <string>
#include <iostream>
#include <fstream>
#define YY_DECL int lib::Scanner::lex(lib::Parser::semantic_type *yylval)
#define yypanic(X) (void)(X)
%}

%option noyywrap c++ noyylineno nodefault outfile="Scanner.cpp"

dseq    ([[:digit:]]+)
dseq_opt ({dseq}?)
frac    (({dseq_opt}"."{dseq}) | {dseq}".")
exp     ([eE][+-]?{dseq})
exp_opt ({exp}?)

integer ({dseq})
float   (({frac}{exp_opt})|({dseq}{exp}))
identifier ([a-zA-Z_][a-zA-Z0-9_.]*)
number ([0-9]+(\.[0-9]+)?)

%%
library                     {  return Parser::token::LIB; }
operating_conditions        {  return Parser::token::OPC; }
[ \t\r\n]                   ; // 忽略空格和换行
"{"                         { return Parser::token::LBRACE; }
"}"                         { return Parser::token::RBRACE; }
"("                         { return Parser::token::LPAREN; }
")"                         { return Parser::token::RPAREN; }
","                         { return Parser::token::COMMA; }
":"                         { return Parser::token::COL; }
";"                         { return Parser::token::SEMICOL; }
{number}                    { yylval->emplace<double>(atof(YYText())); return Parser::token::NUMBER; }
\"[^\"]*\"                  { yylval->emplace<std::string>(YYText()); return Parser::token::STRING; }
{identifier}                { yylval->emplace<std::string>(YYText()); return Parser::token::IDENTIFIER; }
.                           { }
%%

int yyFlexLexer::yylex(){
    throw std::runtime_error("error");
}