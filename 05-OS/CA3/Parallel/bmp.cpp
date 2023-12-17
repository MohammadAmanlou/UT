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

void* getPixelsFromBMP24(void * tid) {
    Image* img = (Image*)tid;
    int count = 1;
    int extra = img->cols % 4;
    for (int i = 0; i < img->rows; i++) {
        count += extra;
        for (int j = img->cols - 1; j >= 0; j--) {
            for (int k = 0; k < 3; k++) {
                switch (k) {
                case 0:
                     img->red[i][j] =(img->fileBuffer[img->bufferSize - count]); // fileReadBuffer[end - count] is the red value
                    break;
                case 1:
                    // fileReadBuffer[end - count] is the green value
                    img->green[i][j] = (img->fileBuffer[img->bufferSize - count]) ;
                    break;
                case 2:
                    // fileReadBuffer[end - count] is the blue value
                    img->blue[i][j] = (img->fileBuffer[img->bufferSize - count]) ;
                    break;

                }
                count ++;
                // go to the next position in the buffer
            }
        }
    }
    return (void*) 0;
}

void Image::getInput(){
    pthread_t threads[READ_NUM_THREAD];
    int return_code ;
    for (int i =0 ; i < READ_NUM_THREAD ; i++){
        return_code = pthread_create(&threads[i],NULL,getPixelsFromBMP24,this);
        if (return_code){
            std::cout << "Failed to create thread" << std::endl;
            exit(1);
        }
    }
    for (long i =0 ; i < READ_NUM_THREAD ; i++){
        return_code = pthread_join(threads[i],NULL);
        if (return_code){
            std::cout << "Failed to join thread" << std::endl;
            exit(1);
        }
    }
}

void* writeOutBmp24(void * tid) {
    Image* img = (Image*)tid;
    std::ofstream write(OUTPUT_NAME);
    if (!write) {
        std::cout << "Failed to write " << OUTPUT_NAME << std::endl;
        return (void*) 0;
    }

    int count = 1;
    int extra = img->cols % 4;
    for (int i = 0; i < img->rows; i++) {
        count += extra;
        for (int j = img->cols - 1; j >= 0; j--) {
            for (int k = 0; k < 3; k++) {
                switch (k) {
                case 0:
                    // write red value in fileBuffer[bufferSize - count]
                    img->fileBuffer[img->bufferSize - count] = img->red[i][j];
                    break;
                case 1:
                    // write green value in fileBuffer[bufferSize - count]
                    img->fileBuffer[img->bufferSize - count] = img->green[i][j];
                    break;
                case 2:
                    // write blue value in fileBuffer[bufferSize - count]
                    img->fileBuffer[img->bufferSize - count] = img->blue[i][j];
                    break;
                }
                count ++;
                // go to the next position in the buffer
            }
        }
    }
    write.write(img->fileBuffer, img->bufferSize);
    return (void*) 0;
}

void Image::writeOut(){
    pthread_t threads[READ_NUM_THREAD];
    int return_code ;
    for (int i =0 ; i < READ_NUM_THREAD ; i++){
        return_code = pthread_create(&threads[i],NULL,writeOutBmp24,this);
        if (return_code){
            std::cout << "Failed to create thread" << std::endl;
            exit(1);
        }
    }
    for (long i =0 ; i < READ_NUM_THREAD ; i++){
        return_code = pthread_join(threads[i],NULL);
        if (return_code){
            std::cout << "Failed to join thread" << std::endl;
            exit(1);
        }
    }
}

