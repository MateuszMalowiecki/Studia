#include <iostream>
#include <string>
#include <regex>
#include <fstream>

using namespace std;

void match_to_href_regex_and_print_matches(string s) {
    regex c(R"(<a href=(".*")/?>)");
    smatch m;
    smatch m1;
    while (regex_search(s, m, c)) {
        string tmp=m[1];
        cout << tmp << " ";
        s = m.suffix().str();
        cout << endl;
    }
}

int main(int argc, char** argv) {
    if(argc != 2) {
        cerr << "Usage: [filename]" << endl;
        return 1;
    }
    ifstream file_with_refs;
    file_with_refs.open (argv[1], std::ifstream::in);
    string text="";
    while (file_with_refs.good()) {
        text += file_with_refs.get();
    }
    file_with_refs.close();
    match_to_href_regex_and_print_matches(text);
    return 0;
}
