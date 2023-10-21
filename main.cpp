#include "FlexLexer.h"
#include "Parser.hpp"
#include "Scanner.hpp"
#include "struct.h"

namespace lib{
    extern db db_asd;
}

int main(){
    std::ifstream infile("/home/chen/CLionProjects/10.41/test.txt");

    lib::Scanner scanner(infile, std::cerr);

    lib::Parser parser{&scanner};
    parser.parse();

    infile.close();
    return 0;

}