void * flip(void * tid) {
    Args* args = (Args*)tid;
    Image* img = args->img;
    int g = args->col;
    int start = (g) * ((img->cols)/FLIP_NUM_THREAD) ;
    int end = (g + 1) * ((img->cols)/FLIP_NUM_THREAD) ;
    for ( int row =0 ; row < img->rows/2 ; row++ ) {
        for ( int col = start  ; col < end ; col++ ) {
            unsigned char tmp_red = img->red[row][col];
            unsigned char tmp_green = img->green[row][col];
            unsigned char tmp_blue = img->blue[row][col];
            img->red[row][col] = img->red[img->rows - 1 - row][col];
            img->green[row][col] = img->green[img->rows - 1 - row][col];
            img->blue[row][col] = img->blue[img->rows - 1 - row][col];
            img->red[img->rows - 1 - row][col] = tmp_red;
            img->green[img->rows - 1 - row][col] = tmp_green;
            img->blue[img->rows - 1 - row][col] = tmp_blue;
        }
    }
    return (void*) 0;
}

void Image::flip_vertically() {
    pthread_t threads[FLIP_NUM_THREAD];
    int return_code ;
    std::vector<Args *> args;
    for (long i =0 ; i < FLIP_NUM_THREAD ; i++){
        args.push_back(new Args);
        args[i]->img = this;
        args[i]->col = i;
        return_code = pthread_create(&threads[i],NULL,flip,args[i]);
        if (return_code){
            std::cout << "Failed to create thread" << std::endl;
            exit(1);
        }
    }
    for (long i =0 ; i < FLIP_NUM_THREAD ; i++){
        return_code = pthread_join(threads[i],NULL);
        if (return_code){
            std::cout << "Failed to join thread" << std::endl;
            exit(1);
        }
    }
}

void *blur(void * tid) {
    int filter[3][3] = {
        {1, 2, 1},
        {2, 4, 2},
        {1, 2, 1}
    };
    Args* args = (Args*)tid;
    Image* img = args->img;
    int g = args->col;
    int start = (g) * ((img->cols)/GAUSSIAN_NUM_THREAD) ;
    int end = (g + 1) * ((img->cols)/GAUSSIAN_NUM_THREAD) ;
    for ( int row =0 ; row < img->rows ; row++ ) {
        for ( int col = start ; col < end  ; col++ ) {
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
                    if (row_index >= img->rows) {
                        row_index = img->rows - 1;
                    }
                    if (col_index < 0) {
                        col_index = 0;
                    }
                    if (col_index >= img->cols) {
                        col_index = img->cols - 1;
                    }
                    sum_red += img->red[row_index][col_index] * filter[i][j];
                    sum_green += img->green[row_index][col_index] * filter[i][j];
                    sum_blue += img ->blue[row_index][col_index] * filter[i][j];
                }
            }
            img->red[row][col] = sum_red / 16;
            img->green[row][col] = sum_green / 16;
            img->blue[row][col] = sum_blue / 16;
        }
    }
    return (void*) 0;
}

void Image::Gaussian_blur(){
    pthread_t threads[GAUSSIAN_NUM_THREAD];
    int return_code ;
    std::vector<Args *> args;
    for (long i =0 ; i < GAUSSIAN_NUM_THREAD ; i++){
        args.push_back(new Args);
        args[i]->img = this;
        args[i]->col = i;
        return_code = pthread_create(&threads[i],NULL,blur,args[i]);
        if (return_code){
            std::cout << "Failed to create thread" << std::endl;
            exit(1);
        }
    }
    for (long i =0 ; i < GAUSSIAN_NUM_THREAD ; i++){
        return_code = pthread_join(threads[i],NULL);
        if (return_code){
            std::cout << "Failed to join thread" << std::endl;
            exit(1);
        }
    }
}

