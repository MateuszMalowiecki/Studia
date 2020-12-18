#include <iostream>
#include <fstream>
#include <iterator>
#include <vector>
#include <algorithm>

using namespace std;

int gcd(int a, int b) {
    if (a > b) return gcd(b, a);
    if (a == 0) return b;
    return gcd(b % a, a);
}

int totient(int n) {
    int res=0;
    for (int i=1; i<=n; i++) {
        if (gcd(i, n) == 1) {
            res++;
        }
    }
    return res;
}

int main() {
    cout << "Podaj k:" << endl;
    int k;
    cin >> k;
    vector<int> tocients;
    for(int i=1; i<=k; i++) {
        tocients.push_back(totient(i));
    }
    ofstream file;
    file.open("phi.txt");
    ostream_iterator<int> file_iter(file, "; ");
    copy ( tocients.begin(), tocients.end(), file_iter);
    return 0;
}
