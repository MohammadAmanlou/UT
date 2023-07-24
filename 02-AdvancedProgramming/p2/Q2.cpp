#include<iostream>
#include<string>
#include<vector>
#include <algorithm>
using namespace std;
 
#define SPACE ' '

void delete_spaces(string &input){
    input.erase(remove(input.begin(), input.end(), ' '), input.end());
}

string check_exist(string str,string search,int loc , int loc_of_str) {
    if (loc >= search.size())
        return str;
    for (int i = loc_of_str; i < str.size(); i++) {
        if (str[i] == search[loc]) {
            loc ++;
            str[i]= SPACE;
            str = check_exist(str , search , loc , i);
            break;
        }    
    }
    return str;
}

int compare(string str , string first , string second  ){
    string temp1 , temp2;
    temp2 = check_exist( str , first , 0 , 0);
    delete_spaces(temp2);
    temp1 = check_exist(str , second , 0 , 0);
    delete_spaces(temp1);
    if (temp2 == second && temp1==first){
        return 1;
    }
    else
        return 0;
}

int main() {
    string first;
    string second;
    string str;
    cin >> first >> second >> str;
    if (compare(str , first , second)){
        cout << "Interleaving" << endl;
    }
    else{
        cout << "Not Interleaving" << endl;
    }
    return 0;
}