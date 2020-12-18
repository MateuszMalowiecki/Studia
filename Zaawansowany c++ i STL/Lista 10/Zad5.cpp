#include <iostream>
#include <filesystem>
#include <string>

using namespace std;
namespace fs = filesystem;

int main(int argc, char** argv) {
    if (argc != 2) {
        cout << "Usage: [foldername]";
        return 1;
    }
    string n=argv[1];
    if(fs::exists(fs::path(n)) && fs::is_directory(n)) {
        int sizes=0;
        for(auto entry : fs::recursive_directory_iterator(n)) {
            if(fs::is_regular_file(entry)) {
                sizes+= fs::file_size(entry);
            }
        }
        cout << sizes;
    }
    else {
        cout << "Given file does not exist or is not a directory" << endl;
        return 1;
    }
    return 0;
}
