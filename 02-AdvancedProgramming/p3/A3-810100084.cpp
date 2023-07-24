#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <vector>
#include <bits/stdc++.h>
#include <sstream>
#include <iterator>

using namespace std;

#define NOTFOUND "Not Found" 
#define TIMEDELIMITTER ':'
#define SPACE ' '

typedef struct conference{
    string name;
    int startTime;
    int endTime;
    vector<string> langueges;
}conference;

typedef struct translators {
    string name;
    int startTime;
    int endTime;
    vector<string> langueges;
}translator;

vector <translator> makeVectorOfTranslators(string translatorData , vector<translator> &translators){
    translator currentTranslator;
    string temp;
    string firstNumber;
    string secondNumber ;
    int hour;
    int minute ;
    int time ;
    stringstream sstream(translatorData);
    getline(sstream ,currentTranslator.name , SPACE );
    getline(sstream , firstNumber , TIMEDELIMITTER );
    getline(sstream , secondNumber , SPACE ) ;
    hour = stoi(firstNumber);
    minute = stoi (secondNumber) ;
    time = (hour*60) + minute ;
    currentTranslator.startTime = time ;
    getline(sstream , firstNumber , TIMEDELIMITTER );
    getline(sstream , secondNumber , SPACE ) ;
    hour = stoi(firstNumber);
    minute = stoi (secondNumber) ;
    time = (hour*60) + minute ;
    currentTranslator.endTime = time ;
    while (getline(sstream, temp, SPACE)){
        currentTranslator.langueges.push_back(temp);
    }
    translators.push_back(currentTranslator);
    return translators;
}

vector <translator> readTranslator(const string fileName){
    ifstream file(fileName) ;
    if(!file) { // file couldn't be opened
        cerr << "Error: file could not be opened" << endl;
        exit(1);
    }
    vector<translator> translators;
    string stringNumberOfTranslators;
    string translatorData;
    getline(file ,  stringNumberOfTranslators);
    int numberOfTranslators = stoi(stringNumberOfTranslators);
    for (int i =0 ; i< numberOfTranslators ; i++){
        getline(file , translatorData );
        translators = makeVectorOfTranslators(translatorData ,translators );
    }
    return translators ; 
}

vector<conference> makeVectorOfConferences(string conferenceData , vector<conference> &conferences){
    conference currentConference;
    string temp;
    string firstNumber;
    string secondNumber ;
    int hour;
    int minute ;
    int time ;
    stringstream sstream(conferenceData);
    getline(sstream ,currentConference.name , SPACE );
    getline(sstream , firstNumber , TIMEDELIMITTER );
    getline(sstream , secondNumber , SPACE ) ;
    hour = stoi(firstNumber);
    minute = stoi (secondNumber) ;
    time = (hour*60) + minute ;
    currentConference.startTime = time ;
    getline(sstream , firstNumber , TIMEDELIMITTER );
    getline(sstream , secondNumber , SPACE ) ;
    hour = stoi(firstNumber);
    minute = stoi (secondNumber) ;
    time = (hour*60) + minute ;
    currentConference.endTime = time ;
    while (getline(sstream, temp, SPACE)){
        currentConference.langueges.push_back(temp);
    }
    conferences.push_back(currentConference);
    return conferences;
}

vector<conference> readConference(const string fileName ){
    ifstream file (fileName);
    if(!file) { // file couldn't be opened
        cerr << "Error: file could not be opened" << endl;
        exit(1);
    }
    vector<conference> conferences;
    string stringNumberOfTranslators;
    getline(file ,  stringNumberOfTranslators);
    int numberOfTranslator = stoi(stringNumberOfTranslators);
    string temp;
    for (int i =0 ; i<numberOfTranslator ; i++){
        getline(file , temp );
    }
    string stringNumberOfConferences;
    string conferenceData;
    getline(file ,  stringNumberOfConferences);
    int numberOfConferences = stoi(stringNumberOfConferences);
    for (int i =0 ; i<numberOfConferences ; i++){
        getline(file , conferenceData );
        conferences = makeVectorOfConferences(conferenceData , conferences);
    }
    return conferences;
    /** read conferences and make a vector of conferences*/
}

vector <string> sortVec2Acording1( vector <int> languegeTranslatorNumbers ,vector<string> langueges ){
    //vector <int> languegeTranslatorNumbersCopy = languegeTranslatorNumbers;
    int integerTemp ;
    string stringTemp;
    for (int j=0 ; j<languegeTranslatorNumbers.size() ; j++){
        for (int i=languegeTranslatorNumbers.size()-1 ; i >= 0 ; i--){
            if (languegeTranslatorNumbers[i] < languegeTranslatorNumbers[i-1]){
                integerTemp = languegeTranslatorNumbers[i-1];
                languegeTranslatorNumbers[i-1] = languegeTranslatorNumbers[i];
                languegeTranslatorNumbers[i] = integerTemp;
                stringTemp = langueges[i-1];
                langueges[i-1] = langueges[i] ; 
                langueges[i]=stringTemp;
            }
        }
    }
    return langueges;
}

