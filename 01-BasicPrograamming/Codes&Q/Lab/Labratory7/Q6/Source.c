#include <stdio.h>
struct Student
{
	int studentNumber;
	char Name[25];
	int CourseMark[3];//student took only 3 courses 
	float Avg;
};

int main()
{
	//simple structure
	int i, j;
	struct Student S;
	printf("\nEnter Student Number : ");
	scanf("%d", &S.studentNumber);
	printf("\nEnter Student Name : ");
	scanf("%s", &S.Name);
	int Total = 0;
	for (i = 0; i < 3; i++)
	{
		printf("\n\nEnter Mark %d : ", i + 1);
		scanf("%d", &S.CourseMark[i]);

		Total = Total + S.CourseMark[i];
	}
	S.Avg = Total / 3;
	printf("\nstudent Number : %d", S.studentNumber);
	printf("\nName : %s", S.Name);
	printf("\nAverage : %f", S.Avg);

	//Array of structures
	struct Student Ss[3];
	printf("\n\n");
	for (j = 0; j < 3; j++) {
		printf("\nEnter Student Number : ");
		scanf("%d", &Ss[j].studentNumber);
		printf("\nEnter Student Name : ");
		scanf("%s", &Ss[j].Name);
		int Total = 0;
		for (i = 0; i < 3; i++)
		{
			printf("\nEnter Mark %d : ", i + 1);
			scanf("%d", &Ss[j].CourseMark[i]);

			Total = Total + Ss[j].CourseMark[i];
		}
		Ss[j].Avg = Total / 3;
	}
	printf("\n\n");
	for (j = 0; j < 3; j++) {
		printf("\nstudentNumber of student %d in list : %d\n", j, Ss[j].studentNumber);
		printf("\nName of student %d in list : %s\n", j, Ss[j].Name);
		printf("\nAverage of student %d in list : %f\n", j, Ss[j].Avg);
	}

	return 0;
}

