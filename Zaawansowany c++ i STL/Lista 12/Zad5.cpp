#include <iostream>
#include <type_traits>
#include <array>
#include <fstream>

using namespace std;

constexpr int stack_max = sizeof(std::string);
constexpr int arr_max=1000000;

template<typename T>
struct on_stack {
    private:
        T object;
    public:
        on_stack() {
            cout << "Created object on stack" << endl;
        }
        ~on_stack() {
            cout << "Removed object from stack" << endl;
        }
        T& operator*() {
            return object;
        }
        T* operator->() {
            return &object;
        }
};

template<typename T>
struct on_heap {
    private:
        T* object;
    public:
        on_heap() {
            cout << "Created object on heap" << endl;
            object = new T;
        }
        ~on_heap() {
            cout << "Removed object from heap" << endl;
            delete object;
        }
        T& operator*() { return *object; }
        T* operator->() { return object; }
};

template<typename T>
struct obj_holder {
    using type=typename std::conditional<(sizeof(T) <= stack_max), on_stack<T>, on_heap<T>>::type;
};

template<typename T>
struct array_on_heap {
    private:
        T* object;
    public:
        array_on_heap() {
            cout << "Created array on heap" << endl;
            object = new T;
        }
        ~array_on_heap() {
            cout << "Removed array from heap" << endl;
            delete object;
        }
        T& operator*() { return *object; }
        T* operator->() { return object; }
        T operator[](int i) {return *(object + i);}
};

template<typename T>
struct array_in_file  {
    private:
        fstream* my_file;
    public:
        array_in_file() {
            cout << "Created array in file" << endl;
            my_file->open("my_file.txt");
        }
        ~array_in_file() {
            cout << "Removed array from file" << endl;
            my_file->close();
        }
        T& operator*() { return *my_file; }
        T* operator->() { return my_file; }
};

template<typename T>
struct arr_holder {
    using type=typename std::conditional<(sizeof(T) <= arr_max), array_on_heap<T>, array_in_file<T>>::type;
};

int main() {
    obj_holder<double>::type v1;
    obj_holder<array<double, 200>>::type v2;
    *v1 = 7.7;
    (*v2)[0] = 9.9;
    cout << *v1 << endl;
    for(int i=0; i<10; i++) {
        cout << (*v2)[i] << endl;
    }
    arr_holder<array<double, 200>>::type v3;
    (*v3)[4] = 5.7;
    for(int i=0; i<10; i++) {
        cout << (*v3)[i] << endl;
    }
    return 0;
}
