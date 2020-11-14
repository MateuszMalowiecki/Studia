#include <iostream>
#include <algorithm>
#include <map>
#include <vector>

using namespace std;

map<int, int> count_number_of_occurences(vector<int> v) {
    map<int, int> res;
    for(auto it=v.begin(); it != v.end(); it++) {
        int i=*it;
        try {
            int val = res.at(i);
            res[i] = val+1;
        }
        catch(out_of_range& e) {
            res[i] = 1;
        }
    }
    int max_value=max_element(res.begin(), res.end(), [] (pair<int, int> i1, pair<int, int> i2) {return i1.second<i2.second;})->second;
    for(auto it = res.begin(); it != res.end(); ) {
        if (it->second != max_value) it = res.erase(it);
        else ++it;
    }
    return res;
}


int main() {
    vector v={1, 1, 3, 5, 8, 9, 5, 8, 8, 5};
    map<int, int> m=count_number_of_occurences(v);
    for (auto it = m.begin(); it != m.end(); it++) {
        cout << it->first << " " << it->second << endl;
    }
    cout << "Hello world!" << endl;
    return 0;
}
