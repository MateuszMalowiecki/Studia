#include <iostream>
#include <random>
#include <algorithm>

using namespace std;

template<typename T>
void shuffleArray(T arr[], int n) {
    default_random_engine generator;
    for (int k = n - 1; k >= 0; --k) {
       uniform_int_distribution<int> distribution(0, k);
       int to_swap=distribution(generator);
       swap(arr[to_swap], arr[k]);
    }
}

int main() {
    int arr[10]={1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    shuffleArray(arr, 10);
    for (int i=0; i<10; i++) {
        cout << arr[i] << endl;
    }
    return 0;
}
