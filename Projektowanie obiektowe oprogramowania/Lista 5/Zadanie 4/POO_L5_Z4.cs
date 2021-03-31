using System;
using System.Collections;
using System.Collections.Generic;

namespace POO_L5_Z4 {
    class ComparisonToIcomparerAdapter<T> : IComparer {
        Comparison<T> comparison;
        public ComparisonToIcomparerAdapter(Comparison<T> comparison) {
            this.comparison=comparison;
        } 
        public int Compare (object x, object y) {
            return comparison((T)x, (T)y);
        }
    }
    class Test {
        static int IntComparer( int x, int y )  {
            return x.CompareTo( y );
        }
        static void Main( string[] args ) {
            ArrayList a = new ArrayList() { 1, 5, 3, 3, 2, 4, 3 };
            Comparison<int> intComparer=IntComparer;
            a.Sort(new ComparisonToIcomparerAdapter<int>(intComparer));
            foreach (var elem in a) {
                Console.WriteLine(elem);
            }
        }
    }
}