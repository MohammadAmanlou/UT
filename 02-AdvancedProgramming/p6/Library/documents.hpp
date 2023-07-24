#ifndef DOCUMENTS_HPP
#define DOCUMENTS_HPP

#include <iostream>
#include <string>
#include <vector>

const std::string EXTEND_IN_BORROW_DAY = "You can’t extend and borrow a document on the same day";
const std::string LATE_EXTEND = "You can’t renew a document after receiving a penalty";
const std::string MAX_EXTEND = "You can’t renew a document more than two times";
const std::string EXTEND_MAGAZINE = "You can’t renew magazines";

class Person;

const int BORROWED = 0;
const int AVAILABLE = 1;
const int MAX_EXTENSIONS = 2;
const int BOOK_DEADLINE = 10;
const int MAGAZINE_DEADLINE = 2;
const int REFERENCE_DEADLINE = 5;

class Document{
    private:
        std::string name;
        bool is_borrowed;
        Person* borrower;
    protected :
        int number_of_extensions;
        int borrow_day;
        int back_day;
    public:
        Document(std::string name_ ){
            name = name_;
            is_borrowed = AVAILABLE;
            number_of_extensions = 0;
        }
        std::string get_name(){
            return name;
        }
        void set_borrowed(){
            is_borrowed = BORROWED;
        }
        bool get_is_borrowed(){
            return is_borrowed;
        }
        void borrow(int today ,Person* person);
        virtual void extend(int today);
        void return_doc(int today);
        virtual int get_penalty() = 0;
};

class Book: public Document{
    public:
        Book(std::string name_ ): Document(name_ ){

        }
        void extend(int today);
        int get_penalty();
};

class Magazine: public Document{
    private:
        int year;
        int number;
    public:
        Magazine(std::string name_ ,int year_ ,int number_): Document(name_ ){
            if (year_ > 0){
                year = year_;
            }
            else{
                std::cerr << "invalid year" << std::endl;
                exit(EXIT_SUCCESS);
            }
            if (number_ > 0){
                number = number_;
            }
            else{
                std::cerr << "invalid number" << std::endl;
                exit(EXIT_SUCCESS);
            }
            
        }
        void extend(int today);
        int get_penalty();

};

class Reference: public Document{
    public:
        Reference(std::string name_ ): Document(name_ ){
        }
        void extend(int today);
        int get_penalty();
};


#endif // DOCUMENTS_HPP