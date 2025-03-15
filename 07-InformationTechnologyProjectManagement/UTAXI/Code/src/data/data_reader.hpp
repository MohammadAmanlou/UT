#ifndef __DATA_READER_H__
#define __DATA_READER_H__

#include <vector>
#include <string>
#include <fstream>

#include "../defines.hpp"
#include "../utils/general.hpp"

class DataReader
{
    public:
        DataReader();
        void read(std::string file_address);
        std::vector<std::string> provide_loc_raw_data(int index);

        int get_locs_num() { return locs_num; }

    private:
        std::vector<std::string> locs_raw_data;
        int locs_num;
};

#endif /* __DATA_READER_H__ */