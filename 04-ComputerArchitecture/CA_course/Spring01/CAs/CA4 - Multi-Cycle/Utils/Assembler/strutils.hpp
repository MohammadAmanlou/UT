#ifndef STRUTILS_HPP_INCLUDE
#define STRUTILS_HPP_INCLUDE

#include <algorithm>
#include <cctype>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

namespace strutils {

inline void trimLeft(std::string& str) {
    str.erase(str.begin(), std::find_if(str.begin(), str.end(), [](unsigned char ch) {
        return !std::isspace(ch);
    }));
}
inline void trimRight(std::string& str) {
    str.erase(std::find_if(str.rbegin(), str.rend(), [](unsigned char ch) {
        return !std::isspace(ch);
    }).base(), str.end());
}
inline void trim(std::string& str) {
    trimLeft(str);
    trimRight(str);
}

inline void rmWhitespace(std::string& str) {
    str.erase(std::remove_if(str.begin(), str.end(), [](unsigned char ch) {
        return std::isspace(ch);
    }), str.end());
}

inline std::vector<std::string> split(const std::string& str, char delim) {
    std::vector<std::string> result;
    std::istringstream sstr(str);
    std::string part;
    while (std::getline(sstr, part, delim)) {
        result.push_back(std::move(part));
    }
    return result;
}

inline std::vector<std::string> split(const std::string& str, const std::string& delim) {
    std::string::size_type startPos = 0;
    std::string::size_type endPos;

    std::vector<std::string> result;
    while ((endPos = str.find(delim, startPos)) != std::string::npos) {
        result.push_back(str.substr(startPos, endPos - startPos));
        startPos = endPos + delim.size();
    }
    result.push_back(str.substr(startPos));

    return result;
}

} // namespace strutils

#endif // STRUTILS_HPP_INCLUDE