void *purple(void * tid){
    Args* args = (Args*)tid;
    Image* img = args->img;
    int g = args->col;
    int start = (g) * ((img->cols)/PURPLE_NUM_THREAD) ;
    int end = (g + 1) * ((img->cols)/PURPLE_NUM_THREAD) ;
    for ( int row =0 ; row < img->rows ; row++ ) {
        for ( int col =start ; col < end ; col++ ) {
            int tmp_red = 0.16 * img->red[row][col] + 0.5 * img->green[row][col] + 0.16 * img->blue[row][col];
            int tmp_green = (0.6 * img->red[row][col] + 0.2 * img->green[row][col] + 0.8 * img->blue[row][col]);
            int tmp_blue = (0.5* img->red[row][col] + 0.3 * img->green[row][col] + 0.5 * img->blue[row][col]);
            if (tmp_red > 255 ) {
                tmp_red = 255;
            }
            if (tmp_green > 255 ) {
                tmp_green = 255;
            }
            if (tmp_blue > 255 ) {
                tmp_blue = 255;
            }
            img->red[row][col] = (uint)tmp_red;
            img->green[row][col] = (uint)tmp_green;
            img->blue[row][col] = (uint)tmp_blue;
        }
    }
    return (void*) 0;
}

void Image::purple_haze() {
    pthread_t threads[PURPLE_NUM_THREAD];
    int return_code ;
    std::vector<Args *> args;
    for (long i =0 ; i < PURPLE_NUM_THREAD ; i++){
        args.push_back(new Args);
        args[i]->img = this;
        args[i]->col = i;
        return_code = pthread_create(&threads[i],NULL,purple,args[i]);
        if (return_code){
            std::cout << "Failed to create thread" << std::endl;
            exit(1);
        }
    }
    for (long i =0 ; i < PURPLE_NUM_THREAD ; i++){
        return_code = pthread_join(threads[i],NULL);
        if (return_code){
            std::cout << "Failed to join thread" << std::endl;
            exit(1);
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

void* hatch(void* tid){
    Args* args = (Args*)tid;
    Image* img = args->img;
    int g = args->col;
    Point p1;
    Point p2;
    if(g == 0){
        p1.x = img->rows - 1;
        p1.y = 0;
        p2.x = 0;
        p2.y = img->cols - 1;
        img->add_line(p1, p2);
    }
    if(g==1){
        p1.x = 0;
        p1.y = img->cols / 2;
        p2.x = img->rows / 2;
        p2.y = 0;
        img->add_line(p1, p2);
    }
    if(g==2){
        p1.x = img->rows / 2;
        p1.y = img->cols - 1;
        p2.x = img->rows - 1;
        p2.y = img->cols/2;
        img->add_line(p1, p2); 
    }
    return (void*) 0;
}

void Image::Hatching(){
    pthread_t threads[PURPLE_NUM_THREAD];
    int return_code ;
    std::vector<Args *> args;
    for (long i =0 ; i < HATCH_NUM_THREAD ; i++){
        args.push_back(new Args);
        args[i]->img = this;
        args[i]->col = i;
        return_code = pthread_create(&threads[i],NULL,hatch,args[i]);
        if (return_code){
            std::cout << "Failed to create thread" << std::endl;
            exit(1);
        }
    }
    for (long i =0 ; i < HATCH_NUM_THREAD ; i++){
        return_code = pthread_join(threads[i],NULL);
        if (return_code){
            std::cout << "Failed to join thread" << std::endl;
            exit(1);
        }
    }
}


int main(int argc, char* argv[]) {
    char* fileBuffer;
    int bufferSize;
	if(argc <= 1){
		std::cerr << "No file provided" << std::endl;
	}
    Image bpm(fileBuffer, argv[1], bufferSize , 1);
    auto timeStart = std::chrono::high_resolution_clock::now();
    bpm.getInput() ;
    auto timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Read Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
    timeStart = std::chrono::high_resolution_clock::now();
    bpm.flip_vertically();
    timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Flip Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
    timeStart = std::chrono::high_resolution_clock::now();
    bpm.Gaussian_blur();
    timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Gaussian blur Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
    timeStart = std::chrono::high_resolution_clock::now();
    bpm.purple_haze();
    timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Purple Haze Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
    timeStart = std::chrono::high_resolution_clock::now();
    bpm.Hatching();
    timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Hatching Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
    timeStart = std::chrono::high_resolution_clock::now();
    bpm.writeOut();
    timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Write Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
    std::cout << "Done and the output is in output.bmp" << std::endl;

    return 0;
}