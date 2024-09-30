#include "calculator.hpp"

std::vector<std::string> Calculator::shunting_yard(std::vector<std::string> splited_expr)
{
    std::vector<std::string> sortie;
    std::stack<std::string> operateur;
    std::string token;
    std::regex pattern {"([-]?[0-9]+)(.[0-9]+)?"};

    for (int i = 0; i<splited_expr.size();i++)
    {
        if (std::regex_match(splited_expr[i],pattern))
        {
            sortie.push_back(splited_expr[i]);
        }
        else if (splited_expr[i] == "P")
        {
            sortie.push_back(std::to_string(M_PI));
        }
        else if (splited_expr[i] == "A")
        {
            sortie.push_back(this->resultat);
        }
        else if (splited_expr[i] == ")")
        {
            while (true)
            {
                token = operateur.top();
                operateur.pop();
                if (token == "(") break;
                sortie.push_back(token);
            }
        }
        else
        {
            if (operateur.empty() || (splited_expr[i]=="("))
            {
                operateur.push(splited_expr[i]);
            }
            else
            {
                if ((operateur.top()=="(") || ((this->precedence(operateur.top())) < (this->precedence(splited_expr[i]))) )
                {
                    operateur.push(splited_expr[i]);
                }
                else
                {
                    do {
                        sortie.push_back(operateur.top());
                        operateur.pop();
                    } while ((!operateur.empty()) && (operateur.top() != "(") && ((this->precedence(operateur.top())) >= (this->precedence(splited_expr[i]))));
                    operateur.push(splited_expr[i]);
                }
            }
        }
    }
    while (!operateur.empty())
    {
        sortie.push_back(operateur.top());
        operateur.pop();
    }
    return sortie;
}

std::vector<std::string> Calculator::split_expr(std::string const& expr)
{
    std::vector<std::string> result ;
    std::string cur {expr[0]};
    std::string token,n_token;
    std::regex alpha {"[a-z]+"};

    short type_a; // nbr:0, alpha:1, operat: 2, paren: 3, pi:4, ans:5 

    if (cur == "+" || cur == "-") result.push_back("0");
    type_a=this->type(cur);
    if ((type_a == 0) || (type_a >3))
    {
        n_token = expr[1];
        if ( expr.size()>1 && (this->type(n_token) == 1 || n_token == "(" || n_token == "P" || n_token == "A"))
        {
            if (cur != "") result.push_back(cur);
            type_a = 2;
            cur = "*";
        }
    }
    for (int i=1; i<expr.size(); i++)
    {
        token = expr[i];
        if (i != expr.size()-1) n_token = expr[i+1];
        if (((token == "-" ) || (token == "+")) && ((type_a != 0 && type_a < 4) || (expr[i-1] == '(')) && (this->type(n_token) != 2))
        {
            result.push_back(cur);
            result.push_back(token+"1");
            cur = "*";
            type_a = 2;
            continue;
        }

        if (type_a != this->type(token))
        {
            result.push_back(cur);
            cur = token;
        }
        else
        {
            if ((this->type(cur) >= 3)||(((std::regex_match(cur,alpha)) && (this->isFunc(cur)))))
            {
                result.push_back(cur);
                cur = "";
            }
            cur+=token;
        }

        type_a=this->type(token);

        if ((type_a == 0 || type_a >3) && (i<expr.size()-1) && (((this->type(n_token)) == 1) || n_token == "(" || n_token == "P" || n_token == "A"))
        {
            if (cur != "") result.push_back(cur);
            type_a = 2;
            cur = "*";
        }
        else if (type_a == 3 && token==")" && this->type(n_token) > 3 && (i<expr.size()-1))
        {
            if (cur != "") result.push_back(cur);
            type_a = 2;
            cur = "*";
        }
    }
    if (cur != "")
    {
        result.push_back(cur);
        cur = "";
    }
    return result;
}

short Calculator::precedence(std::string const& e)
{
    if ((e == "+") || (e == "-")) return 1;
    else if ((e == "*") || (e == "/") || (e == "%")) return 2;
    else if (e == "^") return 3;
    else if (e == "!") return 4;
    else return 5;
}

void Calculator::remove_space(std::string & expr)
{
    for (int i = 0; i<expr.length();i++)
    {
        if (std::isspace(static_cast<unsigned char>(expr[i])))
        {
            expr.erase(i,1);
            i--;
        }
    }
}

