#include <iostream>
#include <fstream>
#include <map>
using namespace std;

void histogram(string s) {
    map<char, int> res;
    for(unsigned long long int i=0; i<s.length(); i++) {
        char a=s[i];
        try {
            int val = res.at(a);
            res[a] = val+1;
        }
        catch(out_of_range& e) {
            res[a] = 1;
        }
    }
    for (auto it = res.begin(); it != res.end(); it++) {
        for(auto it2=it; it2!=res.end(); it2++) {
            if(it->first == it2->first + 32 || it->first + 32 == it2->first) {
                it->second+=it2->second;
                it2->second=0;
            }
        }
    }
    for(auto it = res.begin(); it != res.end(); ) {
        if (it->second == 0) it = res.erase(it);
        else ++it;
    }
    for(auto it = res.begin(); it != res.end(); it++) {
        cout << it->first << " ";
        for(int i=0; i<it->second; i++) {
            cout << "*";
        }
        cout << endl;
    }
}
int main(int argc, char** argv){
    if(argc != 2) {
        cerr << "Usage: [filename]" << std::endl;
        return 1;
    }
    ifstream ifs;
    ifs.open (argv[1], std::ifstream::in);
    cout << "Hello world!" << endl;
    string text="";
    while (ifs.good()) {
        text += ifs.get();
    }
    cout << text << endl;
    histogram(text);
    return 0;
}
