#include <iostream>
#include <regex>

using namespace std;
bool match_to_hour_regex(string& str) {
    regex h("([0-1][0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?");
    return regex_match(str, h);
}



int main() {
    string s;
    while(true) {
        cout << "Give me expression and i will try if it is a valid hour:" << endl;
        getline(cin, s);
        if(match_to_hour_regex(s)) {
            cout << "Expression is a valid hour" << endl;
        }
        else {
            cout << "Expression is not a valid hour" << endl;
        }
    }
    return 0;
}
