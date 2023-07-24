#include "library.hpp"

std::string Library::find_member(std::string member_name){
    for (int i = 0; i < members.size(); i++){
        if (members[i]->get_name() == member_name){
            return member_name ;
        }
    }
    return "";
}

bool check_empty_field(std::string input_string){
    if (input_string.empty() || input_string==""){
        return true;
    }
    return false;
}

void Library::handle_input_errors(std::string student_id, std::string student_name){
    if (check_empty_field(student_name) || check_empty_field(student_id)){
        std::cerr << EMPTY_FIELD_ERROR << std::endl;
        exit(EXIT_SUCCESS);
    }

    if (find_member(student_name) != "")
    {
        std::cerr << USER_EXIST_ERROR << std::endl;
        exit(EXIT_SUCCESS);
        
    }
}

void Library::add_student_member(std::string student_id, std::string student_name)
{
    handle_input_errors(student_id,student_name);
    members.push_back(new Student(student_name , student_id));
}

void Library::add_prof_member(std::string prof_name)
{
    std::string default_id = "12345";
    handle_input_errors(default_id,prof_name);
    members.push_back(new Teacher(prof_name));
}

std::string Library::find_doc(std::string doc_name){
    for (int i = 0; i < documents.size(); i++){
        if (documents[i]->get_name() == doc_name){
            return doc_name ;
        }
    }
    return "";
}

void Library::handle_doc_input_errors(std::string doc_name){
    if (check_empty_field(doc_name)){
        std::cerr << EMPTY_FIELD_ERROR << std::endl;
        exit(EXIT_SUCCESS);
    }

    if (find_doc(doc_name) != "")
    {
        std::cerr << REPEATED_DOC_ERROR << std::endl;
        exit(EXIT_SUCCESS);
    }
}

void Library::add_book(std::string book_title, int copies)
{
    handle_doc_input_errors(book_title);
    for (int i=0 ; i<copies ; i++){
        documents.push_back(new Book(book_title));
    }
    
}

void Library::add_magazine(std::string magazine_title, int year, int number, int copies)
{
    handle_doc_input_errors(magazine_title);
    for (int i=0 ; i<copies ; i++){
        documents.push_back(new Magazine(magazine_title , year , number));
    }
}

void Library::add_reference(std::string reference_title, int copies)
{
    handle_doc_input_errors(reference_title);
    for (int i=0 ; i<copies ; i++){
        documents.push_back(new Reference(reference_title));
    }
}

void Library ::borrow(std::string member_name, std::string document_title){
    bool found = false;
    for(int i = 0 ; i < members.size() ; i++){
        if(members[i]->get_name() == member_name){
            for(int j = 0 ; j < documents.size() ; j++){
                if((documents[j]->get_name() == document_title) && (documents[j]->get_is_borrowed() == AVAILABLE)){
                    found = true;
                    members[i]->borrow(documents[j]);
                    documents[j]->borrow(today_date , members[i]);
                }
            }
            if(!found){
                std::cerr << DOES_NOT_EXIST_DOC << std::endl; 
                exit(EXIT_SUCCESS);
            }
        }
    }
}

void Library ::extend(std::string member_name, std::string document_title){
    for(int i = 0 ; i < members.size() ; i++){
        if(members[i]->get_name() == member_name){
            for(int j = 0 ; j < documents.size() ; j++){
                if((documents[j]->get_name() == document_title)){
                    if (!(members[i]->is_borrow(documents[j]))){
                        std::cerr << NOT_BORROW_ERROR << std::endl;
                    }
                    documents[j]->extend(today_date);
                }
            }
        }
    }
}

void Library ::return_document(std::string member_name, std::string document_title){
    for(int i = 0 ; i < members.size() ; i++){
        if(members[i]->get_name() == member_name){
            for(int j = 0 ; j < documents.size() ; j++){
                if((documents[j]->get_name() == document_title)){
                    members[i]->return_doc(documents[j]);
                    documents[j]->return_doc(today_date);
                }
            }
        }
    }
}

int Library::get_total_penalty(std::string member_name){
    for(int i = 0 ; i < members.size() ; i++){
        if(members[i]->get_name() == member_name){
            return members[i]->get_penalty();
        }
    }
    return 0;
}

std::vector<std::string> Library::available_titles(){
    std::vector<std::string> titles;
    bool is_in_vector = 0;
    for (int i = 0 ; i < documents.size() ; i++){
        if(documents[i]->get_is_borrowed() == AVAILABLE){
            for (int j=0 ; j<titles.size() ; j++){
                if(titles[j] == documents[i]->get_name()){
                    is_in_vector = 1;
                    break;
                }
            }
            if(is_in_vector == 0){
                titles.push_back(documents[i]->get_name());
            }
        }
    }
    return titles ;
}

int Library::time_pass(int days){
    if (days < 0 ){
        std::cerr << INVALID_DAYS_ERROR << std::endl;
        exit(EXIT_SUCCESS);
    }
    today_date += days;
    return today_date;
}