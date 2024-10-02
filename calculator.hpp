#ifndef CALCULATOR_H
#define CALCULATOR_H

<<<<<<< HEAD
#include <string>
#include <vector>
=======
#ifndef M_PI
#include <numbers>
#define M_PI std::numbers::pi
#endif

#include <string>
>>>>>>> backend
#include <queue>
#include <stack>
#include <cmath>
#include <regex>
#include <iostream>
#include <algorithm>
#include <stdexcept>
#include <cassert>
#include <iomanip>

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
        std::string eval_expr(std::vector<std::string> const&);
        short precedence(std::string const& );
        bool test_syntax(std::string&);
        std::string replaceConsecutiveDashes(std::string const&);
        short type(std::string);
        bool isFunc(std::string);
        long double convertToRadian(long double const&);
        long double convertFromRadian(long double const&);
        std::string formatOutput(std::string const&);
        std::string toStr(long double const&);

    public:
        std::string calculate(std::string &);
        void setAngle(char);
        char getAngle();
        char getState ();
        char getMode();
        void setMode(char);
};

#endif 