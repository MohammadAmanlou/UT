#include "bmp.hpp"

bool Image::fillAndAllocate(char*& buffer, const char* fileName, int& bufferSize) {
    std::ifstream file(fileName);
    if (!file) {
        std::cout << "File" << fileName << " doesn't exist!" << std::endl;
        return false;
    }
    
    file.seekg(0, std::ios::end);
    std::streampos length = file.tellg();
    file.seekg(0, std::ios::beg);
    
    buffer = new char[length];
    file.read(&buffer[0], length);

    PBITMAPFILEHEADER file_header;
    PBITMAPINFOHEADER info_header;

    file_header = (PBITMAPFILEHEADER)(&buffer[0]);
    info_header = (PBITMAPINFOHEADER)(&buffer[0] + sizeof(BITMAPFILEHEADER));
    rows = info_header->biHeight;
    cols = info_header->biWidth;
    bufferSize = file_header->bfSize;
    return true;
}

void Image::getPixelsFromBMP24(int end,  char* fileReadBuffer) {
    int count = 1;
    int extra = cols % 4;
    for (int i = 0; i < rows; i++) {
        count += extra;
        for (int j = cols - 1; j >= 0; j--) {
            for (int k = 0; k < 3; k++) {
                switch (k) {
                case 0:
                     red[i][j] =(fileReadBuffer[end - count]); // fileReadBuffer[end - count] is the red value
                    break;
                case 1:
                    // fileReadBuffer[end - count] is the green value
                    green[i][j] = (fileReadBuffer[end - count]) ;
                    break;
                case 2:
                    // fileReadBuffer[end - count] is the blue value
                    blue[i][j] = (fileReadBuffer[end - count]) ;
                    break;
                }
                count ++;
                // go to the next position in the buffer
            }
        }
    }
}

void Image::writeOutBmp24(char* fileBuffer, const char* nameOfFileToCreate, int bufferSize) {
    std::ofstream write(nameOfFileToCreate);
    if (!write) {
        std::cout << "Failed to write " << nameOfFileToCreate << std::endl;
        return;
    }

    int count = 1;
    int extra = cols % 4;
    for (int i = 0; i < rows; i++) {
        count += extra;
        for (int j = cols - 1; j >= 0; j--) {
            for (int k = 0; k < 3; k++) {
                switch (k) {
                case 0:
                    // write red value in fileBuffer[bufferSize - count]
                    fileBuffer[bufferSize - count] = red[i][j];
                    break;
                case 1:
                    // write green value in fileBuffer[bufferSize - count]
                    fileBuffer[bufferSize - count] = green[i][j];
                    break;
                case 2:
                    // write blue value in fileBuffer[bufferSize - count]
                    fileBuffer[bufferSize - count] = blue[i][j];
                    break;
                }
                count ++;
                // go to the next position in the buffer
            }
        }
    }
    write.write(fileBuffer, bufferSize);
}

void Image::flip_vertically() {
    for ( int row =0 ; row < rows/2 ; row++ ) {
        for ( int col =0 ; col < cols ; col++ ) {
            unsigned char tmp_red = red[row][col];
            unsigned char tmp_green = green[row][col];
            unsigned char tmp_blue = blue[row][col];
            red[row][col] = red[rows - 1 - row][col];
            green[row][col] = green[rows - 1 - row][col];
            blue[row][col] = blue[rows - 1 - row][col];
            red[rows - 1 - row][col] = tmp_red;
            green[rows - 1 - row][col] = tmp_green;
            blue[rows - 1 - row][col] = tmp_blue;
        }
    }
}

void Image::Gaussian_blur(){
    int filter[3][3] = {
        {1, 2, 1},
        {2, 4, 2},
        {1, 2, 1}
    };
    for ( int row =0 ; row < rows ; row++ ) {
        for ( int col =0 ; col < cols  ; col++ ) {
            int sum_red = 0;
            int sum_green = 0;
            int sum_blue = 0;
            for ( int i =0 ; i < 3 ; i++ ) {
                for ( int j =0 ; j < 3 ; j++ ) {
                    int row_index = row + i - 1;
                    int col_index = col + j - 1;
                    if (row_index < 0) {
                        row_index = 0;
                    }
                    if (row_index >= rows) {
                        row_index = rows - 1;
                    }
                    if (col_index < 0) {
                        col_index = 0;
                    }
                    if (col_index >= cols) {
                        col_index = cols - 1;
                    }
                    sum_red += red[row_index][col_index] * filter[i][j];
                    sum_green += green[row_index][col_index] * filter[i][j];
                    sum_blue += blue[row_index][col_index] * filter[i][j];
                }
            }
            red[row][col] = sum_red / 16;
            green[row][col] = sum_green / 16;
            blue[row][col] = sum_blue / 16;
        }
    }
}

void Image::purple_haze() {
    for ( int row =0 ; row < rows ; row++ ) {
        for ( int col =0 ; col < cols ; col++ ) {
            int tmp_red = 0.16 * red[row][col] + 0.5 * green[row][col] + 0.16 * blue[row][col];
            int tmp_green = (0.6 * red[row][col] + 0.2 * green[row][col] + 0.8 * blue[row][col]);
            int tmp_blue = (0.5* red[row][col] + 0.3 * green[row][col] + 0.5 * blue[row][col]);
            if (tmp_red > 255 ) {
                tmp_red = 255;
            }
            if (tmp_green > 255 ) {
                tmp_green = 255;
            }
            if (tmp_blue > 255 ) {
                tmp_blue = 255;
            }
            red[row][col] = (uint)tmp_red;
            green[row][col] = (uint)tmp_green;
            blue[row][col] = (uint)tmp_blue;
        }
    }
}

void Image::add_line(Point p1 , Point p2) {
    int x1 = p1.x;
    int y1 = p1.y;
    int x2 = p2.x;
    int y2 = p2.y;
    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;
    int err = dx - dy;
    while (true) {
        red[y1][x1] = 255;
        green[y1][x1] = 255;
        blue[y1][x1] = 255;
        if (x1 == x2 && y1 == y2) {
            break;
        }
        int e2 = 2 * err;
        if (e2 > -dy) {
            err = err - dy;
            x1 = x1 + sx;
        }
        if (e2 < dx) {
            err = err + dx;
            y1 = y1 + sy;
        }
    }
    
}

void Image::Hatching(){
    Point p1;
    Point p2;
    p1.x = rows - 1;
    p1.y = 0;
    p2.x = 0;
    p2.y = cols - 1;
    add_line(p1, p2);
    p1.x = 0;
    p1.y = cols / 2;
    p2.x = rows / 2;
    p2.y = 0;
    add_line(p1, p2);
    p1.x = rows / 2;
    p1.y = cols - 1;
    p2.x = rows - 1;
    p2.y = cols/2;
    add_line(p1, p2);
}


