#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
// Constants
#define MAX_STUDENTS 10
#define MAX_FOOD 10
#define MAX_COUPONS 10
#define MAX_HALL 10
#define MAX_COMMAND_LENGTH 1000
#define FALSE 0
#define TRUE 1
#define NOT_SIGNED_IN -1
#define ADMIN_ID -2
#define USERS_PATH "users.txt"
#define MAX_STR_LEN 100
#define SIGNUP "signup"
#define LOGIN "login"
#define LOGOUT "logout"
#define ADD_HALL "add_hall"
#define ADD_FOOD "add_food"
#define ADD_COUPON "add_coupon"
#define FOOD_REPORT_PATH "food_report.txt"
#define HALL_REPORT_PATH "hall_report.txt"
#define GET_MONEY "get_money"
#define SHOW_MONEY "show_money"
#define RESERVE "reserve"
#define RESERVE_DISCOUNT "reserve_discount"
#define REPORT_FOOD "food_report"
#define HALL_REPORT "hall_report"
#define MENU "menu"
#define SHOW_RESERVED "show_reserved"
#define EXIT "exit"
// Define Struct
typedef struct Hall {
    char name[MAX_STR_LEN];
    int hall_id;
    int capacity;
    int reserved[7];
    int profit[7];
    struct Hall* next;
} Hall;
typedef struct Food {
    char name[MAX_STR_LEN];
    int food_id;
    int capacity;
    int reserved;
    int price;
    int profit;
    int hall_id;
    int hall_name[MAX_STR_LEN];
    int day;
    struct Food* next;
} Food;
typedef struct Coupon {
    int coupon_id;
    int percentage;
    int capacity;
    struct Coupon* next;
} Coupon;
typedef struct Food_list {
    Food* food;
    struct food_list* next; 
}Food_list;
typedef struct Student {
    char username[MAX_STR_LEN];
    int student_id;
    char password[MAX_STR_LEN];
    int money;
    struct Student* next;
    Food_list* food_reserved;
} Student;

void print_welcome(char username[MAX_STR_LEN])
{
    printf("%s", "welcome ");
    printf("%s", username);
    printf("%s", "\n");
}

void print_done()
{
    printf("%s", "done\n");
}

void print_user_already_exists()
{
    printf("%s", "user already exists\n");
}

void print_wrong_user_pass()
{
    printf("%s", "wrong username or pass\n");
}

void print_access_denied()
{
    printf("%s", "access denied\n");
}

void print_not_unique_hall_id()
{
    printf("%s", "hall id is not unique\n");
}

void print_not_unique_food_id()
{
    printf("%s", "food id is not unique\n");
}

void print_not_possible()
{
    printf("%s", "not possible\n");
}

void print_not_unique_coupon_id()
{
    printf("%s", "coupon id is not unique\n");
}

void print_wrong_hall_id()
{
    printf("%s", "wrong hall id\n");
}

int is_empty(char* str)
{
    if (strlen(str) <= 1)
        return TRUE;
    else
        return FALSE;
}

void save_new_user(char username[MAX_STR_LEN], int student_id, char password[MAX_STR_LEN])
{
    char str[MAX_COMMAND_LENGTH];
    char student_id_string[MAX_STR_LEN];
    sprintf(student_id_string, "%d", student_id);
    strcpy(str, username);
    strcat(str, " ");
    strcat(str, student_id_string);
    strcat(str, " ");
    strcat(str, password);
    strcat(str, "\n");
    // Saving the result
    FILE* fptr;
    fptr = fopen(USERS_PATH, "a");
    fputs(str, fptr);
    fclose(fptr);
}

