#include <iostream>

using namespace std;

template<int A, int B>
struct gcd {
    static const int value = gcd<B % A, A>::value;
};

template<int B>
struct gcd<0, B> {
    static const int value = B;
};

int main() {
    cout << gcd<42, 51>::value << endl;
    cout << gcd<50, 74>::value << endl;
    return 0;
}
