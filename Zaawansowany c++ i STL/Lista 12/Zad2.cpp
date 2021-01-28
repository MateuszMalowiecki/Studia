#include <iostream>

using namespace std;

template<int N, int K>
struct binom {
    static const int value = (binom<N-1, K-1>::value * N)/K;
};

template<int N>
struct binom<N, N> {
    static const int value = 1;
};

template<int N>
struct binom<N, 0> {
    static const int value = 1;
};

int main() {
    cout << binom<5,0>::value << endl;
    cout << binom<5,1>::value << endl;
    cout << binom<5,2>::value << endl;
    cout << binom<5,3>::value << endl;
    cout << binom<5,4>::value << endl;
    cout << binom<5,5>::value << endl;
    return 0;
}
