// Mohammad Amanlou :)

// including libraries
#include <iostream>
#include <vector>
#include <string>
using namespace std;

// defines for MAGIC NUMBERs
#define START_OF_DAY_HOUR 12 
#define START_OF_DAY_MINUTE 0
#define MINUTES_OF_AN_HOUR 60
#define LAST_HOUR_OF_DAY 8
#define DELIMITER "#"

// define function to add time to meeting notebook & tokenize data from string
void add_meeting_time(vector<vector<int>> &MeetingTime, string command) {
    int HourStart, MinuteStart, HourEnd, MinuteEnd;
    HourStart = stoi(command.substr(0, 2));
    MinuteStart = stoi(command.substr(3, 2));
    HourEnd = stoi(command.substr(6, 2));
    MinuteEnd = stoi(command.substr(9, 2));
    vector<int> EndStart;
    int StratTime = (HourStart - START_OF_DAY_HOUR) * MINUTES_OF_AN_HOUR + (MinuteStart - START_OF_DAY_MINUTE);
    int EndTime = (HourEnd - START_OF_DAY_HOUR) * MINUTES_OF_AN_HOUR + (MinuteEnd - START_OF_DAY_MINUTE);
    EndStart.push_back(StratTime);
    EndStart.push_back(EndTime);
    MeetingTime.push_back(EndStart);
}

 // put zero before if number is less than 10
string put_0_if_less_10(int input) {
    string output;
    if (input < 10) {
        output = ("0" + to_string(input)) ;
    }
    else {
        output = to_string(input);
    }
    return output;
}

// main part
int main()
{
    string command;
    vector<int> Time;
    vector<vector<int>> Schedule;
    vector<vector<int>> MeetingTime;

    //getting meeting time
    while (1) {
        cin >> command;
        if (command != DELIMITER)
            add_meeting_time(MeetingTime, command);
        else
            break;
    }

    //adding last hiur of day
    Time.push_back(LAST_HOUR_OF_DAY * MINUTES_OF_AN_HOUR);
    Time.push_back(LAST_HOUR_OF_DAY * MINUTES_OF_AN_HOUR);
    MeetingTime.push_back(Time);
    Time.clear();
    
    //getting work time
    int TimeOfWork, NumberOfWork, OldNumberOfWork=1;
    int CurrentTime=0 , MeetingTimeHead=0;
    while (cin >> TimeOfWork >> NumberOfWork){
        // checking if we have a new time part
        if(NumberOfWork!=OldNumberOfWork){
            CurrentTime = MeetingTime[MeetingTimeHead][1];
            MeetingTimeHead++;
            OldNumberOfWork=NumberOfWork;
        }
        // add time part
        while (CurrentTime+TimeOfWork > MeetingTime[MeetingTimeHead][0]){
            CurrentTime = MeetingTime[MeetingTimeHead][1];
            MeetingTimeHead ++;
        }
        Time.push_back(CurrentTime);
        Time.push_back(CurrentTime+TimeOfWork);
        MeetingTime.insert(MeetingTime.begin()+MeetingTimeHead , Time);
        Schedule.push_back(Time);
        Time.clear();
        CurrentTime += TimeOfWork ;
        MeetingTimeHead++;
    }

    // showing the result
    for (int i = 0; i < MeetingTime.size(); i++) {
        for (int j = 0; j < Schedule.size(); j++) {
            if ((MeetingTime[i][0] == Schedule[j][0]) && (MeetingTime[i][1] == Schedule[j][1])) {
                cout << j+1 << " " << (Schedule[j][0] / MINUTES_OF_AN_HOUR) + START_OF_DAY_HOUR << ":"
                    << put_0_if_less_10(Schedule[j][0] - ((Schedule[j][0] / MINUTES_OF_AN_HOUR) * MINUTES_OF_AN_HOUR)) << "-"
                    << (Schedule[j][1] / MINUTES_OF_AN_HOUR) + START_OF_DAY_HOUR << ":"
                    << put_0_if_less_10(Schedule[j][1] - ((Schedule[j][1] / MINUTES_OF_AN_HOUR) * MINUTES_OF_AN_HOUR)) << "\n";
            }   
        }
    }
    return 0;
}