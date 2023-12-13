#ifndef LOGGER
#define LOGGER

#include <iostream>
#include <fstream>
#include <sstream>
#include <unistd.h>
#include <stdlib.h>
#include <string>
#include <sys/wait.h>
#include <vector>

using namespace std;

class Logger{
	public:
		Logger();
		void log(string message , string color);
	private:


};






#endif