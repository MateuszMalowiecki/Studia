#include <iostream>

using namespace std;

template<size_t N, typename T>
struct Scalar_product {
    static constexpr T result(T *x, T *y) {
        return ((*x) * (*y)) + Scalar_product<N-1, T>::result(x + 1, y + 1);
    }
};

template<typename T>
struct Scalar_product<0, T> {
    static constexpr T result(T*,T*) {
        return 0;
    }
};

template<size_t N, typename T>
constexpr T inner(T *x, T *y) {
    return Scalar_product<N, T>::result(x, y);
}

int main() {
    constexpr int x[4]={1, 2, 3, 4};
    constexpr int y[4]={4, 5, 6, 7};
    constexpr int z=inner<4, const int>(x, y);
    cout << z;
    return 0;
}
