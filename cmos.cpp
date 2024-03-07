#include <fstream>
#include <cctype>
#include <vector>
#include <iostream>

using namespace std;

int main()
{
    ifstream inStr;
    inStr.open("tokens.txt");
    vector<vector<string> > tokens;
    string tmp;
    vector<string> tmpVec;
    while (inStr >> tmp)
    {
        if (isdigit(tmp[0])){
            tmpVec.push_back(tmp);
        }
        else if (!isdigit(tmp[0])){
            tokens.push_back(tmpVec);
            tmpVec.clear();
        }
    }
    tokens.push_back(tmpVec);

}