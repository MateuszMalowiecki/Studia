#include <iostream>
#include <fstream>
#include <cstdint>
#include <filesystem>
#include <ctime>
#include <chrono>

using namespace std;
namespace fs = filesystem;

int main(int argc, char** argv) {
    using namespace chrono;
    for (int i=1; i<argc; i++) {
        fs::path p=fs::path(argv[i]);
        if(fs::exists(p)) {
            cout << "Sciezka kanoniczna: " << fs::canonical(p) << endl;
            auto lwt=fs::last_write_time(p);
            time_t conv_time=system_clock::to_time_t(time_point_cast<system_clock::duration>(lwt - fs::file_time_type::clock::now()+ system_clock::now()));
            cout << "Data utworzenia: " << asctime(localtime(&conv_time));
            if(fs::is_regular_file(p)) {
                cout << "Rozmiar:" << fs::file_size(p) << endl;
            }
        }
    }
    return 0;
}
