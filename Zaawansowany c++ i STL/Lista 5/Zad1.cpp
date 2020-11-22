#include <iostream>
#include <vector>
#include <map>
#include <list>
#include <stack>
#include <queue>
#include <cctype>
using namespace std;

vector<char> validOperatorsAndParantheses={'(', ')', '+', '-', '*', '/'};
map<char, int> operatorPriority = {{'*', 3}, {'/', 3}, {'+', 2}, {'-', 2}, {'(', 1}};

bool isOperatorOrParanthese(char c) {
    for(int i=0; i<6; i++) {
        if(c==validOperatorsAndParantheses[i]) return true;
    }
    return false;
}

queue<string> Dijkstra(string s) {
    list<string> l;
    string helper = "";
    auto n=s.length();
    for(unsigned long long int i=0; i<n; i++) {
        char a=s[i];
        if (isdigit(a)) {
            helper += a;
            if (i <= n-2 && isdigit(s[i+1])) {
                continue;
            }
            else {
                l.push_back(helper);
                helper = "";
            }
        }
        if (isOperatorOrParanthese(a) || islower(a)) {
            l.push_back(string(1, a));
        }
    }
    queue<string> res;
    stack <string> myStack;
    while(!l.empty()) {
        string elem=l.front();
        l.pop_front();
        if(isdigit(elem[0]) || islower(elem[0])) {
            res.push(elem);
        }
        else if(elem[0]=='(') {
            myStack.push(elem);
        }
        else if(elem[0]==')') {
            string stackTop=myStack.top();
            myStack.pop();
            while(!myStack.empty() && stackTop != "(") {
                res.push(stackTop);
                stackTop=myStack.top();
                myStack.pop();
            }
        }
        else {
            if(myStack.empty()) {
                myStack.push(elem);
                continue;
            }
            string stackTop=myStack.top();
            while(operatorPriority[stackTop[0]] >= operatorPriority[elem[0]]) {
                res.push(stackTop);
                myStack.pop();
                if(myStack.empty()) {
                    break;
                }
                stackTop=myStack.top();
            }
            myStack.push(elem);
        }
    }
    while(!myStack.empty()) {
        res.push(myStack.top());
        myStack.pop();
    }
    return res;
}

void printQueue(queue<string> q) {
	while (!q.empty()){
		cout << q.front() << " ";
		q.pop();
	}
	cout<<endl;
}

int main() {
    queue<string> q=Dijkstra("3 + 4");
    printQueue(q);
    q=Dijkstra("31 + 4 * a");
    printQueue(q);
    q=Dijkstra("4 / 52 - b");
    printQueue(q);
    q=Dijkstra("(3 + 47) * c");
    printQueue(q);
    q=Dijkstra("4 / (59 - d)");
    printQueue(q);
    return 0;
}
