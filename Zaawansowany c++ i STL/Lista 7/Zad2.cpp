#include <iostream>
#include <random>
#include <fstream>

using namespace std;

void generate_uniform() {
   default_random_engine generator;
   uniform_real_distribution<double> distribution(0.0,1.0);
   ofstream uni_file;
   uni_file.open ("uniform.csv");
   for(int i=0; i<1000; i++) {
       uni_file << distribution(generator) << endl;
   }
   uni_file.close();
}

void generate_binomial() {
   default_random_engine generator;
   binomial_distribution<int> distribution(9, 0.5);
   ofstream uni_file;
   uni_file.open ("binomial.csv");
   for(int i=0; i<1000; i++) {
       uni_file << distribution(generator) << endl;
   }
   uni_file.close();
}

void generate_normal() {
   default_random_engine generator;
   normal_distribution<double> distribution(5.0,2.0);
   ofstream uni_file;
   uni_file.open ("normal.csv");
   for(int i=0; i<1000; i++) {
       uni_file << distribution(generator) << endl;
   }
   uni_file.close();
}

int main() {
    generate_uniform();
    generate_binomial();
    generate_normal();
    return 0;
}
