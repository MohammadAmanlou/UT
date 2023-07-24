#ifndef PERSON_HPP
#define PERSON_HPP

#include <iostream>
#include <string>
#include <vector>
#include "documents.hpp"

const int MAX_BORROWED_DOCUMENTS_STUDENT = 3;
const int MAX_BORROWED_DOCUMENTS_TEACHER = 5;
const std::string NOT_BORROW_ERROR = "You have not borrowed this document";
const std::string ALREADY_BORROWED = "You borrowed this document already";


class Person {
    public:
        Person(std::string name_){
            name = name_;
            borrowed_documents_cnt = 0;
            penalty = 0;
        }
        std::string get_name(){
            return name;
        }
        virtual void borrow(Document* document);
        void return_doc(Document* document);
        int get_penalty();
        bool is_borrow(Document* document);
        virtual bool check_can_borrow(Document* document);

    private:
        std::string name;
        std::vector <Document*> borrowed_documents;
        int penalty;
    protected :
        int borrowed_documents_cnt;
        
};


class Student: public Person{
    private :
        std::string student_id;
    public:
        Student(std::string name_ , std::string student_id_): Person(name_){
            student_id = student_id_;
        }
        void borrow(Document* document );
        bool check_can_borrow(Document* document);
};


class Teacher: public Person{
    private:
    public:
        Teacher(std::string name_): Person(name_){
            
        }
        void borrow(Document* document );
        bool check_can_borrow(Document* document);
};

#endif // PERSON_HPP