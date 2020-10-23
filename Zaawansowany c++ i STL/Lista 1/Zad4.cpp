#include <iostream>

enum class names:uint16_t {
    Adrian,
    Bartosz,
    Damian,
    Konrad,
    Karol,
    Tomasz
};
void print_message(string message, names n) {
    switch(n) {
   case names::Adrian:
    std::cout << "Adrian" << message << "\n";
    break;
    case names::Bartosz:
    std::cout << "Bartosz" << message << "\n";
    break;
    case names::Damian:
    std::cout << "Damian" << message << "\n";
    break;
    case names::Konrad:
    std::cout << "Konrad" << message << "\n";
    break;
    case names::Karol:
    std::cout << "Karol" << message << "\n";
    break;
    case names::Tomasz:
    std::cout << "Tomasz" << message << "\n";
    break;
    }
}
int main() {
 print_message("Siema, ", names::Adrian)
}
