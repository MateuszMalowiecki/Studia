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
        for(auto entry : fs::directory_iterator(n)) {
            cout << entry.path().filename() << endl;
        }
    }
    else {
        cout << "Given file does not exist or is not a directory" << endl;
        return 1;
    }
    return 0;
}
