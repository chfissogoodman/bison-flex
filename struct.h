//
// Created by chen on 10/21/23.
//

#ifndef INC_10_41_STRUCT_H
#define INC_10_41_STRUCT_H

#include <unordered_map>
#include <string>
#include <vector>

namespace lib{
    struct db{

    };
    struct operating_conditions{
        std::string name;
        std::unordered_map<std::string, std::string> m;
    };
    struct library{
        std::string name;
        std::unordered_map<std::string, std::string> m;
        std::vector<operating_conditions> opc;
    };

}


#endif //INC_10_41_STRUCT_H
