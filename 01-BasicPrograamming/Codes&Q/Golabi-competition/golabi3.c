#include <stdio.h>
#include <windows.h>
#include <stdlib.h>
#include <conio.h>

int points=0,timer=0,zarib=1;

int main();


void lose(){
    system("cls");
    printf("You Lost:( \n");
    printf("Your Score:%d \n",points);
    printf("Press Any key to play again or Ctrl+C to exit \n");
    getchar();
    points=0;
    timer=0;
    zarib=1;
    main();
    //exit(42);
}
void width(int ret[]) {
    CONSOLE_SCREEN_BUFFER_INFO csbi;
    int columns,rows;

    GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
    columns = csbi.srWindow.Right - csbi.srWindow.Left;
	rows = csbi.srWindow.Bottom - csbi.srWindow.Top+1;
	ret[0]=rows;
	ret[1]=columns;
}

int obs1(int width){
    static int ret=60;
    if (ret<=0){
        ret=(width+(rand()%10));
    }
    if(ret>width/5 && width/5+zarib>=ret)ret=width/5;
    else ret-=zarib;
    return ret;
}

int obs2(int width){
    static int ret=0;
    if (ret<=0){
        ret=(width+(rand()%10));
    }
    if(ret>width/5 && width/5+zarib>=ret)ret=width/5;
    else ret-=zarib;
    return ret;
}


void draw_line(int dino,int obs1,int obs2,int columns,int line){
	if(dino==1&&(columns/5==obs1 || columns/5==obs2))lose();
    for(int i=0;i<columns;i++){
		if(dino==1 && i==columns/5){
			fputs("#",stdout);
		}else if(i==obs1 || i==obs2){
			fputs("|",stdout);
		}else if (line==1){
			fputs("_",stdout);
		}else{
			fputs(" ",stdout);
		}
	}
	puts("");
}

void draw(int state){
	int a[2]={0};
	width(a);
	int floor =a[0]/3*2-3;
	int columns =a[1];
    int o1=obs1(columns),o2=obs2(columns);
	printf("Score : %d",points);
    for (int i = 0; i < floor; i++) puts("");
    if(state==0||state==-1){
		draw_line(0,-1,-1,columns,0);
        draw_line(0,-1,-1,columns,0);
		draw_line(0,-1,-1,columns,0);
		draw_line(1,o1,o2,columns,0);
		draw_line(1,o1,o2,columns,1);
	}else if(state==2||state==5){
		draw_line(0,-1,-1,columns,0);
        draw_line(1,-1,-1,columns,0);
		draw_line(1,-1,-1,columns,0);
		draw_line(0,o1,o2,columns,0);
		draw_line(0,o1,o2,columns,1);
	}else if(state==1||state==6){
		draw_line(0,-1,-1,columns,0);
        draw_line(0,-1,-1,columns,0);
		draw_line(1,-1,-1,columns,0);
		draw_line(1,o1,o2,columns,0);
		draw_line(0,o1,o2,columns,1);
	}else if(state==3||state==4){
		draw_line(1,-1,-1,columns,0);
        draw_line(1,-1,-1,columns,0);
		draw_line(0,-1,-1,columns,0);
		draw_line(0,o1,o2,columns,0);
		draw_line(0,o1,o2,columns,1);
	}
}
void hidecursor() {
	HANDLE consoleHandle = GetStdHandle(STD_OUTPUT_HANDLE);
	CONSOLE_CURSOR_INFO info;
	info.dwSize = 100;
	info.bVisible = FALSE;
	SetConsoleCursorInfo(consoleHandle , &info);
}

int main() {
    hidecursor();
    int hit=0,state=-1;
	while(hit==0){
		if(state==-1 && kbhit()){
            state=6;
			draw(state);
			getch();
		}else{
			draw(state);
		}
		usleep(50000);
		system("cls");
        if(state!=-1)state--;
        timer++;
        points+=zarib;
        if(zarib<5)zarib=(timer/100+1);
	}

	//getch();
	return 0;
}
