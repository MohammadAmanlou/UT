//Mohammad Amanlou :) 
#define _CRT_SECURE_NO_WARNINGS
#define _CRT_SECURE_NO_DEPRECATE
#define _CRT_NONSTDC_NO_DEPRECATE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include "structs"
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
void input(char** command) {
	*command = (char*)malloc(sizeof(char) * 20);
	int max = 20;
	for (int i = 0; i < max; i++)
		(*command)[i] = 0;
	char c;
	int i = 0;
	getchar();
	while ((c = getchar()) != ' ' && (c != '\n')) {
		(*command)[i++] = c;
		if ((*command)[max - 1] != 0) {
			max += 10;
			*command = (char*)realloc(*command, max * sizeof(char));
		}
	}
	(*command)[i] = '\0';
	if ((*command)[i] == 0) { (*command)[i] = '\0'; }
}
void input_file(char** buffer, FILE* file) {
	(*buffer) = (char*)malloc(sizeof(char) * 20);
	int max = 20;
	for (int i = 0; i < max; i++)
		(*buffer)[i] = 0;
	char c;
	int i = 0;
	while ((!feof(file) && (c = fgetc(file)) != ' ') && (c != '\n')) {
		(*buffer)[i++] = c;
		if ((*buffer)[max - 1] != 0) {
			max += 10;
			(*buffer) = (char*)realloc((*buffer), max * sizeof(char));
		}
	}
	(*buffer)[i] = '\0';
	if ((*buffer)[i] == 0) { (*buffer)[i] = '\0'; }
}
int main() {
	FILE* takhfif_file;
	FILE* users;
	FILE* hall_file;
	FILE* food_file;
	Food ghaza;
	student std;
	Hall salon;
	Coupon takhfif;
	std.username = (char*)malloc(sizeof(char) * 20);
	std.password = (char*)malloc(sizeof(char) * 20);
	salon.name = (char*)malloc(sizeof(char) * 20);
	ghaza.name = (char*)malloc(sizeof(char) * 20);
	users = fopen("users.txt", "a+");
	hall_file = fopen("hall.txt", "a+");
	food_file = fopen("food.txt", "a+");
	takhfif_file = fopen("coupon.txt", "a+");
	if (users == NULL)
	{
		printf("Error connecting to the server :) \n");
		exit(EXIT_FAILURE);
	}
	printf("Hello, Welcome to My Resturant \n     Please Enter Login or Signup(capital S&L)\n");
	printf("If you choose Login you should enter your username & pass with a space between\n");
	printf("And if you choose Signup you should enter your username & student_id & pass with a space between\n");
	char* Signup_Login = (char*)malloc(sizeof(char) * 7);
	int a = 0;
	a = scanf("%s", Signup_Login);
	if (a == 0) { printf("an error has occured");  return 0; };
	if ((strcmp(Signup_Login, "Signup") > 0 && strcmp(Signup_Login, "Login") > 0) ||
		(strcmp(Signup_Login, "Signup") < 0 && strcmp(Signup_Login, "Login") < 0)) {
		printf("Undefined Syntax\n");
		return 0;
	}
	else if (strcmp(Signup_Login, "Signup") == 0) {
		//printf("Enter your username,studentid,password with a space between\n ");
		int a = 0;
		char* buffer;
		fflush(stdin);
		input(&std.username);
		int b = scanf("%lld", &std.student_id);
		input(&std.password);
		while (!feof(users)) {
			input_file(&buffer, users);
			if (strcmp(buffer, std.username) == 0) {
				printf("The user already exist");
				a++;
				break;
			}
		}
		if (a == 0) {
			printf("done");
			fprintf(users, "%s %lld %s\n", std.username, std.student_id, std.password);
		}
	}
	else if (strcmp(Signup_Login, "Login") == 0) {
		//printf("Enter your username,password\n");
		char* buffer;
		char* buffer2;
		char* buffer3;
		fflush(stdin);
		input(&std.username);
		input(&std.password);
		int check_login = 0;
		while (!feof(users)) {
			input_file(&buffer, users);
			input_file(&buffer2, users);
			input_file(&buffer3, users);
			if ((strcmp(buffer, std.username) == 0) && (strcmp(buffer3, std.password))) {
				printf("welcome %s", std.username);
				check_login++;
				break;
			}
	while (1) {
				if ((strcmp(std.username, "admin") == 0) && (strcmp(std.password, "dmin") == 0)) {
					check_login++;
					printf("welcome admin\n");
					printf("choose from add_hall , add_food ,add_coupon \n");
					printf("to add hall you should type add_hall <name> <hall_id> <capacity>\nto add food you should type add_food <name> <food_id> <price> <hall_id> <day>\n ");
					char* vaziat;
					vaziat = (char*)malloc(100 * sizeof(char));
					char* temp;
					long long int temp2;
					int temp3;
					int x = 0;
					char* ghaza_name_buffer;
					long long int ghaza_id_buffer;
					long int ghaza_price_buffer;
					long long int ghaza_hall_id_buffer;
					long long int hall_hall_id_buffer;
					int ghaza_day_buffer;
					int ghaza_check_existence_hall = 0;
					int uniqness = 0;
					scanf("%s", vaziat);
					if (strcmp(vaziat, "logout") == 0) {
						printf("you are loged out\n");
						return 0;
					}
					if (strcmp(vaziat, "add_hall") == 0) {
						input(&salon.name);
						scanf("%lld", &salon.id);
						scanf("%d", &salon.Capacity);
						while (!feof(hall_file)) {
							input_file(&temp, hall_file);
							fscanf(hall_file, "%lld", &temp2);
							fscanf(hall_file, "%d", &temp3);
							if (temp2 == salon.id) {
								printf("hall id is not unique");
								x++;
								break;
							}
						}
						if (x == 0) {
							fprintf(hall_file, "%s %lld %d", salon.name, salon.id, salon.Capacity);
							printf("done\n");
							break;
						}
					}
					else if (strcmp(vaziat, "add_food") == 0) {
						input(&ghaza.name);
						scanf("%lld", &ghaza.id);
						scanf("%ld", &ghaza.price);
						scanf("%lld", &ghaza.hall.id);
						scanf("%d", &ghaza.day);
						while (!feof(food_file)) {
							input_file(&ghaza_name_buffer, food_file);
							fscanf(food_file, "%lld", &ghaza_id_buffer);
							fscanf(food_file, "%ld", &ghaza_price_buffer);
							fscanf(food_file, "%lld", &ghaza_hall_id_buffer);
							fscanf(food_file, "%d", &ghaza_day_buffer);
							while (!feof(hall_file)) {
								input_file(&temp, hall_file);
								fscanf(hall_file, "%lld", &hall_hall_id_buffer);
								fscanf(hall_file, "%d", &temp3);
								if (ghaza_hall_id_buffer == hall_hall_id_buffer) {
									ghaza_check_existence_hall++;
									break;
								}
							}
							if (ghaza_check_existence_hall == 0) { printf("wrong hall id\n"); }
							if (ghaza_id_buffer == ghaza.id) {
								printf("food id is not unique\n");
								uniqness++;
								break;
							}
						}
						if (uniqness == 0) {
							fprintf(food_file, "%s %lld %ld %lld %d", ghaza.name, ghaza.id, ghaza.price, ghaza.hall.id, ghaza.day);
							printf("done");
							break;
						}
					}
					else if (strcmp(vaziat, "add_coupon") == 0) {
						scanf("%lld", &takhfif.id);
						scanf("%d", &takhfif.percentage);
						scanf("%d", &takhfif.capacity);
						fprintf(takhfif_file, "%lld %d %d", takhfif.id, takhfif.percentage, takhfif.capacity);
					}
					else { printf("wrong syntax\n"); }
				}
			}
			if (check_login == 0)
			{
				printf("wrong usrename or pass\n");
			}
		}
	}
	fclose(users);
	fclose(hall_file);
	fclose(takhfif_file);
	return 0;
}