short Calculator::type(std::string c)
{
    std::vector<std::string> pattern {"[0-9.]+","[a-z]+","[\\$\\-+/*^%!]","[)(]","P","A"} ;
    std::regex r;
    int i;
    for (i=0; i<pattern.size();i++){
        r = pattern[i];
        if (std::regex_match(c,r)){
                break;
        }
    }
    return i;
}

bool Calculator::isFunc(std::string e)
{
    for (auto x: this->fonc_list){
        if (x == e)
        {
            return true;
        }
    }
    return false;
}

long double Calculator::convertToRadian(long double const& x)
{
    if (this->angle == 'D')
    {
        return x*M_PI/180;
    }
    else if (this->angle == 'G')
    {
        return x*M_PI/100;
    }
    else
    {
        return x;
    }
}

long double Calculator::convertFromRadian(long double const& x)
{
    if (this->angle == 'D')
    {
        return x*180/M_PI;
    }
    else if (this->angle == 'G')
    {
        return x*100/M_PI;
    }
    else
    {
        return x;
    }
}

std::string Calculator::calculate(std::string& expr)
{
    this -> remove_space(expr);
    std::string rep;
    std::string message {"Math error:"};
    std::vector<std::string> postfix_expr;
    try 
    {
        if (!(this->test_syntax(expr))) throw std::runtime_error("Erreur de syntaxe");
        postfix_expr= this->shunting_yard(this -> split_expr(expr));
    }
    catch (std::runtime_error const& e)
    {
        this -> state = 1;
        return e.what();
    }
    //tsisy
    try
    {
        rep = this -> eval_expr(postfix_expr);
    }

    catch (std::domain_error const& e)
    {
        this -> state = 2;
        return message + e.what();
    }
    catch (std::out_of_range const& e)
    {
        this -> state = 3;
        return "Math Error: Nombre trop grand";
    }
    catch (std::invalid_argument const& e)
    {
        this -> state = 1;
        return "Math Error";
    }
    catch (std::overflow_error const& e)
    {
        this -> state = 3;
        return "Math Error: Nombre trop grand";
    }
    catch (std::runtime_error const& e)
    {
        this -> state = 1;
        return e.what();
    }
    catch (std::exception const& e)
    {
        this -> state = 1;
        return "Erreur de syntaxe";
    }
    catch (...)
    {
        this -> state = 1;
        return "Erreur de syntaxe";
    }
    this -> state = 0;
    this -> resultat = rep;
    rep = this->formatOutput(rep);
    return rep;
}

void Calculator::setAngle(char a)
{
    this -> angle = a;
}

char Calculator::getAngle()
{
    return this -> angle;
}

char Calculator::getState()
{
    return this->state;
}

char Calculator::getMode()
{
    return this->mode;
}

void Calculator::setMode(char m)
{
    this -> mode = m;
}

bool Calculator::test_syntax(std::string & expr)
{
    //verify parenthesis
    int p{0};
    for (auto e: expr)
    {
        if (e == '(') p++;
        else if (e == ')') p--;
        if (p<0) return false; 
    }
    if (p!=0) return false; 

    //verify if parenthesis is empty
    std::regex pat {"\\([\\-+/*^%!$]*\\)"};
    if (std::regex_search(expr,pat)) return false; 

    //one or more + or - operator
    std::regex pat1 {"[+]{2,}"}, pat2 {"[\\-]{2,}"}, pat3 {"\\+\\-"}, pat4 {"\\-\\+"};
    int j;
    while (true)
    {
        j=0;
        if (std::regex_search(expr, pat1)) {
            expr = std::regex_replace(expr, pat1, "+");
            continue;
        }

        if (std::regex_search(expr, pat2)) {
           expr = this->replaceConsecutiveDashes(expr);
            continue;
        }

        if (std::regex_search(expr, pat3)) {
            expr = std::regex_replace(expr, pat3, "-");
            continue;
        }

        if (std::regex_search(expr, pat4)) {
            expr = std::regex_replace(expr, pat4, "-");
            continue;
        }

        break;
    }

    //verify operator
    std::string car {expr[0]};
    if ((this->type(car) == 2) && (expr[0] != '+') && (expr[0] != '-')) return false; 

    car = expr[expr.size()-1];
    pat = "[0-9A-Z)!]";
    if (!(std::regex_match(car,pat))) return false; 

    //verify operator without number
    pat = "([a-z]+)([\\-+/*^%!$]{1})";
    if (std::regex_search(expr,pat)) return false; 

    //verify number
    std::vector<std::string> pattern {"\\.[^\\d]+","[^\\d]+\\.","\\d+\\.\\d+(\\.\\d+)+"}; 
    for(auto x: pattern ){
        pat=x;
        if (std::regex_search(expr,pat)) return false; 
    }

    //function without parenthesis
    for (auto x: this->fonc_list)
    {
        pat = x+"([^(])";
        if (std::regex_search(expr,pat)) return false; 
    }

    //one or more others operators
    pat = "[/*^%$]{2,}" ;
    if (std::regex_search(expr,pat)) return false; 

    pat = "[\\-+/*^%!$][!]+";
    if (std::regex_search(expr,pat)) return false; 


    return true;
}

