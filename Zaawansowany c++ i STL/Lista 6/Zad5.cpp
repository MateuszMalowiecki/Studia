#include <iostream>
#include <algorithm>
using namespace std;

vector<string> permutations(string str, int n) {
    if (n == 0) {
        return vector<string>({""});
    }
    vector<string> res;
    for (int i = 0; i < n; i++) {
        vector<string> helper=permutations(str.substr(1), n - 1);
        transform(helper.begin(), helper.end(), helper.begin(), [=](string perm) {return str[0]+perm;});
        for(auto it=helper.begin(); it!=helper.end(); it++) {
            res.push_back(*it);
        }
        rotate(str.begin(), str.begin() + 1, str.end());
    }
    return res;
}

int main() {
    string str = "ABC";

    vector<string> res=permutations(str, str.size());

    for(auto it=res.begin(); it<res.end(); it++) {
        cout << *it << endl;
    }
    return 0;
}
