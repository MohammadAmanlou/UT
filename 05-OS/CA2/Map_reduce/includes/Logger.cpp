#include "Logger.hpp"

using namespace std;

Logger::Logger()
{
	return;
}

void Logger::log(string message , string color){
	if (color == "red"){
		cout << "\033[1;31m" << message << "\033[0m" << endl;
	}
	else if (color == "green"){
		cout << "\033[1;32m" << message << "\033[0m" << endl;
	}
	else if (color == "blue"){
		cout << "\033[1;34m" << message << "\033[0m" << endl;
	}
	else if (color == "yellow"){
		cout << "\033[1;33m" << message << "\033[0m" << endl;
	}
	else {
		cout << message << endl;
	}
	fflush(stdout);
}