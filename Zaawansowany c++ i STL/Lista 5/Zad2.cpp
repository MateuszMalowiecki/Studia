#include <iostream>
#include <queue>
#include <list>
#include <map>
#include <string>
#include <cctype>
#include <cassert>
#include <climits>
using namespace std;

class Graph {
    private:
        map<int, list<pair<int, int> > > neighbours;
        map<int, string> vertex_name;
    public:
        Graph() {
            neighbours = {};
            vertex_name = {};
        }
        vector<int> get_vertices() {
             vector<int> res;
             for (auto v : this->vertex_name) {
                res.push_back(v.first);
             }
             return res;
        }
        map<int, list<pair<int, int> > > neighbours_getter() {
            return this->neighbours;
        }
        void add_vertex(int num) {
            this->neighbours[num]=list<pair<int, int>>();
            this->vertex_name[num] = to_string(num);
        }
        void add_vertex(string s) {
            for(unsigned long long int i=0; i<s.length(); i++) {
                assert(isdigit(s[i]));
            }
            int num=stoi(s);
            this->neighbours[num]=list<pair<int, int>>();
            this->vertex_name[num] = s;
        }
        void remove_vertex(int num) {
            neighbours.erase(num);
            vertex_name.erase(num);
        }
        void remove_vertex(string s) {
            for(unsigned long long int i=0; i<s.length(); i++) {
                assert(isdigit(s[i]));
            }
            int num=stoi(s);
            remove_vertex(num);
        }
        void add_edge(int v, int u, int weight) {
            this->neighbours[v].push_back(pair(u, weight));
            this->neighbours[u].push_back(pair(v, weight));
        }
        void del_edge(int v, int u) {
            auto v_neighbours=this->neighbours[v];
            for (auto p : v_neighbours) {
               if(p.first==u) {
                   this->neighbours[v].remove(p);
                   break;
               }
            }
            auto u_neighbours=this->neighbours[u];
            for (auto p : u_neighbours) {
               if(p.first==v) {
                   this->neighbours[u].remove(p);
                   break;
               }
            }
        }
        void change_weight(int v, int u, int weight) {
            del_edge(v, u);
            add_edge(v, u, weight);
        }
};

map<int, int> Dijkstra(Graph g, int source) {
    map<int, int> res;
    for (auto v : g.get_vertices()) {
        res[v]=INT_MAX;
    }
    res[source]=0;
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> q;
    q.push({source, 0});
    auto neighbours=g.neighbours_getter();
    while(!q.empty()) {
         pair<int, int> queueTop=q.top();
         q.pop();
         int vertex=queueTop.first;
         for(auto it=neighbours[vertex].begin(); it!=neighbours[vertex].end(); it++) {
            int neighbour=it->first;
            int act_dist=it->second+res[vertex];
            if(act_dist < res[neighbour]) {
                res[neighbour]=act_dist;
                q.push({neighbour, act_dist});
            }
         }
    }
    return res;
}

bool is_path_beetween(Graph g, int source, int dest) {
    return Dijkstra(g, source)[dest] < INT_MAX;
}

int main() {
    Graph* g1=new Graph();
    for(int i=0; i< 10; i++) {
        g1->add_vertex(i);
    }
    for(int i=0; i<9; i++) {
        g1->add_edge(i, i+1, i);
    }
    if (is_path_beetween(*g1, 1, 10)) {
        cout << "OK" << endl;
    }
    if (is_path_beetween(*g1, 4, 7)) {
        cout << "OK" << endl;
    }
    if (is_path_beetween(*g1, 5, 2)) {
        cout << "OK" << endl;
    }
    g1->del_edge(5, 6);

    if (!is_path_beetween(*g1, 1, 6)) {
        cout << "OK" << endl;
    }
    if (!is_path_beetween(*g1, 8, 5)) {
        cout << "OK" << endl;
    }
    if (is_path_beetween(*g1, 1, 4)) {
        cout << "OK" << endl;
    }
    if (is_path_beetween(*g1, 7, 10)) {
        cout << "OK" << endl;
    }
    return 0;
}
