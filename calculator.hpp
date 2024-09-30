#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <string>
#include <vector>
#include <queue>
#include <stack>
#include <cmath>
#include <regex>
#include <stdexcept>

class Calculator
{
    private:
        char angle {'D'};
        int state {0};
        char mode {'N'};
        std::string resultat {"0"};
        std::vector<std::string> fonc_list {"log","ln","sin","cos","tan","asin","acos","atan","sh","ch","th","ath","ach","ash","exp","\\$","ceil","abs","floor","round"};
        
        std::vector<std::string> shunting_yard(std::vector<std::string>);
        std::vector<std::string> split_expr(std::string const&);
        std::string eval_expr(std::vector<std::string>);
        short precedence(std::string const& );
        void remove_space(std::string &);
        bool test_syntax(std::string&);
        std::string replaceConsecutiveDashes(std::string const&);
        short type(std::string);
        bool isFunc(std::string);
        long double convertToRadian(long double const&);
        long double convertFromRadian(long double const&);
        static void test(std::vector<std::string>&,std::vector<std::string>&);
        std::string formatOutput(std::string const&);

    public:
        std::string calculate(std::string &);

        void setAngle(char);
        char getAngle();

        char getState ();

        char getMode();
        void setMode(char);

};

enum angle{ radian,degree,grades };
enum mode {dms, norm, fe};
#endif 