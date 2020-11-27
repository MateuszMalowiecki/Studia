#include <iostream>
#include <cctype>
#include <map>
#include <vector>
#include <fstream>
#include <random>

using namespace std;

map <double, char> weights={{12.02, 'E'}, {9.10, 'T'}, {8.12, 'A'}, {7.68, 'O'}, {7.31, 'I'}, {6.95, 'N'}, {6.28, 'S'}, {6.02, 'R'}, {5.92, 'H'}, {4.32, 'D'}, {3.98, 'L'}, {2.88, 'U'},
{2.71, 'C'}, {2.61, 'M'}, {2.30, 'F'}, {2.11, 'Y'}, {2.09, 'W'}, {2.03, 'G'}, {1.82, 'P'}, {1.49, 'B'}, {1.11, 'V'},{0.69, 'K'}, {0.17, 'X'}, {0.11, 'Q'}, {0.10, 'J'}, {0.07, 'Z'}};
//w pliku wyjsciowym wygenerowalem tekst dlugosci 2000
int main(int argc, char**argv) {
    if(argc != 3) {
        cerr << "Usage: [text_length] [filename]" << endl;
        return 1;
    }
    int len=atoi(argv[1]);
    ofstream file;
    file.open(argv[2]);
    if (!file.is_open()) {
        cerr << "Error while opening file" << endl;
        return 1;
    }
    vector<double> weights_keys;
    for (auto it=weights.begin(); it!= weights.end(); it++) {
        weights_keys.push_back(it->first);
    }
    default_random_engine generator;
    discrete_distribution<int> dist(weights_keys.begin(), weights_keys.end());
    binomial_distribution<int> distribution(12, 0.5);
    int word_len;
    for(int i=0; i < len;) {
        do {
            word_len=distribution(generator);
        } while(word_len == 0 || i + word_len > len);
        for (int j=0; j<word_len; j++) {
            int number = dist(generator);
            file << static_cast<char>(tolower(weights[weights_keys[number]]));
        }
        i += word_len;
        if(i < len) {
            file << " ";
            i++;
        }
    }
    return 0;
}