int addFront(Student* head, char username[MAX_STR_LEN], int student_id, char password[MAX_STR_LEN]) {
    if (head->student_id == -1) {
        strcpy(head->username, username);
        head->student_id = student_id;
        head->food_reserved = NULL;
        strcpy(head->password, password);
        head->money = 0;
        head->next = NULL;
        return 1;
    }
    else {
        while (head->next != NULL) {
            if (strcmp(head->username, username) == 0) {
                print_user_already_exists();
                return 0;
            }
            head = head->next;
        } 
        if (strcmp(head->username, username) == 0) {
            print_user_already_exists();
            return 0;
        }
        head->next = malloc(sizeof(Student));
        head = head->next;
        strcpy((head->username), username);
        head->student_id = student_id;
        strcpy((head->password), password);
        head->food_reserved = NULL;
        head->money = 0;
        head->next = NULL;
        return 1;
    }
}
// Returns true if the signup is successful
int signup(char username[MAX_STR_LEN], int student_id, char password[MAX_STR_LEN], Student* students, int last_student_index, int save_result)
{
    if (addFront(students, username, student_id, password)) {
        if ((save_result == TRUE))
            save_new_user(username, student_id, password);
        return 1;
    }
    else {
        return 0;
    }
}
// This function tokenizes signup command
int signup_command(char cmd[MAX_COMMAND_LENGTH], Student* students, int last_student_index)
{
    char* token = strtok(cmd, " ");
    //Skip the first token
    token = strtok(NULL, " ");
    char username[MAX_STR_LEN];
    int student_id;
    char password[MAX_STR_LEN];
    int i = 0;
    while (token) {

        switch (i)
        {
        case 0:
            strcpy(username, token);
            break;
        case 1:
            student_id = atoi(token);
            break;
        case 2:
            strcpy(password, token);
            break;
        }

        i += 1;
        token = strtok(NULL, " ");
    }

    int save_result = TRUE;
    return signup(username, student_id, password, students, last_student_index, save_result);
}

// Returns student_id if the username & password is correct otherwise it returns FALSE
int login(char username[MAX_STR_LEN], char password[MAX_STR_LEN], Student* students, int last_student_index,Student** this_user)
{

    // Check if the entered user & pass are admin or not
    char admin[MAX_STR_LEN] = "admin";
    if (strcmp(username, admin) == 0 && strcmp(password, admin) == 0)
    {
        print_welcome(username);
        return ADMIN_ID;
    }
    while (students!=NULL) {
        if (strcmp(students->username , username)==0 && strcmp(students->password , password)==0) {
            print_welcome(students->username);
            *this_user = students;
            return 1;
        }
        students = students->next;
    }
    return FALSE;
}

// This function tokenizes login command
int login_command(char cmd[MAX_COMMAND_LENGTH], Student* students, int last_student_index, Student* head,Student** this_user)//head ezafe shod ezafe kon
{
    char* token = strtok(cmd, " ");
    //Skip the first token
    token = strtok(NULL, " ");

    char username[MAX_STR_LEN];
    char password[MAX_STR_LEN];

    int i = 0;
    while (token) {

        switch (i)
        {
        case 0:
            strcpy(username, token);
            break;
        case 1:
            strcpy(password, token);
            break;
        }

        i += 1;
        token = strtok(NULL, " ");
    }

    return login(username, password, students, last_student_index,this_user);
}
/* Admin Section */

int addFront_hall(Hall* head, char name[MAX_STR_LEN], int hall_id, int capacity, int last_hall_index) {
    if (head->hall_id == -1) {
        strcpy(head->name, name);
        head->hall_id = hall_id;
        head->capacity= capacity;
        for (int i = 0; i <= 7; i++) {
            head->reserved[i] = 0;
            head->profit[i] = 0;
        }
        head->next = NULL;
        return 1;
    }
    else {
        while (head->next != NULL){
            if (hall_id == head->hall_id) {
                print_not_unique_hall_id();
                return 0;
            }
            head = head->next;
        } 
        if (hall_id == head->hall_id) {
            print_not_unique_hall_id();
            return 0;
        }
        head->next = malloc(sizeof(Student));
        head = head->next;
        strcpy((head->name), name);
        head->hall_id = hall_id;
        head->capacity = capacity;
        for (int i = 0; i <= 7; i++) {
            head->reserved[i] = 0;
            head->profit[i] = 0;
        }
        head->next = NULL;
        return 1;
    }
}

int add_hall(char name[MAX_STR_LEN], int hall_id, int capacity, Hall* halls, int last_hall_index)
{
    if (addFront_hall(halls, name, hall_id, capacity, last_hall_index)) {
        return TRUE;
    }
    else
        return 0;
}

int add_hall_command(char cmd[MAX_COMMAND_LENGTH], Hall* halls, int last_hall_index)
{
    char* token = strtok(cmd, " ");
    //Skip the first token
    token = strtok(NULL, " ");

    char name[MAX_STR_LEN];
    int hall_id;
    int capacity;

    int i = 0;
    while (token) {

        switch (i)
        {
        case 0:
            strcpy(name, token);
            break;
        case 1:
            hall_id = atoi(token);
            break;
        case 2:
            capacity = atoi(token);
            break;
        }

        i += 1;
        token = strtok(NULL, " ");
    }

    return add_hall(name, hall_id, capacity, halls, last_hall_index);
}

