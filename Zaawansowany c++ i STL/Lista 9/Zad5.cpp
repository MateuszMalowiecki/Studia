#include <iostream>
#include <string>
#include <regex>
#include <fstream>

using namespace std;

void match_to_href_regex_and_print_matches(string& str) {
    regex c(R"(<a href=".*"/?>)");
    regex h(R"(".*")");
    smatch m;
    smatch m1;
    string s=str;
    while (regex_search(s, m, c)) {
        for(unsigned i=0; i<m.size(); i++) {
            string tmp=m.str(i);
            regex_search(tmp, m1, h);
            for (auto hyperlink: m1) {
                cout << hyperlink << " ";
            }
        }
        cout << endl;
        s = m.suffix().str();
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
