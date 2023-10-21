//
// Created by chen on 10/21/23.
//

#ifndef INC_10_41_SCANNER_HPP
#define INC_10_41_SCANNER_HPP

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <cassert>
#include <limits>

namespace lib{
    class Scanner : public yyFlexLexer{
    public:
        Scanner(std::istream &arg_yyin, std::ostream &arg_yyout) : yyFlexLexer(arg_yyin, arg_yyout){}
        Scanner(std::istream *arg_yyin = nullptr, std::ostream *arg_yyout = nullptr) : yyFlexLexer(arg_yyin, arg_yyout){}
        int lex(Parser::semantic_type *yylval);
    };
}

#endif //INC_10_41_SCANNER_HPP
