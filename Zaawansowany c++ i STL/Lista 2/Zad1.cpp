#include <iostream>
#include <cstdlib>
#include <memory>
using namespace std;
class counter {
    uint64_t counter=1;
    public:
        void addTo(int n) {
            counter += n;
        }
        int getCounter() {
             return counter;
        }
        virtual ~counter() {
            cerr << "Counter state is:" << counter << endl;
        }
};

void multiply_by_naturals(int n, int m, int i, unique_ptr<counter[]>& counters) {
    if (i > m) return;
    int r=rand() % n;
    cout << "Added " << i << " to element number: " << r << endl;
    counters[r].addTo(i);
    multiply_by_naturals(n, m, i+1, counters);
}
int main() {
    int n,m;
    cout << "Podaj dwie liczby:" << endl;
    cin >> n >> m;
    unique_ptr<counter[]> counters(new counter[n]);
    multiply_by_naturals(n, m, 1, counters);
    for (int i=0; i<n; i++) {
        cout << counters[i].getCounter() << endl;
    }
    return 0;
}
