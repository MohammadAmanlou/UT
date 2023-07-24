#include <iostream>
using namespace std;

#define START_VAL_STRING "0"
#define START_VAL_CHAR '0'
#define REPLACE0_VAL "01"
#define SEC_REPLACE_VAL '1'
#define REPLACE1_VAL "10"

void solve(int currentLevel ,int levelLimit ,int selectedDigit ,string mainString){
    if(currentLevel<=levelLimit){
        string temp;
        for(int digit=0; digit<mainString.size() ; digit++){
            if(mainString[digit]== START_VAL_CHAR)
                temp+= REPLACE0_VAL;
            else if(mainString[digit]==SEC_REPLACE_VAL)
                temp+= REPLACE1_VAL;
        }
        mainString=temp;
        temp="";
        solve(currentLevel+1, levelLimit, selectedDigit, mainString);
    }
    else{
        cout << mainString[selectedDigit-1];
    }
}



int main(){
    string mainString=START_VAL_STRING;
    int levelLimit=0, selectedDigit=0, currentLevel=0;
    cin >> levelLimit >> selectedDigit;
    solve(currentLevel, levelLimit, selectedDigit, mainString);

    return 0;
}