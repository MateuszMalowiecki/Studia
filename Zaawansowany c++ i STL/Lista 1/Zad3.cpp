#include <iostream>
using my_set=std::set<std::string>
int main() {
   my_set s("AAAA", "BBBB", "CCCC", "DDDD")
   for (auto str: s) {
    std::cout << str << std::endl;
   }
   return 0;
}
