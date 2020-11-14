#include <iostream>
#include <algorithm>
#include <list>

using namespace std;
class Point {
    public:
        double x,y;
        string name;
        int r,g,b;

        Point(double x_coordinate,double y_coordinate, string point_name, int r_colour, int b_colour, int g_colour) {
            this->x=x_coordinate;
            this->y=y_coordinate;
            this->name=point_name;
            this->r=r_colour;
            this->b=b_colour;
            this->g=g_colour;
        }

        void print_point() {
            cout << this->x << " " << this->y << " " << this->name << " " << this->r << " " << this->b << " " << this->g << endl;
        }
        double brightness() {
            return 0.3*this->r + 0.59*this->g + 0.11*this->b;
        }
};

void print_points(list<Point> l) {
    for(auto it=l.begin(); it!=l.end(); it++) {
        it->print_point();
    }
    cout << "------" << endl;
}

int main()
{
    list<Point> l;
    Point* p1=new Point(20, 41, "A", 45, 71, 52);
    Point* p2=new Point(57, -41, "B", 10, 98, 74);
    Point* p3=new Point(-15, 34, "C", 89, 43, 21);
    Point* p4=new Point(-14, -79, "D", 11, 7, 10);
    Point* p5=new Point(89, 42, "E", 47, 59, 84);
    Point* p6=new Point(85, -43, "F", 67, 82, 43);
    Point* p7=new Point(98, 91, "G", 49, 87, 42);
    Point* p8=new Point(-12, 15, "H", 76, 74, 82);
    Point* p9=new Point(-15, -18, "I", 42, 57, 89);
    Point* p10=new Point(67, -89, "J", 52, 43, 78);
    Point* p11=new Point(46, 85, "K", 96, 72, 83);
    Point* p12=new Point(-12, -14, "L", 75, 12, 81);
    Point* p13=new Point(-56, 78, "M", 49, 81, 72);
    Point* p14=new Point(87, -81, "N", 46, 87, 51);
    Point* p15=new Point(92, -12, "O", 53, 19, 81);
    Point* p16=new Point(-100, 81, "P", 92, 91, 93);
    Point* p17=new Point(-85, -74, "R", 94, 81, 52);
    l.push_back(*p1);
    l.push_back(*p2);
    l.push_back(*p3);
    l.push_back(*p4);
    l.push_back(*p5);
    l.push_back(*p6);
    l.push_back(*p7);
    l.push_back(*p8);
    l.push_back(*p9);
    l.push_back(*p10);
    l.push_back(*p11);
    l.push_back(*p12);
    l.push_back(*p13);
    l.push_back(*p14);
    l.push_back(*p15);
    l.push_back(*p16);
    l.push_back(*p17);
    copy_if(l.begin(), l.end(), l.begin(), [](Point p) { return p.name.length() <= 5;});
    print_points(l);
    int first_quadrant=count_if(l.begin(), l.end(), [](Point p) {return p.x > 0 && p.y > 0;});
    int second_quadrant=count_if(l.begin(), l.end(), [](Point p) {return p.x < 0 && p.y > 0;});
    int third_quadrant=count_if(l.begin(), l.end(), [](Point p) {return p.x < 0 && p.y < 0;});
    int fourth_quadrant=count_if(l.begin(), l.end(), [](Point p) {return p.x > 0 && p.y < 0;});
    cout << "Points in first: " << first_quadrant << ", points in second: " << second_quadrant<< ", points in third: " << third_quadrant<< ", points in fourth: " << fourth_quadrant << endl;
    l.sort([](Point p1, Point p2) { return p1.brightness() < p2.brightness();});
    print_points(l);
    list <Point> dark_point(l);
    auto it=copy_if(l.begin(), l.end(), dark_point.begin(), [](Point p) { return p.brightness() < 64;});
    dark_point.resize(distance(dark_point.begin(),it));
    print_points(dark_point);
    return 0;
}
