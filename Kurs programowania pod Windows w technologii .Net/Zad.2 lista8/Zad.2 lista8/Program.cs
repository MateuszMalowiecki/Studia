using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace Zad._2_lista8 {
    class MySet : ArrayList {
        public override int Add(object value) {
            if (this.Contains(value)) return -1;
            return base.Add(value);
        }
    }
    class Program {
        static void Main(string[] args) {
            MySet m = new MySet();
            m.Add(42);
            m.Add(35);
            m.Add(37);
            m.Add(42);
            for (int i=0; i<m.Count; i++) {
                Console.WriteLine(m[i]);
            }
            Console.ReadLine();
        }
    }
}
