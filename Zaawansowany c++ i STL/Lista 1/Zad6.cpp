#include <iostream>
using my_set=std::set<std::string>
int find_zero_places(int a, int b, int c) {
    if (double delta=b*b-4*a*c; delta < 0) {
        std::cout << "Sorry, no zero places there."
    }
    else if(delta == 0) {
        double sol=-b/2.0 * a
        std::cout << "The only solution is:" << sol;
    }
    else {
        double sqrt_delta = std::sqrt(delta)
        double sol1=(-b - sqrt_delta)/2.0 * a
        double sol2=(-b + sqrt_delta)/2.0 * a
        std::cout << "Solutins are:" << sol1 << "and" << sol2;
    }
}
int main() {
   find_zero_places(2, -2, 0)
   return 0;
}