int addFront_food(Food* head,char name[MAX_STR_LEN] , int food_id, int price, int hall_id, int capacity, int day, int last_hall_index) {
    if (head->food_id == -1) {
        strcpy(head->name, name);
        head->food_id = food_id;
        head->price = price;
        head->hall_id = hall_id;
        head->capacity = capacity;
        head->day = day;
        head->reserved= 0;
        head->profit = 0;
        head->next = NULL;
        return 1;
    }
    else {
        while (head->next != NULL){
            if (head->food_id == food_id) {
                print_not_unique_food_id();
                return 0;
            }
            head = head->next;
        } 
        if (head->food_id == food_id) {
            print_not_unique_food_id();
            return 0;
        }
        head->next = malloc(sizeof(Student));
        head = head->next;
        strcpy(head->name, name);
        head->food_id = food_id;
        head->price = price;
        head->hall_id = hall_id;
        head->capacity = capacity;
        head->day = day;
        head->reserved = 0;
        head->profit= 0;
        head->next = NULL;
        return 1;
    }
}

int add_food(char name[MAX_STR_LEN], int food_id, int price, int capacity, int hall_id, int day
    , Food* foods, Hall* halls, int last_hall_index, int last_food_index)
{
    // Here we check if hall_id exists
    int hall_found=FALSE;
    while (halls) {
        if (halls ->hall_id == hall_id) {
            hall_found = TRUE;
            break;

        }
        halls = halls->next;
    }
    if (hall_found == FALSE)
    {
        print_wrong_hall_id();
        return FALSE;
    }
   
    if (addFront_food(foods, name, food_id, price, hall_id, capacity, day, last_hall_index))
        return TRUE;
    else
        return 0;
}

int add_food_command(char cmd[MAX_COMMAND_LENGTH], Food* foods, Hall* halls, int last_hall_index, int last_food_index)
{
    char* token = strtok(cmd, " ");
    //Skip the first token
    token = strtok(NULL, " ");
    char name[MAX_STR_LEN];
    int food_id;
    int price;
    int capacity;
    int hall_id;
    int day;
    int i = 0;
    while (token) {

        switch (i)
        {
        case 0:
            strcpy(name, token);
            break;
        case 1:
            food_id = atoi(token);
            break;
        case 2:
            price = atoi(token);
            break;
        case 3:
            capacity = atoi(token);
            break;
        case 4:
            hall_id = atoi(token);
            break;
        case 5:
            day = atoi(token);
            break;
        }
        i += 1;
        token = strtok(NULL, " ");
    }
    return add_food(name, food_id, price, capacity, hall_id, day, foods, halls, last_hall_index, last_food_index);
}

int addFront_coupon(Coupon* head, int coupon_id, int percentage, int capacity, int last_coupon_index) {
    if (head->coupon_id == -1) {
        head->coupon_id = coupon_id;
        head->capacity = capacity;
        head->percentage = percentage;
        head->next = NULL;
        return 1;
    }
    else {
        do {
            if (coupon_id == head->coupon_id) {
                print_not_unique_coupon_id();
                return 0;
            }
            head = head->next;
        } while (head->next != NULL);
        head->next = malloc(sizeof(Student));
        head = head->next;
        head->coupon_id = coupon_id;
        head->capacity = capacity;
        head->percentage = percentage;
        head->next = NULL;
        return 1;
    }
}

int add_coupon(int coupon_id, int percentage, int capacity, Coupon* coupons, int last_coupon_index)
{
    if (addFront_coupon(coupons, coupon_id, percentage, capacity, last_coupon_index))
        return TRUE;
    else
        return 0;
}

int add_coupon_command(char cmd[MAX_COMMAND_LENGTH], Coupon* coupons, int last_coupon_index)
{
    char* token = strtok(cmd, " ");
    //Skip the first token
    token = strtok(NULL, " ");

    int coupon_id;
    int percentage;
    int capacity;

    int i = 0;
    while (token) {

        switch (i)
        {
        case 0:
            coupon_id = atoi(token);
            break;
        case 1:
            percentage = atoi(token);
            break;
        case 2:
            capacity = atoi(token);
            break;
        }

        i += 1;
        token = strtok(NULL, " ");
    }

    return add_coupon(coupon_id, percentage, capacity, coupons, last_coupon_index);
}

void get_money(char cmd[MAX_COMMAND_LENGTH],Student* this_user) {
    char* token = strtok(cmd, " ");
    //Skip the first token
    token = strtok(NULL, " ");
    int money = 0;
    int i = 0;
    money = atoi(token);
    this_user->money += money;
    print_done();
 }

