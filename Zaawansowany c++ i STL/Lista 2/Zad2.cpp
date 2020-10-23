#include <iostream>
#include <memory>
#include <vector>
#include <fstream>
#include <string>

using namespace std;

class line_writer {
     ofstream* stream;
     public:
     line_writer(const char* path) {
         stream = new ofstream(path);
     }
     bool check_opening() {
         return stream->is_open();
     }
     void write_to_file(string data) {
         *(stream) << data << endl;
     }
     ~line_writer() {
         stream->close();
         cout << "Zamkniecie pliku" << endl;
         delete(stream);
    }
};

int main()
{
    int n;
    string path;
    cout << "Podaj liczbe wskaznikow" << endl;
    cin >> n;
    cout << "Podaj nazwe pliku" << endl;
    cin >> path;

    shared_ptr writer_pointer = make_shared<line_writer>(path.c_str());
    if (!writer_pointer.get()->check_opening()) {
            cout << "Something went wrong!!!";
            return -1;
    }
    vector<shared_ptr<line_writer>> writers(n);
    for (int i=0; i<n; i++) {
        writers[i] = writer_pointer;
    }
    for (int i=0; i<n; i++) {
        writers[i]->write_to_file("Number " + to_string(i));
    }
    return 0;
}
