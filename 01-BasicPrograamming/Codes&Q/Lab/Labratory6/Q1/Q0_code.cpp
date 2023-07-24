#include <stdio.h>
int main()
{
     FILE *inputFile;
     char charInPos;
     int i,numOfChars;
     inputFile=fopen("input_Q0.txt","r"); //File ready to be read from.
     if(inputFile==NULL) {
           printf("File does not exist..");
     }
     else{
	      fseek(inputFile,0,SEEK_END);
	      numOfChars =ftell(inputFile); //Num of File's characters
	      while(i<numOfChars)
	       {
	       		//Method goes in reverse
	            i++;
	            fseek(inputFile,-i,SEEK_END);
	            charInPos=fgetc(inputFile);
	            printf("%c",charInPos);
	      }
		}
		fclose(inputFile); //In the end of its use, we have to close it 
     return 0;
}