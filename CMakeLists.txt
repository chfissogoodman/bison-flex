cmake_minimum_required(VERSION 3.26)
project(10_41)

set(CMAKE_CXX_STANDARD 17)

add_executable(10_41 main.cpp
        Scanner.hpp
        Parser.hpp
        Parser.cpp
        Scanner.cpp
        struct.h
        parser_db.h)
