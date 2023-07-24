typedef struct student {
	char* username;
	long long int student_id;
	char* password;
} student;
typedef struct coupon {
	long long int id;
	int percentage;
	int capacity;
}Coupon;
typedef struct hall {
	char* name;
	long long int id;
	int Capacity;
}Hall;
typedef struct food {
	char* name;
	long long int id;
	long int price;
	Hall hall;
	int day;
}Food;
enum condition {
	Signup,
	Login
};