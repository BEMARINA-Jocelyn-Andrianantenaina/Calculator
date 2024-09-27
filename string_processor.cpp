#include "string_processor.h"

std::string processString(const std::string &input){
    std::string result = input;
    std::reverse(result.begin(), result.end()); // Exemple
    return result;
}
