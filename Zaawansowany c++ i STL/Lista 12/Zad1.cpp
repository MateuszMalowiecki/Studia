#include <iostream>

using namespace std;

template<int N>
struct lucas {
    static const int value = lucas<N-1>::value + lucas<N-2>::value;
};

template<>
struct lucas<0> {
    static const int value = 2;
};

template<>
struct lucas<1> {
    static const int value = 1;
};

int main() {
    cout << lucas<1>::value << endl;
    cout << lucas<2>::value << endl;
    cout << lucas<3>::value << endl;
    cout << lucas<4>::value << endl;
    cout << lucas<5>::value << endl;
    return 0;
}
