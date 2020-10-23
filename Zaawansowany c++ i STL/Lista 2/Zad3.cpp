#include <iostream>
#include <memory>

using namespace std;

void create_some_shared_pointer(weak_ptr<int> weak) {
    auto shared_pointer = make_shared<int>(42);
    weak=shared_pointer;
    //weak_ptr not expired
    cout << weak.expired() << endl;
}
int main() {
    weak_ptr<int> weak;
    create_some_shared_pointer(weak);
    //weak_ptr expired
    cout << weak.expired() << endl;
}
