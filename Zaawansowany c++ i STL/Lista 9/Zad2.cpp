#include <iostream>
#include <regex>

using namespace std;

bool match_to_date_regex(string& str) {
    regex d("(31-(01|03|05|07|08|10|12)|30-(01|0[3-9]|1[0-2])|((0[1-9]|[1-2][0-9])-(0[1-9]|1[0-2])))-[0-9]{4}");
    return regex_match(str, d);
}


int main() {
    string s;
   while(true) {
        cout << "Give me expression and i will try if it is a valid date:" << endl;
        getline(cin, s);
        if(match_to_date_regex(s)) {
            cout << "Expression is a valid date" << endl;
        }
        else {
            cout << "Expression is not a valid date" << endl;
        }
    }
    return 0;
}
