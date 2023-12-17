#ifndef BMP
#define BMP

#include <fstream>
#include <iostream>
#include <vector>
#include <pthread.h>
#include <chrono>

typedef int LONG;
typedef unsigned short WORD;
typedef unsigned int DWORD;

#define READ_NUM_THREAD 2
#define FLIP_NUM_THREAD 3
#define GAUSSIAN_NUM_THREAD 5
#define PURPLE_NUM_THREAD 5
#define HATCH_NUM_THREAD 3

#define OUTPUT_NAME "output.bmp"

#pragma pack(push, 1)
typedef struct tagBITMAPFILEHEADER {
    WORD bfType;
    DWORD bfSize;
    WORD bfReserved1;
    WORD bfReserved2;
    DWORD bfOffBits;
} BITMAPFILEHEADER, *PBITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER {
    DWORD biSize;
    LONG biWidth;
    LONG biHeight;
    WORD biPlanes;
    WORD biBitCount;
    DWORD biCompression;
    DWORD biSizeImage;
    LONG biXPelsPerMeter;
    LONG biYPelsPerMeter;
    DWORD biClrUsed;
    DWORD biClrImportant;
} BITMAPINFOHEADER, *PBITMAPINFOHEADER;
#pragma pack(pop)


typedef struct Point {
	int x;
	int y;
}Point;

class Image {
    public:
	    unsigned char** red;
	    unsigned char** green;
	    unsigned char** blue;
		char* fileBuffer;
    	int bufferSize;
        int rows;
        int cols;
        int thread_code;
        Image(char*& buffer_, const char* fileName_, int& bufferSize_ , int mode) {
            if(mode){
            if (!fillAndAllocate(buffer_,fileName_,bufferSize_)){
                std::cout << "File read error" << std::endl;
                exit(1);

            }
			fileBuffer = buffer_;
			bufferSize = bufferSize_;
            red = new unsigned char*[rows];
            green = new unsigned char*[rows];
            blue = new unsigned char*[rows];
            for (int i = 0; i < rows; i++) {
                red[i] = new unsigned char[cols];
                green[i] = new unsigned char[cols];
                blue[i] = new unsigned char[cols];
            }}
        }
        bool fillAndAllocate(char*& buffer, const char* fileName, int& bufferSize) ;

        //void writeOutBmp24(char* fileBuffer, const char* nameOfFileToCreate, int bufferSize);

        void flip_vertically();

        void Gaussian_blur();

        void purple_haze();

        void Hatching();

        void add_line(Point p1, Point p2);

		void getInput();

        void writeOut();

};



typedef struct Args{
    Image * img;
    int col;
}Args;

















#endif