vector<string> findBestLanguege(conference currentConference , vector<translator> &translators){
    /* make a vector of langueges According to its order*/
    string currentLanguege;
    vector <int> languegeTranslatorNumbers ;
    for (int i=0 ; i< currentConference.langueges.size() ; i++){
        int numberOfTranslators = 0 ;
        currentLanguege = currentConference.langueges[i];
        for (int j=0 ; j < translators.size() ; j++){
            if (find(translators[j].langueges.begin(), translators[j].langueges.end(), currentLanguege) != translators[j].langueges.end() )
                numberOfTranslators ++;
        }
        languegeTranslatorNumbers.push_back(numberOfTranslators);
    }
    currentConference.langueges = sortVec2Acording1(languegeTranslatorNumbers ,  currentConference.langueges);
    return (currentConference.langueges) ;
}

int checkTime (translator &currentTranslator , conference currentConference){
    if((currentConference.startTime >= currentTranslator.startTime ) &&(currentConference.endTime <= currentTranslator.endTime)) {
        return 1;
    }
    else{
        return 0;
    }
}

int haveLanguege(translator currentTranslator , string languege){
     if(find(currentTranslator.langueges.begin(), currentTranslator.langueges.end(), languege) 
     != currentTranslator.langueges.end()){
         return 1;
     }
     else
        return 0;
}

int compareAlphabet(string first , string second){
    if (0 <= strcmp(first.c_str() , second.c_str()))
        return 0;
    else 
        return 1;

}

void updateTime(translator &trans , conference confer , vector<translator> &translators){
    for (int i=0 ; i<translators.size() ; i++){
        if (trans.name == translators[i].name){
            translators[i].startTime = confer.endTime;
            break;
        }
    }
}

vector<string> findBestTranslator(string languege , vector<translator> &translators , conference currentConference){
    vector <translator> goodTranslators;
    vector <string> output;
    for (int i=0 ; i<translators.size() ; i++){
        if (haveLanguege(translators[i] , languege )){
            if (checkTime(translators[i] , currentConference)){
                goodTranslators.push_back(translators[i]);
            } 
        }
    }
    translator notFound;
    if (goodTranslators.size()==0){
        notFound.name = NOTFOUND;
        goodTranslators.push_back(notFound);
        output.push_back(goodTranslators[0].name);
        output.push_back(languege);

    }
    else if (goodTranslators.size()==1){
        updateTime(goodTranslators[0] , currentConference , translators);
        output.push_back(goodTranslators[0].name);
        output.push_back(languege);
    }
    else {
        for (int j=0 ; j<goodTranslators.size() ; j++){
            for (int i = goodTranslators.size()-1 ; i > 0; i--){
                if (goodTranslators[i].langueges.size() < goodTranslators[i-1].langueges.size() ){
                    translator temp = goodTranslators[i-1];
                    goodTranslators[i-1] = goodTranslators[i];
                    goodTranslators[i] = temp ;
                }
            }
        }
        if (goodTranslators[0].langueges.size() == goodTranslators[1].langueges.size()){
            for(int i=1 ; i<goodTranslators.size() ; i++){
                if(goodTranslators[0].langueges.size() == goodTranslators[i].langueges.size()) {
                    if (compareAlphabet(goodTranslators[0].name , goodTranslators[i].name) == 1){
                        continue;
                    }
                    else{
                       goodTranslators[0] = goodTranslators[i];
                    }
                }
            }
        updateTime(goodTranslators[0] , currentConference , translators);
        output.push_back(goodTranslators[0].name);
        output.push_back(languege);
        }
        else {
            updateTime(goodTranslators[0] , currentConference , translators);
            output.push_back(goodTranslators[0].name);
            output.push_back(languege);
        }
    }
    return output ;
    /* find best translator for each languege and return a vector include languege name and its translator*/
}

void showResult(vector<vector<vector<string>>> result , vector<conference> conferences){
    for (int i=0 ; i<conferences.size(); i++){
        cout << conferences[i].name  << endl;
        for (int z=0 ; z < conferences[i].langueges.size() ; z++){
            for (int j=0 ; j < result[i].size() ; j++){
                if (conferences[i].langueges[z] == result[i][j][1] ){
                    cout << result[i][j][1] << ": " << result[i][j][0] << endl ;
                }
            }     
        }
    }
}

int findNumberOfVectorMembers(vector <conference> vector){
    int result;
    result = vector.size();
    return result ;
}

void displayVector(const vector<string> vect){
    for (int i(0); i != vect.size(); ++i)
        cout << "\n" << vect[i];
    return ;
}

vector<vector<vector<string>>> findTranslator(vector <conference> &conferences , vector <translator> &translators ){
    int numberOfConferences ;
    numberOfConferences = conferences.size();
    int numberOfLangueges;
    vector <string> orderedLangueges;
    vector<vector<vector<string>>> result ;
    for (int i =0 ; i< conferences.size() ; i++){
        vector<vector<string>> allLanguege ;
        orderedLangueges = findBestLanguege(conferences[i] , translators);
        numberOfLangueges = orderedLangueges.size();
        for (int j=0 ; j<numberOfLangueges ; j++){
            vector<string> langugeAndItsTranslatorName;
            langugeAndItsTranslatorName = findBestTranslator(orderedLangueges[j] , translators , conferences[i]);
            allLanguege.push_back(langugeAndItsTranslatorName);
            langugeAndItsTranslatorName.clear();
        }
        result.push_back(allLanguege);
        allLanguege.clear();
    }
    return result;
}

 int main (int argc , char * argv[]){
    string fileName = argv[1];
    vector <translator> translators;
    vector <conference> conferences;
    vector<vector<vector<string>>> result ;
    translators = readTranslator(fileName);
    conferences = readConference(fileName);
    result = findTranslator(conferences , translators);
    showResult(result , conferences);
 }