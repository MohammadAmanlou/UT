#include "documents.hpp"

void Document::borrow(int today , Person * person){
    is_borrowed = BORROWED;
    borrow_day = today;
    borrower = person;
}

void Document::extend(int today){
    if (number_of_extensions >= MAX_EXTENSIONS){
        std::cerr << MAX_EXTEND << std::endl;
        exit(EXIT_SUCCESS);
    }
    else if(number_of_extensions < MAX_EXTENSIONS){
        number_of_extensions++;
    }
}

void Book::extend(int today){
    if (today == borrow_day){
        std::cerr << EXTEND_IN_BORROW_DAY << std::endl;
        exit(EXIT_SUCCESS);
    }
    else if (borrow_day + (BOOK_DEADLINE * (number_of_extensions+1)) < today){
        std::cerr << LATE_EXTEND << std::endl;
        exit(EXIT_SUCCESS);
    }
    if ((borrow_day + (BOOK_DEADLINE * (number_of_extensions+1)) > today) && (today > borrow_day)){
        Document::extend(today);
    }
}

void Magazine::extend(int today){
    std::cerr << EXTEND_MAGAZINE << std::endl;
}

void Reference::extend(int today){
    if (today == borrow_day){
        std::cerr << EXTEND_IN_BORROW_DAY << std::endl;
        exit(EXIT_SUCCESS);
    }
    else if (borrow_day + (REFERENCE_DEADLINE * (number_of_extensions+1)) < today){
        std::cerr << LATE_EXTEND << std::endl;
        exit(EXIT_SUCCESS);
    }
    else if ((borrow_day + (REFERENCE_DEADLINE* (number_of_extensions+1)) > today) && (today > borrow_day)){
        Document::extend(today);
    }
}
        
void Document::return_doc(int today){
    is_borrowed = AVAILABLE;
    back_day = today;
}

int Book::get_penalty(){
    int deadline = borrow_day + (BOOK_DEADLINE * (number_of_extensions+1));
    int penalty = 0 ;
    if (deadline < back_day){
        if (back_day - deadline <= 7){
            penalty = (back_day - deadline)*2000 ;
        }
        else if (back_day - deadline <= 21){
            penalty = 7*2000 + (back_day - deadline - 7)*3000 ;
        }
        else if (back_day - deadline > 21){
            penalty = 7*2000 + 14*3000 + (back_day - deadline - 21)*5000 ;
        }
    }
    return penalty;
}

int Reference::get_penalty(){
    int deadline = borrow_day + (BOOK_DEADLINE * (number_of_extensions+1));
    int penalty = 0 ;
    if (deadline < back_day){
        if (back_day - deadline <= 3){
            penalty = (back_day - deadline)*5000 ;
        }
        else if (back_day - deadline > 3){
            penalty = 3*5000 + (back_day - deadline - 3)*7000 ;
        }
    }
    return penalty;
}

int Magazine::get_penalty(){
    int deadline = borrow_day + (BOOK_DEADLINE * (number_of_extensions+1));
    int penalty = 0 ;
    if (deadline < back_day){
        if (year > 1390){
            penalty = (back_day - deadline)*2000 ;
        }
        else if (year <= 1390){
            penalty = (back_day - deadline)*3000 ;
        }
    }
    return penalty;
}