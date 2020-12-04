#include <iostream>

#include <regex>

using namespace std;

bool match_to_complex_regex(string& str) {
    regex c("[[:space:]]*\\([[:space:]]*[-]?[0-9]+(\\.[0-9]+)?[[:space:]]*[+][[:space:]]*[-]?[0-9]+(\\.[0-9]+)?(i|I)[[:space:]]*\\)[[:space:]]*");
    return regex_match(str, c);
}

int main() {
   string s;
   while(true) {
        cout << "Give me expression and i will try if it is a valid complex:" << endl;
        getline(cin, s);
        if(match_to_complex_regex(s)) {
            cout << "Expression is a valid complex" << endl;
        }
        else {
            cout << "Expression is not a valid complex" << endl;
        }
    }
    return 0;
}
