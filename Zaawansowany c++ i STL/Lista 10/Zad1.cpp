#include <iostream>
#include <vector>
#include <iterator>
#include <numeric>
#include <cmath>
#include <iomanip>

using namespace std;

int main() {
    string numbers;
    getline(cin, numbers);
    istringstream iss(numbers);
    istream_iterator<double> iit(iss);
    istream_iterator<double> eos;
    vector<double> values(iit, eos);
    double arithmetic_mean=accumulate(values.begin(), values.end(), 0.0) / (double)values.size();
    double square_arithmetic_mean=accumulate(values.begin(), values.end(), 0.0, [](double acc, double x) {return acc+x*x;}) / (double)values.size();
    cout << "Arithmetic mean: " << setprecision(3) << arithmetic_mean << endl;
    cout << "Standard deviation: " << setprecision(3) << sqrt(square_arithmetic_mean - arithmetic_mean * arithmetic_mean) << endl;
}
