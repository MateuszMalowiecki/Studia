#include <iostream>
#include <algorithm>
#include <functional>
#include <deque>

using namespace std;


class Person{
    public:
   string name, surname;
   double weight, height;
   int age;
   int bmi() {
      return this->weight/(this->height*this->height);
   }
   Person() {}
   Person(string person_name, string person_surname, int person_age, double person_height, double person_weight) {
      this->name=person_name;
      this->surname=person_surname;
      this->weight=person_weight;
      this->height=person_height;
      this->age=person_age;
   }
   void print_person() {
      cout << this->name << " " << this->surname << " " << this->weight << " " << this->height << " " << this -> age << endl;
   }
};
void print_persons(deque<Person> d) {
    for(auto it=d.begin(); it!=d.end(); it++) {
        it->print_person();
    }
    cout << "------" << endl;
}

int main() {
    Person* p1=new Person("Adrian", "Wojcik", 23, 1.76, 76.5);
    Person* p2=new Person("Mariusz", "Chodor", 34, 1.95, 101.2);
    Person* p3=new Person("Grzegorz", "Cabaj", 17, 1.64, 60.0);
    Person* p4=new Person("Tomasz", "Karas", 29, 1.71, 80.5);
    Person* p5=new Person("Michal", "Niemiec", 39, 1.84, 75.1);
    Person* p6=new Person("Maria", "Lewek", 37, 2.06, 106.5);
    Person* p7=new Person("Julia", "Dubiel", 28, 1.66, 66.7);
    Person* p8=new Person("Monika", "Skala", 27, 1.77, 79.0);
    Person* p9=new Person("Daniel", "Bielecki", 33, 1.96, 96.9);
    Person* p10=new Person("Dominika", "Nowak", 31, 1.74, 72.3);
    Person* p11=new Person("Wojciech", "Kowalski", 39, 1.84, 86.0);
    deque<Person> d;
    d.push_back(*p1);
    d.push_back(*p2);
    d.push_back(*p3);
    d.push_back(*p4);
    d.push_back(*p5);
    d.push_back(*p6);
    d.push_back(*p7);
    d.push_back(*p8);
    d.push_back(*p9);
    d.push_back(*p10);
    d.push_back(*p11);
    sort(d.begin(), d.end(), [](Person p1, Person p2) {return p1.bmi() < p2.bmi();});
    print_persons(d);
    deque<Person> after_camp(d);
    transform(d.begin(), d.end(), after_camp.begin(), [](Person p) { p.weight *= 0.9; return p;});
    print_persons(after_camp);
    auto bound = std::partition (d.begin(), d.end(), [] (Person p) { return p.weight > 100;});
    cout << "heavier than 100:" << endl;
    for (auto it=d.begin(); it!=bound; ++it) {
        it->print_person();
    }
    cout << "-----" << endl;
    cout << "lighter than 100:" << endl;
    for (auto it=bound; it!=d.end(); ++it) {
        it->print_person();
    }
    cout << endl;
    nth_element (d.begin(), d.begin()+5, d.end(),[](Person p1, Person p2) { return p1.height <  p2.height;});
    print_persons(d);
    random_shuffle(d.begin(), d.begin() + 5);
    random_shuffle(d.end() - 5, d.end());
    print_persons(d);
    cout << "The oldest person is:";
    auto min_max=minmax_element(d.begin(), d.end(), [](Person p1, Person p2) { return p1.age <  p2.age;});
    min_max.first->print_person();
    cout << "The youngest person is:";
    min_max.second->print_person();
}
