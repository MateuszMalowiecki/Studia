using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Zad._1_lista8
{
    public class Complex : IFormattable
    {
        int a, b;
        public Complex(int real, int imag) {
            a = real;
            b = imag;
        }
        public string ToString(string format, IFormatProvider formatProvider) {
            if (format == "d" || format == null) {
                return a.ToString() + "+" + b.ToString() + "i";
            }
            if (format == "w") {
                return "[" + a.ToString() + "," + b.ToString() + "]";
            }
            return base.ToString();
        }
        public static Complex operator +(Complex c1, Complex c2) {
            return new Complex(c1.a+c2.a, c1.b+c2.b);
        }
        public static Complex operator *(Complex c1, Complex c2) {
            return new Complex(c1.a * c2.a - c1.b * c2.b, c1.b*c2.a + c2.b*c1.a);
        }
    }
    class Program {
        static void Main(string[] args) {
            Complex z = new Complex(4, 3);
            Console.WriteLine(String.Format("{0}", z));
            Console.WriteLine(String.Format("{0:d}", z));
            Console.WriteLine(String.Format("{0:w}", z));
            Complex z2 = z + z;
            Console.WriteLine(String.Format("{0}", z2));
            Console.WriteLine(String.Format("{0:d}", z2));
            Console.WriteLine(String.Format("{0:w}", z2));
            Complex z3 = z * z;
            Console.WriteLine(String.Format("{0}", z3));
            Console.WriteLine(String.Format("{0:d}", z3));
            Console.WriteLine(String.Format("{0:w}", z3));
            Console.ReadLine();
        }
    }
}
