
#include "utils.h"


#define MAX_PORT 65535
#define MAX_FOOD_SIZE 128

int random_port() {
	 srand(time(NULL) );
	 int random_port =  rand() % (MAX_PORT - TCP_RANGE);
    random_port += TCP_RANGE;
	 return random_port;
	// Seed the random number generator
}

void getInput(int fd, const char* request, char* dst, size_t dstLen){
    if(request!= NULL){
        write(STDOUT_FILENO,request,strlen(request));
    }
    int dstSize=read(fd,dst,dstLen);
    if(dstSize<=  0){
        printf("Error: Something Went Wrong\n");
        exit(EXIT_FAILURE);
    }
    dst[dstSize-1]='\0';
}

int strToPort(const char* str){
    //write(STDOUT_FILENO,str,strlen(str));
    /*int res=0;
    if (str[0] == '\0') {
        printf("Error: Empty string\n");
        exit(EXIT_FAILURE);
    }
    while (*str != '\0') {
        if(!isdigit(*str)) {
            
        }
        res = res * 10 + (*str - '0');
        str++;
    }*/
    int res = atoi(str);
    if(res > MAX_PORT){
        printf("Error: Port number out of range\n");
        exit(EXIT_FAILURE);
    }
    return res;

}

char** tokenize(char* str, const char* delimiter) {
    // Initialize variables
    int numTokens = 0;
    char** tokens = NULL;
    char* token = strtok(str, delimiter);

    // Tokenize the string
    while (token != NULL) {
        // Reallocate memory for tokens
        tokens = (char**) realloc(tokens, sizeof(char*) * (numTokens + 1));
        
        // Copy token to dynamic memory
        tokens[numTokens] = (char*) malloc(strlen(token) + 1);
        strcpy(tokens[numTokens], token);
        
        // Move to the next token
        token = strtok(NULL, delimiter);
        numTokens++;
    }
    
    // Add a NULL terminator to the end of the token array
    tokens = (char**) realloc(tokens, sizeof(char*) * (numTokens + 1));
    tokens[numTokens] = NULL;
    
    return tokens;
}

void checkStart(int argc){
    if(argc != 2){
        printf("Error: Wrong number of arguments\n");
        exit(EXIT_FAILURE);
    }
}


char * strConcat(char* src, char* catStr,int dist){
    char strC[MAX_BUFF];
    strncpy(strC, src, dist);
    strC[dist] = '\0';
    strcat(strC, " ");
    strcat(strC, catStr);
    strcat(strC, " ");
    strcat(strC, src + dist);
}

void cliInit(){
    //write(STDOUT_FILENO,"\x1B[2K\r",6);
    write(STDOUT_FILENO, ANSI_WHT ">> " ANSI_RST, 12);
}

char* readFile(){    
    int fd = open("recipes.json", O_RDONLY);
    if (fd == -1) {
        perror("Failed to open file");
    }

    struct stat file_stat;
    if (fstat(fd, &file_stat) == -1) {
        perror("Failed to get file information");
        close(fd);
    }

    char* json_data = (char*)malloc(file_stat.st_size + 1);

    ssize_t read_size = read(fd, json_data, file_stat.st_size);
    close(fd);
    json_data[read_size] = '\0';

    return json_data;
} 

int extractFoodsFromJson(const char* json_data , Recipe* foods) {
    int arraySize = 20;
    const char* ptr = json_data;
    int numOfFoods = 0;
    while (1) {
        // Find the next food
        const char* foodStart = strchr(ptr, '"');
        if (foodStart == NULL) {
            break;
        }

        const char* foodEnd = strchr(foodStart + 1, '"');
        if (foodEnd == NULL) {
            break;
        }

        int foodNameLength = foodEnd - foodStart - 1;
        if (foodNameLength >= NAME_SIZE) {
            foodNameLength = NAME_SIZE - 1;
        }
        strncpy(foods[numOfFoods].name, foodStart + 1, foodNameLength);
        foods[numOfFoods].name[foodNameLength] = '\0';
        const char* ingStart = strchr(foodEnd, '{');
        if (ingStart == NULL) {
            break;
        }
        const char* ingEnd = strchr(ingStart, '}');
        if (ingEnd == NULL) {
            break;
        }
        int numOfIngs = 0;
        const char* ingPtr = ingStart;
        while (1) {
            const char* ingNameStart = strchr(ingPtr, '"');
            if (ingNameStart == NULL || ingNameStart > ingEnd) {
                break;
            }
            const char* ingNameEnd = strchr(ingNameStart + 1, '"');
            if (ingNameEnd == NULL || ingNameEnd > ingEnd) {
                break;
            }
            int ingNameLength = ingNameEnd - ingNameStart - 1;
            if (ingNameLength >= NAME_SIZE) {
                ingNameLength = NAME_SIZE - 1;
            }
            strncpy(foods[numOfFoods].ings[numOfIngs].name, ingNameStart + 1, ingNameLength);
            foods[numOfFoods].ings[numOfIngs].name[ingNameLength] = '\0';
            const char* colon = strchr(ingNameEnd, ':');
            if (colon == NULL || colon > ingEnd) {
                break;
            }
            const char* comma = strchr(colon, ',');
            if (comma == NULL || comma > ingEnd) {
                comma = ingEnd;
            }
            foods[numOfFoods].ings[numOfIngs].quantity = atoi(colon + 1);
            ingPtr = comma + 1;
            numOfIngs++;
        }
        numOfFoods++;
        ptr = ingEnd + 1;
    }
    return numOfFoods;
}

int getFoods(Recipe * foods){
    char* json_data=readFile();
    //Recipe* foods = (Recipe*)malloc(20 * sizeof(Recipe));
    int n = extractFoodsFromJson(json_data, foods);
    free(json_data);
    return n;
    
}