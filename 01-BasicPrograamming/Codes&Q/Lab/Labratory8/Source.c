#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define ZERO 0
#define ONE 1
typedef struct icsp_student icsp_std;
struct icsp_student { //1
	char* first_name;
	char* last_name;
	char* student_number;
	float mid_term_exam_score;
	float final_exam_score;
	float homework_score;
	struct icsp_student* next;
};
icsp_std* creat_list() { //2
	icsp_std* std = (icsp_std*)malloc(sizeof(icsp_std));
	std->next = NULL;
	return std;
}
int is_last(icsp_std* std) { //2
	if (std == NULL) return 0;
	if (std->next == NULL) return 1;
	return 0;
}
int set_new_std_next_of_head(icsp_std* head_of_list, icsp_std* new_std) { //3
	if (new_std == NULL || head_of_list == NULL)		return 0;
	new_std->next = head_of_list->next;
	head_of_list->next = new_std;
	return 1;
}
int add_to_i(icsp_std* head_of_list, icsp_std* new_std, int i) { //3
	if (i == 1) {
		set_new_std_next_of_head(head_of_list, new_std);
		return 1;
	}
	if (head_of_list == NULL)
		return ZERO;
	icsp_std* current_std = head_of_list->next;
	if (current_std == NULL && i == ZERO) {
		head_of_list->next = new_std;
		return ONE;
	}
	else if (current_std == NULL && i != ZERO) {
		return ZERO;
	}
	int counter = 1;
	while (1) {
		if (counter == i - 1) {
			icsp_std* ptr = current_std;
			current_std = current_std->next;
			ptr->next = new_std;
			new_std->next = current_std;
			return ONE;
		}
		counter++;
		if (current_std->next == NULL && counter == i) {
			current_std->next = new_std;
			new_std->next = NULL;
			return ONE;
		}
		if (current_std->next == NULL && counter < i) {
			return ZERO;
		}
		current_std = current_std->next;
	}
}
char* read_line_from_input_file(FILE* input) {
	int line_length = ZERO;
	char* line = (char*)malloc(sizeof(char));
	*(line) = '0';
	char temp_char[1] = { ' ' };
	while (1) {  
		fread(temp_char, sizeof(char), ONE, input);
		line_length++;
		line = (char*)realloc(line, sizeof(char) * line_length);
		line[line_length - ONE] = NULL;
		switch (temp_char[ZERO]) {
		case '\n':
			return line;
			break;
		case EOF:
			return line;
			break;
		default:
			line[line_length - ONE] = temp_char[ZERO];
			break;
		}
	}
}
icsp_std** read_students_credentials_from_file(char* file_name) {
	FILE* input;
	if (input = fopen(file_name, "r")) {
		int num_of_lines = atoi(read_line_from_input_file(input));
		/*icsp_std** students = (icsp_student**)malloc(sizeof(icsp_std*) * num_of_lines);*/ // ba cpp neveshtan 
		icsp_std** students = (icsp_std**)malloc(sizeof(icsp_std*) * num_of_lines);
		for (int i = 0; i < num_of_lines; i++) {
			icsp_std* std = (icsp_std*)malloc(sizeof(icsp_std));
			std->first_name = read_line_from_input_file(input);
			std->last_name = read_line_from_input_file(input);
			std->student_number = read_line_from_input_file(input);
			std->mid_term_exam_score = atof(read_line_from_input_file(input));
			std->final_exam_score = atof(read_line_from_input_file(input));
			std->homework_score = atof(read_line_from_input_file(input));
			// Somthing is missing. find it! <<-----------------------------------------------------------------------------------------------------<<
			students[i] = std;
		}
		fclose(input);
		return students;
	}
	return NULL;
}

char* read_unlimited(FILE* students) {
	char c;
	int i = 1;
	char* name = (char*)malloc(sizeof(char));
	fscanf(students, "%c", &c);
	while (c != '\n' && c != ' ' && !feof(students)) {
		i++;
		name = (char*)realloc(name, i * sizeof(char*));
		name[i - 2] = c;
		name[i - 1] = NULL;
		fscanf(students, "%c", &c);
	}
	return name;
}

void printf_list(icsp_std* head) {
	if (head->next == NULL) printf("is empty\n");
	else head = head->next;
	while (head) {
		printf("%s %s %s %f %f %f\n", head->first_name, head->last_name, head->student_number, head->final_exam_score, head->homework_score, head->mid_term_exam_score);
		head = head->next;
	}
}

