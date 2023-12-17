#ifndef BMP
#define BMP

#include <fstream>
#include <iostream>
#include <vector>
#include <chrono>

typedef int LONG;
typedef unsigned short WORD;
typedef unsigned int DWORD;

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
    private:
	    unsigned char** red;
	    unsigned char** green;
	    unsigned char** blue;
        int rows;
        int cols;
    public:
        Image(char*& buffer, const char* fileName_, int& bufferSize) {
            if (!fillAndAllocate(buffer,fileName_,bufferSize)){
                std::cout << "File read error" << std::endl;
                exit(1);
            }
            red = new unsigned char*[rows];
            green = new unsigned char*[rows];
            blue = new unsigned char*[rows];
            for (int i = 0; i < rows; i++) {
                red[i] = new unsigned char[cols];
                green[i] = new unsigned char[cols];
                blue[i] = new unsigned char[cols];
            }
        }
        bool fillAndAllocate(char*& buffer, const char* fileName, int& bufferSize) ;

        void getPixelsFromBMP24(int end, char* fileReadBuffer);

        void writeOutBmp24(char* fileBuffer, const char* nameOfFileToCreate, int bufferSize);

        void flip_vertically();

        void Gaussian_blur();

        void purple_haze();

        void Hatching();

        void add_line(Point p1, Point p2);

};




















#endif