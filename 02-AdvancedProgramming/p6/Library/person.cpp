#include "person.hpp"

void Person::borrow(Document* document ){
    borrowed_documents.push_back(document);
    borrowed_documents_cnt++;
}

bool Person::check_can_borrow(Document* document){
    for (int i =0 ; i<borrowed_documents.size() ; i++){
        if(borrowed_documents[i]->get_name() == document->get_name()){
            std::cerr << ALREADY_BORROWED << std::endl;
            exit(EXIT_SUCCESS);
        }
    }
    return true;
}

void Student::borrow(Document* document ){
    if (check_can_borrow(document)){
        Person::borrow(document );
    }
}

bool Student::check_can_borrow(Document* document ){
    Person::check_can_borrow(document);
    if (borrowed_documents_cnt < MAX_BORROWED_DOCUMENTS_STUDENT){
        return true;
    }
    return false;
}

bool Teacher::check_can_borrow(Document* document){
    Person::check_can_borrow(document);
    if (borrowed_documents_cnt < MAX_BORROWED_DOCUMENTS_TEACHER){
        return true;
    }
    return false;
}

void Teacher::borrow(Document* document ){
    if (!check_can_borrow(document)){
        std::cerr << "Maximum number of allowed borrows exceeded" << std::endl;
        exit(EXIT_SUCCESS);
    }
    else {
        Person::borrow(document );
    }
}

void Person::return_doc(Document* document){
    bool found = false;
    for (int i = 0; i < borrowed_documents.size(); i++){
        if (borrowed_documents[i]->get_name() == document->get_name()){
            borrowed_documents.erase(borrowed_documents.begin() + i);
            found = true;
        }
    }
    if (!found){
        std::cerr << NOT_BORROW_ERROR << std::endl;
        exit(EXIT_SUCCESS);
    }
    else {
        penalty += document->get_penalty();
    }
}

bool Person::is_borrow(Document* document){
    bool found = false;
    for (int i = 0; i < borrowed_documents.size(); i++){
        if (borrowed_documents[i]->get_name() == document->get_name()){
            found = true;
        }
    }
    return found;
}

int Person::get_penalty(){
    return penalty;
}