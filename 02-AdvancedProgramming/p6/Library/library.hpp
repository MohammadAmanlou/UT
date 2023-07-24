#ifndef LIBRARY_HPP
#define LIBRARY_HPP

#include <iostream>
#include <string>
#include <vector>
#include "person.hpp"
#include "documents.hpp"



const std::string USER_EXIST_ERROR = "Name already exists";
const std::string EMPTY_FIELD_ERROR = "Empty field";
const std::string REPEATED_DOC_ERROR = "A document with the specified name already exists";
const std::string INVALID_DAYS_ERROR = "Invalid day";
const std::string DOES_NOT_EXIST_DOC = "This document does not exist";

class Library {
private:
    std::vector<Person*> members;
    std::vector<Document*> documents;
    int today_date;
public:
    Library(){
        today_date = 0;
    }
    void add_student_member(std::string student_id, std::string student_name);
    void add_prof_member(std::string prof_name);
    void add_book(std::string book_title, int copies);
    void add_magazine(std::string magazine_title, int year, int number, int copies);
    void add_reference(std::string reference_title, int copies);
    void borrow(std::string member_name, std::string document_title);
    void extend(std::string member_name, std::string document_title);
    void return_document(std::string member_name, std::string document_title);
    int get_total_penalty(std::string member_name);
    std::vector<std::string> available_titles();
    int time_pass(int days);

    std::string find_member(std::string member_name);
    void handle_input_errors(std::string student_id, std::string student_name);
    std::string find_doc(std::string doc_name);
    void handle_doc_input_errors(std::string doc_name);
};

#endif