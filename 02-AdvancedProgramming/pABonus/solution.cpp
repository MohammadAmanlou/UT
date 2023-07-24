#include <iostream>
#include <vector>

#define NUMBER_OF_MOVES 4

using namespace std;

long int sum_up_the_elements_of_vector(vector <int> input_vector) {
    long int sum = 0;
    for (int element = 0; element < input_vector.size(); element++){
        sum += input_vector[element];
    }
    return sum;
}

long int find_element_of_max_of_vector(vector <long int> input_vector){
    long int max_number=0;
    int max_element = 0;
    for(int element = 0; element < input_vector.size(); element++){
        if (input_vector[element] > max_number){
            max_number = input_vector[element];
            max_element = element;
        }
    }
    return max_element;
}

int find_most_fertile_row(int number_of_rows, vector <vector <int>> &farm){
    vector <long int> row_sums;
    long int sum = 0;
    int best_row = 0;
    for(int row = 0; row < number_of_rows; row++){
        sum = sum_up_the_elements_of_vector(farm[row]);
        row_sums.push_back(sum);
        sum = 0;
        }
        best_row = find_element_of_max_of_vector(row_sums);
    return best_row;
}

long int sum_column(int column_number, int number_of_rows, vector <vector <int>> &farm){
    long int column_sum = 0;
    for(int row = 0; row < number_of_rows; row++){
            column_sum += farm[row][column_number];
        }
    return column_sum;
}

int find_most_fertile_column(int number_of_columns, int number_of_rows, vector <vector <int>> &farm){
    long int column_sum = 0;
    long int max_column = 0;
    int best_column = 0;
    for(int column = 0; column < number_of_columns; column++){
        column_sum = sum_column(column, number_of_rows, farm);
        if(column_sum > max_column){
            max_column = column_sum;
            best_column = column;
        }
        column_sum = 0;
    }
    return best_column;
}

long int update_harvest(long int max_column, long int max_row, long int &harvest){
    if(max_column > max_row){
        harvest += max_column;
    }
    else{
        harvest += max_row;
    }
    return harvest;
}

void update_farm(long int max_column, long int max_row, vector <vector <int>> &farm,
int number_of_most_fertile_column, int number_of_most_fertile_row, int number_of_rows, int number_of_columns){
    if(max_column > max_row){
        for(int row = 0; row < number_of_rows; row++){
            farm[row][number_of_most_fertile_column] = 0;
        }
    }
    else{
        for(int column = 0; column < number_of_columns; column++){
            farm[number_of_most_fertile_row][column] = 0;
        }
    }
}

long int solve(int number_of_rows, int number_of_columns, vector <vector <int>> &farm){
    vector <long int> row_sums;
    long int harvest = 0;
    long int max_row;
    int max_column = 0;
    int number_of_most_fertile_row = 0;
    int number_of_most_fertile_column = 0;
    for(int move = 0; move < NUMBER_OF_MOVES; move++) {
        number_of_most_fertile_row = find_most_fertile_row(number_of_rows, farm);
        max_row = sum_up_the_elements_of_vector(farm[number_of_most_fertile_row]);
        number_of_most_fertile_column = find_most_fertile_column(number_of_columns, number_of_rows, farm);
        max_column = sum_column(number_of_most_fertile_column, number_of_rows, farm);
        update_harvest(max_column, max_row, harvest);
        update_farm(max_column, max_row, farm,
        number_of_most_fertile_column, number_of_most_fertile_row, number_of_rows, number_of_columns);
        number_of_most_fertile_row = 0;
        number_of_most_fertile_column = 0;
        max_column = 0;
        max_row = 0;
    }
    return harvest;
}

void input(int number_of_rows, int number_of_columns, vector <vector <int>> &farm){
    int product;
    for(int row = 0; row < number_of_rows; row++){
        for(int column = 0; column < number_of_columns; column++){
            cin >> product;
            farm[row][column] = product;
        }
    }
}

int main() {
    int number_of_rows, number_of_columns;
    cin >> number_of_rows >> number_of_columns;
    vector <vector <int>> farm (number_of_rows, vector <int> (number_of_columns));
    input(number_of_rows, number_of_columns, farm);
    long int harvest = solve(number_of_rows, number_of_columns, farm);
    cout << harvest;
    return 0;
} 