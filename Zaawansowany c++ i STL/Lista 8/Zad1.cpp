#include <iostream>
#include <algorithm>
#include <functional>
#include <deque>
#include <complex>

using namespace std;

const double euler_mascheroni = 0.5772156649;
complex<double> gamma(double n, complex<double>  z) {
    complex< double> res=1.0/z;
    for(double i=1.0; i<n; i++) {
        res *= pow((1.0 + 1.0/i), z) / (1.0 + z/i);
    }
    return res;
}

complex<double> gamma_inv(double n, complex<double>  z) {
    complex<double> res=z * exp(euler_mascheroni * z);
    for(double i=1.0; i<n; i++) {
        res *= (1.0 + z/i) * exp(-z/i);
    }
    return res;
}

int main() {
    double n;
    double real, imag;
    cout << "Give real and imaginary part of complex number(two numbers): ";
    cin >> real >> imag;
    complex<double> c=complex<double>(real, imag);
    cout << "Give number of iterations:";
    cin >> n;
    cout << "gamma(" << c << ")=" << gamma(n, c) << endl;
    cout << "1/gamma(" << c << ")=" << gamma_inv(n, c) << endl;
    return 0;
}