std::string Calculator::replaceConsecutiveDashes(std::string const& input) {
    std::string result;
    std::regex dashRegex("-+");
    std::sregex_iterator currentMatch(input.begin(), input.end(), dashRegex);
    std::sregex_iterator lastMatch;

    size_t lastPos = 0;

    while (currentMatch != lastMatch) {
        std::smatch match = *currentMatch;
        size_t matchPos = match.position();
        size_t matchLength = match.length();

        // Ajouter le texte avant les tirets
        result += input.substr(lastPos, matchPos - lastPos);
        
        // Remplacer par "+" ou "-" selon la longueur
        result += (matchLength % 2 == 0) ? "+" : "-";

        lastPos = matchPos + matchLength;
        currentMatch++;
    }

    // Ajouter le reste de la chaîne
    result += input.substr(lastPos);

    return result;
}

std::string Calculator::eval_expr(std::vector<std::string> conteneur)
{
    std::regex pattern("[0-9]+");
    std::regex pattern2("[a-z]+");  // $ -> yroot
    long double x,y,z;
    std::vector<std::string>conteneur2{conteneur.size(),""};
    for(int i=0 ; i < conteneur.size(); i++)
    {
        if(!std::regex_search(conteneur[i],pattern))
        {
            if(i > 1 && conteneur[i-2]=="" && !std::regex_search(conteneur[i],pattern2)) 
            {
                conteneur[i-2]=conteneur2[0];
                conteneur[0]="";
                i-=1;
            }
            else if(conteneur[i-2]!="" || conteneur[i-1]!="")
            {
                if(conteneur[i]=="+")
                {
                     x = std::stold(conteneur[i-2]);
                     y = std::stold(conteneur[i-1]);
                    z = x + y;
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="-")
                {
                     x = std::stold(conteneur[i-2]);
                     y = std::stold(conteneur[i-1]);
                    z = x - y;
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }   
                else if(conteneur[i]=="*")
                {
                     x = std::stold(conteneur[i-2]);
                     y = std::stold(conteneur[i-1]);
                    z = x * y;
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="/")
                {
                     x = std::stold(conteneur[i-2]);
                     y = std::stold(conteneur[i-1]);
                    if(y==0)
                    {
                        throw std::domain_error("Division par zéro");
                    }
                    z = x / y;
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="^")
                {
                    x = std::stold(conteneur[i-2]);
                    y = std::stold(conteneur[i-1]);
                    z = powl(x,y);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="%")
                {
                    x = std::stold(conteneur[i-2]);
                    y = std::stold(conteneur[i-1]);
                    if (y == 0L)
                    {
                        throw std::domain_error("Division par zéro");
                    }
                    z = static_cast<long long int>(x) % static_cast<long long int>(y);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="$")
                {
                    y = std::stold(conteneur[i-2]);
                    x = std::stold(conteneur[i-1]);
                    if (x<0)
                    {
                        throw std::domain_error("Racine d'un nombre negatif");
                    }
                    else if (y == 0)
                    {
                        throw std::domain_error("La racine par zero d'un nombre");
                    }
                    if (y == 2.0L){
                        z = sqrtl(x);
                    }
                    else
                    {
                        z = powl(x , (1/y));
                    }
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    conteneur[i-2]="";
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="!")
                {
                    x = std::stold(conteneur[i-1]);
                    if(x<0)
                    {
                        throw std::domain_error("Factorielle d'un nombre negatif");
                    }
                    z = tgammal(x+1);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="ln")
                {
                    x = std::stold(conteneur[i-1]);
                    if(x<=0)
                    {
                        throw std::domain_error("Logarithme d'un nombre nul ou negatif");
                    }
                    z = logl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3 && conteneur[i+1]!="")
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="log")
                {
                    x = std::stold(conteneur[i-1]);
                    if(x<=0)
                    {
                        throw std::domain_error("Logarithme d'un nombre nul ou negatif");
                    }
                    z = log10l(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3 && conteneur[i+1]!="")
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="exp")
                {
                    x = std::stold(conteneur[i-1]);
                    z = expl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3 && conteneur[i+1]!="")
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="sin")
                {
                    x = std::stold(conteneur[i-1]);
                    z = sinl(this->convertToRadian(x));
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                    else if(conteneur[i]=="asin")
                {
                    x = std::stold(conteneur[i-1]);
                    if (x<-1 || x > 1) throw std::domain_error("Fonction asin: Valeur en dehors de l'ensemble de definition");
                    z = this->convertFromRadian(asinl(x));
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="cos")
                {
                    x = std::stold(conteneur[i-1]);
                    z = cosl(this->convertToRadian(x));
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                    else if(conteneur[i]=="acos")
                {
                    x = std::stold(conteneur[i-1]);
                    if (x<-1 || x > 1) throw std::domain_error("Fonction acos: Valeur en dehors de l'ensemble de definition");
                    z = this->convertFromRadian(acosl(x));
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="tan")
                {
                    x = std::stold(conteneur[i-1]);
                    z = this->convertToRadian(x);
                    if (z==(M_PI/2))
                    {
                        throw std::domain_error("Fonction tan: Valeur en dehors de l'ensemble de definition");
                    }
                    z = tanl(z);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                        else if(conteneur[i]=="atan")
                {
                    x = std::stold(conteneur[i-1]);
                    z = this->convertFromRadian(atanl(x));
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="sh")
                {
                    x = std::stold(conteneur[i-1]);
                    z = sinhl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                    else if(conteneur[i]=="ash")
                {
                    x = std::stold(conteneur[i-1]);
                    z = asinhl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }

                else if(conteneur[i]=="ch")
                {
                    x = std::stold(conteneur[i-1]);
                    z = coshl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                    else if(conteneur[i]=="ach")
                {
                    x = std::stold(conteneur[i-1]);
                    if (x<1) throw std::domain_error("Fonction ach: Valeur en dehors de l'ensemble de definition");
                    z = coshl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="th")
                {
                    x = std::stold(conteneur[i-1]);
                    z = tanhl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="ath")
                {
                    x = std::stold(conteneur[i-1]);
                    if (x<-1 || x>1) throw std::domain_error("Fonction ath: Valeur en dehors de l'ensemble de definition");
                    z = atanhl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="abs")
                {
                    x = std::stold(conteneur[i-1]);
                    z = fabsl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="ceil")
                {
                    x = std::stold(conteneur[i-1]);
                    z = ceill(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="floor")
                {
                    x = std::stold(conteneur[i-1]);
                    z = floorl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else if(conteneur[i]=="round")
                {
                    x = std::stold(conteneur[i-1]);
                    z = roundl(x);
                    std::string a = std::to_string(z);
                    conteneur[i]=a;
                    conteneur[i-1]="";
                    if(conteneur.size()>3)
                    {
                        i--;
                    }
                    this->test(conteneur,conteneur2);
                }
                else
                {
                    throw std::invalid_argument("Fonction non reconnue");
                }
            }
        }
        else if(conteneur.size()==1)conteneur2[0]=conteneur[0];
    }
    return conteneur2[0];
}
void Calculator::test(std::vector<std::string>&tab,std::vector<std::string>&tab2)
{
    int j=0;
    for(int i=0 ; i < tab.size(); i++)
    {
        if(tab[i]!="")
        {
            tab2[j] = tab[i];
            j++;
        }
    }
}

std::string Calculator::formatOutput(std::string const& res)
{
    std::ostringstream s;
    std::string rep;
    if (this -> mode == 'F')
    {
        s << std::scientific<<std::showpos<<std::stold(res);
        return s.str();
    }
    else if (this -> mode == 'D')
    {
        long degres = static_cast<int> (std::stold(res)); 
        long double decimal_minutes = (std::stold(res) - degres)*60;
        long minutes = static_cast<int> (decimal_minutes);
        long double secondes = (decimal_minutes - minutes)*60;

        s <<fabsl(secondes);
        rep = std::to_string(degres) + "° " + std::to_string(fabsl(minutes)) + "' " + s.str()+"''";
        return rep;
    }
    else
    {;
        return res;
    }
}
