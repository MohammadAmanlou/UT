#include "bmp.hpp"

int main(int argc, char* argv[]) {
    char* fileBuffer;
    int bufferSize;
	if(argc <= 1){
		std::cerr << "No file provided" << std::endl;
	}
    auto timeStart = std::chrono::high_resolution_clock::now();
    Image bpm(fileBuffer, argv[1], bufferSize);
    bpm.getPixelsFromBMP24( bufferSize, fileBuffer) ;
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
    bpm.writeOutBmp24(fileBuffer, "output.bmp", bufferSize);
    timeEnd = std::chrono::high_resolution_clock::now();
    std::cout << "Write Time: " << std::chrono::duration_cast<std::chrono::duration<float, std::milli>>(timeEnd - timeStart).count() << " ms\n";
	std::cout << "Done and the output is in output.bmp" << std::endl;

    return 0;
}