void show_money(Student* this_user) {

    printf("%d\n", this_user->money);

}

int show_menu(Student* students, Food* foods) { 
    Food* head = NULL;
    head = foods->name[MAX_STR_LEN];///MOHEEMM
    for (int i = 1; i < 8; i++)
    {
        printf("i: \n");
        while (head) {
            printf("%s %d %d %s %d \n", foods->name[MAX_STR_LEN], foods->price, foods->food_id, foods->hall_name[MAX_STR_LEN], foods->capacity);
        }

    }

    return TRUE;
}

void add_new_food(Food * this_food ,Student * this_user ) {
    Food_list* head = this_user->food_reserved ;
    if (this_user->food_reserved == NULL) {
        this_user->food_reserved = (Food_list*)malloc(sizeof(Food_list));
        this_user->food_reserved->next = NULL;
        this_user->food_reserved->food = this_food;
        return;
    }
    while (head->next != NULL) {
        head = head->next;
    }
    head->next = (Food_list*)malloc(sizeof(Food_list));
    head = head->next;
    head->next = NULL;
    head->food = this_food;
}

void reserve(Student* this_user , Food* foods , Hall* halls ,int food_id) {
    Food* this_food = NULL;
    while (foods->next != NULL){
        if (food_id == foods->food_id) {
            this_food = foods;
            break;
        }
        foods = foods->next;
    }
    if (food_id == foods->food_id) {
        this_food = foods;
    }
    Hall* this_hall=NULL;
    while (halls->next != NULL) {
        if (halls->hall_id == foods->hall_id) {
            this_hall = halls;
            break;
        }
        halls = halls->next;
    }
    if (halls->hall_id == foods->hall_id) {
        this_hall = halls;
    }
    if (this_food==NULL || (this_hall->capacity)-(this_hall->reserved[(this_food->day- 1)]) == 0 || (this_user->money < this_food->price) ||
        ((this_food->capacity)-(this_food->reserved))==0 )
        print_not_possible();
    else {
        this_food->profit+= this_food->price;
        this_user->money -= this_food->price;
        this_food->reserved += 1;
        this_hall->reserved[(this_food->day)-1] += 1;
        this_hall->profit[(this_food->day) - 1] += this_food->price;
        add_new_food(this_food, this_user);
        print_done();
    }
 }

void food_report(Food* foods) {
    FILE* food_report = fopen(FOOD_REPORT_PATH, "w");
    if (foods->food_id != -1) {
        while (foods->next != NULL) {
            fprintf(food_report, "%d %d %d %d \n", foods->food_id, foods->capacity, foods->reserved, foods->profit);
            fflush(food_report);
            foods = foods->next;
        }
        fprintf(food_report, "%d %d %d %d \n", foods->food_id, foods->capacity, foods->reserved, foods->profit);
        fflush(food_report);
        print_done();
    }
    else {
        fprintf(food_report, "there is no food available");
        fflush(food_report);
    }
}

void reserve_discount(Student* this_user, Food* foods, Coupon* coupons, Hall* halls, int food_id , int coupon_id) {
    Food* this_food = NULL;
    while (foods->next != NULL) {
        if (food_id == foods->food_id) {
            this_food = foods;
            break;
        }
        foods = foods->next;
    }
    if (food_id == foods->food_id) {
        this_food = foods;
    }
    Hall* this_hall = NULL;
    while (halls->next != NULL) {
        if (halls->hall_id == foods->hall_id) {
            this_hall = halls;
            break;
        }
        halls = halls->next;
    }
    if (halls->hall_id == foods->hall_id) {
        this_hall = halls;
    }
    Coupon* this_coupon = NULL;
    while (coupons->next != NULL) {
        if (coupons->coupon_id == coupon_id) {
            this_coupon = coupons;
            break;
        }
        coupons = coupons->next;
    }
    if (coupons->coupon_id == coupons->coupon_id) {
        this_coupon = coupons;
    }
    if (this_food == NULL || this_coupon==NULL || (this_hall->capacity) - (this_hall->reserved[(this_food->day - 1)]) == 0 
        || (this_user->money < this_food->price) || this_coupon->capacity==0 ||
        ((this_food->capacity) - (this_food->reserved)) == 0)
        print_not_possible();
    else {
        this_food->profit += ceil((this_food->price)*(this_coupon->percentage)/100.0);
        this_user->money -= ceil((this_food->price) * (this_coupon->percentage) / 100.0);
        this_food->reserved += 1;
        this_hall->reserved[(this_food->day) - 1] += 1;
        this_hall->profit[(this_food->day) - 1] += ceil((this_food->price) * (this_coupon->percentage) / 100.0);
        this_coupon->capacity -= 1;
        add_new_food(this_food, this_user);
        print_done();
    }
}

