#include <iostream>
#include <regex>

using namespace std;


bool match_to_city_regex(string& str) {
    regex c("[[:upper:]][[:lower:]]*(-[[:upper:]][[:lower:]]*)?([[:space:]]+[[:upper:]][[:lower:]]*(-[[:upper:]][[:lower:]]*)?)*");
    return regex_match(str, c);
}

int main() {
    string s;
    while(true) {
        cout << "Give me expression and i will try if it is a valid city name:" << endl;
        getline(cin, s);
        if(match_to_city_regex(s)) {
            cout << "Expression is a valid city name" << endl;
        }
        else {
            cout << "Expression is not a valid city name" << endl;
        }
    }
    return 0;
}
