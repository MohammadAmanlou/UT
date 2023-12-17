# Define the compiler to use
CXX := g++

# Define any compile-time flags
# -std=c++11 - Use the C++11 standard
# -Wall - This enables all the warnings about constructions that some users consider questionable, and that are easy to avoid
# -Wextra - This enables some extra warning flags that are not enabled by -Wall
CXXFLAGS := -std=c++11 -Wall -Wextra -pthread

# Define the include directory
INCLUDES :=

# Define the source files
SRCS := bmp.cpp 

# Define the object files
OBJS := $(SRCS:.cpp=.o)

# Define the executable file 
MAIN := imageFilters.out

.PHONY: clean

$(MAIN): $(OBJS) 
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS)

.cpp.o:
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $<  -o $@

clean:
	$(RM) *.o *~ $(MAIN)
