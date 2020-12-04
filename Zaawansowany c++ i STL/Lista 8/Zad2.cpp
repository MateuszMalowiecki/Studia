#include <iostream>
#include <complex>
#include <fstream>
#include <cmath>

using namespace std;

complex<double> dzeta(double n, complex<double>  z) {
    complex<double> res=0.0;
    for(double i=1.0; i<n; i++) {
        res += pow(1.0/i, z);
    }
    return res;
}

int main() {
    ofstream file;
    double n;
    double beginning, ending, step;
    file.open("Dzeta.csv");
    cout << "Give number of iterations: ";
    cin >> n;
    cout << "Give begin and end of interval and step between two points: ";
    cin >> beginning >> ending >> step;
    for(double d=beginning; d<=ending; d+=step) {
        complex<double> res=dzeta(n, {0.5, d});
        file << d << "\t" << round(res.real()) << "\t" << round(res.imag()) << endl;
    }
    return 0;
}
