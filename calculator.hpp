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
<<<<<<< HEAD
#include <stdexcept>
=======
#include <iostream>
#include <algorithm>
#include <stdexcept>
#include <cassert>
#include <iomanip>
>>>>>>> backend

class Calculator
{
    private:
        char angle {'D'};
        int state {0};
        char mode {'N'};
        std::string resultat {"0"};
        std::vector<std::string> fonc_list {"log","ln","sin","cos","tan","asin","acos","atan","sh","ch","th","ath","ach","ash","exp","\\$","ceil","abs","floor","round"};
<<<<<<< HEAD
        
        std::vector<std::string> shunting_yard(std::vector<std::string>);
        std::vector<std::string> split_expr(std::string const&);
        std::string eval_expr(std::vector<std::string>);
        short precedence(std::string const& );
        void remove_space(std::string &);
=======
        std::vector<std::string> shunting_yard(std::vector<std::string>);
        std::vector<std::string> split_expr(std::string const&);
        std::string eval_expr(std::vector<std::string> const&);
        short precedence(std::string const& );
>>>>>>> backend
        bool test_syntax(std::string&);
        std::string replaceConsecutiveDashes(std::string const&);
        short type(std::string);
        bool isFunc(std::string);
        long double convertToRadian(long double const&);
        long double convertFromRadian(long double const&);
<<<<<<< HEAD
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
=======
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

>>>>>>> backend
#endif 