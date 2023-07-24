#include <algorithm>
#include <bitset>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

#include "assembler.hpp"
#include "strutils.hpp"

inline const char OUTPUT_FILE[] = "instructions.txt";
constexpr char COMMENT = '#';

struct Input {
    static std::vector<Asm::MachineInst> get(std::istream& is) {
        std::unordered_map<std::string, int> labelMap;
        std::stringstream sstr; // store instructions for the second pass

        std::size_t instCount = 0;
        std::string line;
        while (std::getline(is, line)) {
            strutils::trimLeft(line);
            if (line.empty()) continue;

            std::size_t pos = line.find(COMMENT);
            if (pos == 0) continue;
            else if (pos != std::string::npos) {
                line.erase(line.begin() + pos, line.end());
            }
            strutils::trimRight(line);

            std::replace(line.begin(), line.end(), '\t', ' ');

            if (line.find(':') != std::string::npos) { // label
                labelMap[line.substr(0, line.size() - 1)] = instCount;
            }
            else {
                ++instCount;
                sstr << line << '\n';
            }
        }

        std::vector<Asm::MachineInst> result;
        result.reserve(instCount);

        instCount = 0;
        while (std::getline(sstr, line)) {
            std::size_t pos = line.find(' ');
            if (pos != std::string::npos) line[pos] = ',';
            strutils::rmWhitespace(line);
            result.push_back(Asm::assemble(strutils::split(line, ','), labelMap, instCount));
            ++instCount;
        }

        return result;
    }

    static std::vector<Asm::MachineInst> fromFile(const std::string& filename) {
        std::ifstream file(filename);
        if (!file.is_open()) {
            using namespace std::string_literals;
            throw std::invalid_argument("File ("s + filename + ") could not be opened, or does not exist."s);
        }
        return get(file);
    }

    static std::vector<Asm::MachineInst> fromStdin() {
        return get(std::cin);
    }
};

int main(int argc, char** argv) {
    try {
        std::vector<Asm::MachineInst> result;

        if (argc > 1) result = Input::fromFile(argv[1]);
        else result = Input::fromStdin();

        // std::ofstream file(OUTPUT_FILE);
        for (const auto i : result) {
            std::cout << std::bitset<32>(i) << '\n';
        }
    }
    catch (const std::invalid_argument& ex) {
        std::cerr << ex.what() << '\n';
        return EXIT_FAILURE;
    }
    catch (const std::out_of_range& ex) {
        std::cerr << ex.what() << '\n';
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