void hall_report(Hall* halls) {
    FILE* hall_report = fopen(HALL_REPORT_PATH, "w");
    char* hall_name = (char*)malloc(MAX_STR_LEN * sizeof(char));
    for (int i = 1; i <= 7; i++) {
        if (halls->hall_id != -1) {
            while (halls->next != NULL) {
                fprintf(hall_report, "%d %s %d\n %d %d %d", halls->hall_id, halls->name, halls->capacity ,
                    i ,halls->reserved[i-1] , halls->profit[i-1] );
                fflush(hall_report);
                halls = halls->next;
            }
            fprintf(hall_report, "%d %s %d\n", halls->hall_id, halls->name, halls->capacity);
            fflush(hall_report);
            print_done();
        }
        else {
            fprintf(hall_report, "there is no hall ");
            fflush(hall_report);
            break;
        }
    }
}

void menu(Food* foods) {
    for (int i = 1; i <= 7; i++) {
        printf("%d:\n", i);
        while (foods->next != NULL) {
            if (foods->day == i) {
                printf("%s %d %d %d", foods->name, foods->price, foods->food_id,
                    foods->hall_id, foods->capacity - foods->reserved);
            }
            foods = foods->next;
        }
        if (foods->day == i) {
            printf("%s %d %d %d", foods->name, foods->price, foods->food_id,
                foods->hall_id, foods->capacity - foods->reserved);
        }
    }
}

void show_reserved(Student* this_user) {
    for (int i = 1; i <= 7; i++) {
        Food_list* head = this_user->food_reserved;
        while (head->next != NULL) {
            if (head->food->day == (i)) {
                printf("%d\n %s %d %d %d\n", i, head->food->name, head->food->price, head->food->food_id, head->food->hall_id);
            }
            head = head->next;
        }
        if (head->food->day == (i)) {
            printf("%d\n %s %d %d %d\n", i, head->food->name, head->food->price, head->food->food_id, head->food->hall_id);
        }
    }
}

