#include <iostream>
#include <string>
#include <vector>
#include "person.hpp"
#include "library.hpp"
#include "documents.hpp"

using namespace std;

int main(){
    Library library;
    library.add_student_member("123456789", "John");
    library.add_student_member("123456789", "John");
    library.add_prof_member("Prof. Smith");
    library.add_book("The Art of Computer Programming", 1);
    library.add_magazine("The Computer Language", 2019, 1, 1);
    library.add_reference("The C++ Programming Language", 1);
    library.borrow("John", "The Art of Computer Programming");
    library.time_pass(1);
    library.extend("John", "The Art of Computer Programming");
    library.time_pass(11);
    library.return_document("John", "The Art of Computer Programming");
    cout << library.get_total_penalty("John") << endl;
    
    return 0;
}