char* read_unlimited_from_screen() {
	char* name = (char*)malloc(sizeof(char));
	char c;
	int i = 1;
	scanf("%c", &c);
	while (c != '\n' && c != ' ') {
		i++;
		name = (char*)realloc(name, i * sizeof(char*));
		name[i - 2] = c;
		name[i - 1] = NULL;
		scanf("%c", &c);
	}
	return name;
}
/*void printf_list(icsp_std* head) {
	if (head->next == NULL) printf("is empty\n");
	else head = head->next;
	while (head) {
		printf("%s %s %s %f %f %f\n", head->first_name, head->last_name, head->student_number, head->final_exam_score, head->homework_score, head->mid_term_exam_score);
		head = head->next;
	}
}*/
icsp_std* student_data(icsp_std* head, char* student_number) {
	head = head->next;
	while (head) {
		if (!strcmp(head->student_number, student_number)) {
			return head;
		}
		head = head->next;
	}

	return NULL;
}
int delete_std(icsp_std* head, char* std_number) {
	icsp_std* ptr = head->next;
	while (ptr) {
		if (!strcmp(ptr->student_number, std_number)) {
			head->next = ptr->next;
			free(ptr);
			return 1;
		}
		head = head->next;
		ptr = ptr->next;
	}
	return 0;
}
int delete_all(icsp_std* head) {
	if (head->next->next != NULL) delete_all(head->next);
	if (head->next->next == NULL) {
		free(head->next);
		return 1;
	}
}
void Sort(icsp_std* st1, icsp_std* st2)
{
	if (atof(st1->student_number) < atof(st2->student_number))
	{
		icsp_std* temp = st1->next;
		st1->next = st2;
		st2->next = temp;
	}
}
icsp_std* namesort(icsp_std* head)
{
	if (head->next == NULL || head==NULL) { return head; }
	if (strcmp(head, head->next) > 0) {
		head->next = head->next->next;
		head->next->next = head;
	}
	head->next = namesort(head->next);
	return head;
}
int swap_nodes(icsp_std* head, int i, int j) {
	icsp_std* ith_node = head, * jth_node = head;
	for (int k = 1; k < i; k++) {
		if (ith_node->next == NULL) return 0;
		ith_node = ith_node->next;

	}
	for (int k = 1; k < j; k++) {

		if (jth_node->next == NULL) return 0;
		jth_node = jth_node->next;
	}
	if (ith_node->next == NULL || jth_node->next == NULL) return 0;
	else {
		icsp_std* temp = jth_node->next;
		jth_node->next = ith_node->next;
		jth_node->next->next = temp->next;
		icsp_std* temp1;
		temp->next = ith_node->next->next;
		ith_node->next = temp;

	}
}
int list_length(icsp_std* head) {
	int counter = 0;
	while (head) {
		counter++;
		head = head->next;
	}
	return --counter;
}
int main() {
	icsp_std* head = creat_list();
	//problem 4&5&6 , reed from file
	FILE* students = fopen("input.txt", "r+");
	while (!feof(students)) {
		char* first_name, * last_name, * student_number;
		first_name = (char*)malloc(sizeof(char));
		last_name = (char*)malloc(sizeof(char));
		student_number = (char*)malloc(sizeof(char));
		float midterm_score, final_score, homework_score;
		first_name = read_unlimited(students);
		if (first_name[0] < 32 || first_name[0]>125) continue;
		last_name = read_unlimited(students);
		student_number = read_unlimited(students);
		fscanf(students, "%f %f %f", &midterm_score, &final_score, &homework_score);
		icsp_std* new_std = creat_list();
		new_std->final_exam_score = final_score;
		new_std->first_name = first_name;
		new_std->homework_score = homework_score;
		new_std->last_name = last_name;
		new_std->mid_term_exam_score = midterm_score;
		new_std->student_number = student_number;
		set_new_std_next_of_head(head, new_std);
	}
	/*char* first_name, * last_name, * student_number;
	first_name = (char*)malloc(sizeof(char));
	last_name = (char*)malloc(sizeof(char));
	student_number = (char*)malloc(sizeof(char));
	float midterm_score, final_score, homework_score;
	int i;
	first_name = read_unlimited_from_screen();
	last_name = read_unlimited_from_screen();
	student_number = read_unlimited_from_screen();
	scanf(" %f %f %f", &midterm_score, &final_score, &homework_score);
	printf_list(head);
	printf("where?\n");
	scanf("%d", &i);
	icsp_std* new_std = creat_list();
	new_std->final_exam_score = final_score;
	new_std->first_name = first_name;
	new_std->homework_score = homework_score;
	new_std->last_name = last_name;
	new_std->mid_term_exam_score = midterm_score;
	new_std->student_number = student_number;
	add_to_i(head, new_std, i);*/



	/*char* requested_student = (char*)malloc(sizeof(char));
	requested_student = read_unlimited_from_screen();
	icsp_std *req_student = student_data(head, requested_student);
	if (req_student == NULL) printf("this srudent number doesnt exist");
	else printf("%s", req_student->first_name);*/


	/*char* requested_student = (char*)malloc(sizeof(char));
	requested_student = read_unlimited_from_screen();
	if (delete_std(head, requested_student)) printf("done");
	else printf("cant do that");*/
	//printf_list(head);
	//print_reverse(head->next); 
	//printf("%d\n", list_length(head));
	//printf_list(head);
	fclose(students);
	for (int i=0 ; i< list_length(head) ; i++){
		namesort(head);
	}
	printf_list(head);
	delete_all(head);
	head = NULL;
}