void run(Student* students, Hall* halls, Food* foods, Coupon* coupons, int last_student_index, Student* head)
{
    // Current logged in user student_id
    int logged_in_user = NOT_SIGNED_IN;
    Student* this_user = NULL;
    // Last indices
    int last_hall_index = -1;
    int last_food_index = -1; 
    int last_coupon_index = -1;
    while (TRUE)
    {
        char cmd[MAX_COMMAND_LENGTH] = "";
        fgets(cmd, MAX_COMMAND_LENGTH, stdin); // read from stdin
        if (!is_empty(cmd))
            // Remove Next Line(\n)
            cmd[strcspn(cmd, "\n")] = 0;
        char cmd_copy[MAX_COMMAND_LENGTH];
        strcpy(cmd_copy, cmd);
        char* p = strtok(cmd_copy, " ");
        // Signup/Login Commands
        if (logged_in_user == NOT_SIGNED_IN)
        {
            //Signup command
            if (strcmp(p, SIGNUP) == 0)
            {
                if (signup_command(cmd, students, last_student_index) == 1)
                {
                    last_student_index += 1;
                    print_done();
                }
            }
            //Login command
            else if (strcmp(p, LOGIN) == 0)
            {
                int log = login_command(cmd, students, last_student_index, head,&this_user);
                if (log == FALSE)
                    print_wrong_user_pass();
                else
                    logged_in_user = log;
            }
            else
            {
                print_access_denied();
            }
        }
        // Admin Commands
        else if (logged_in_user == ADMIN_ID)
        {
            //Logout command
            if (strcmp(p, LOGOUT) == 0)
            {
                logged_in_user = NOT_SIGNED_IN;
                print_done();
            }
            //Add Hall
            else if (strcmp(p, ADD_HALL) == 0)
            {
                if (add_hall_command(cmd, halls, last_hall_index) == TRUE)
                {
                    last_hall_index += 1;
                    print_done();
                }
            }
            //Add Food
            else if (strcmp(p, ADD_FOOD) == 0)
            {
                if (add_food_command(cmd, foods, halls, last_hall_index, last_food_index) == TRUE)
                {
                    last_food_index += 1;
                    print_done();
                }
            }
            //Add Coupon
            else if (strcmp(p, ADD_COUPON) == 0)
            {
                if (add_coupon_command(cmd, coupons, last_coupon_index) == TRUE)
                {
                    last_coupon_index += 1;
                    print_done();
                }
            }
            //food_report
            else if (strcmp(p, REPORT_FOOD)==0) 
            {
                food_report(foods);
            }
            //hall_report
            else if (strcmp(p, HALL_REPORT)==0)
            {
                hall_report(coupons);
            }
            // no access
            else
            {
                print_access_denied();
            }
        }
        // user commands
        else
        {
            //Logout command
            if (strcmp(p, LOGOUT) == 0)
            {
                logged_in_user = NOT_SIGNED_IN;
                this_user = NULL;
                print_done();
            }
            //get money
            else if (strcmp(p, GET_MONEY) == 0)
            {
                get_money(cmd, this_user);
            }
            //show money
            else if (strcmp(p, SHOW_MONEY) == 0)
            {
                show_money(this_user);
            }
            // reserve 
            else if (strcmp(p, RESERVE)==0)
            {
                char * token = strtok(NULL, " ");
                //Skip the first token
                int food_to_reserve_id ;
                food_to_reserve_id = atoi(token);
                reserve(this_user , foods , halls , food_to_reserve_id);
            }
            // reserve discount
            else if (strcmp(p, RESERVE_DISCOUNT) == 0)
            {
                char* token = strtok(NULL, " ");
                //Skip the first token
                int food_to_reserve_id;
                food_to_reserve_id = atoi(token);
                token = strtok(NULL, " ");
                int coupon_to_reserve_id;
                coupon_to_reserve_id = atoi(token);
                reserve_discount(this_user, foods, coupons , halls, food_to_reserve_id , coupon_to_reserve_id);
            }
            // see menu
            else if (strcmp(p, MENU) == 0)
            {
                menu(foods);
            }
            // show reserved
            else if (strcmp(p, SHOW_RESERVED) == 0)
            {
                show_reserved(this_user);
            }
            //exit
            else if (strcmp(p, EXIT) == 0) 
            {
                free(students);
                free(halls);
                free(foods);
                free(coupons);
                break;
            }
            //no access
            else
            {
                print_access_denied();
            }
        }
        continue;
    }
    return;
}

int file_exists(char* filename) {
    FILE* file;
    file = fopen(filename, "r");
    if (file)
    {
        fclose(file);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

int read_students(Student* students)
{
    int last_student_index = -1;
    // Create one if it doesn't exist
    if (file_exists(USERS_PATH) == FALSE)
    {
        FILE* file_ptr = fopen(USERS_PATH, "w");
        fclose(file_ptr);
    }
    else {
        FILE* fp = fopen(USERS_PATH, "r");

        char buffer[MAX_COMMAND_LENGTH];
        while (fgets(buffer, MAX_COMMAND_LENGTH, fp))
        {
            // Remove trailing newline
            buffer[strcspn(buffer, "\n")] = 0;
            char* token = strtok(buffer, " ");
            char username[MAX_STR_LEN];
            int student_id;
            char password[MAX_STR_LEN];
            int i = 0;
            while (token) {
                switch (i)
                {
                case 0:
                    strcpy(username, token);
                    break;
                case 1:
                    student_id = atoi(token);
                    break;
                case 2:
                    strcpy(password, token);
                    break;
                }
                i += 1;
                token = strtok(NULL, " ");
            }
            int save_result = FALSE;
            signup(username, student_id, password, students, last_student_index, save_result);

            last_student_index += 1;
        }
        fclose(fp);
    }

    return last_student_index;
}

int main()
{
    Student* students = malloc(MAX_STUDENTS * sizeof * students);
    students->next = NULL;
    students->student_id = -1;
    Hall* halls = malloc(MAX_HALL * sizeof * halls);
    halls->next = NULL;
    halls->hall_id = -1;
    Food* foods = malloc(MAX_FOOD * sizeof * foods);
    foods->next = NULL;
    foods->food_id = -1;
    Coupon* coupons = malloc(MAX_COUPONS * sizeof * coupons);
    coupons->next = NULL;
    coupons->coupon_id = -1;
    //Reserved_food* reserved_food = malloc(MAX_COUPONS * sizeof * reserved_food);
    Student* head = NULL;
    int last_student_index = read_students(students);
    run(students, halls, foods, coupons, last_student_index, head);
    return 0;
}