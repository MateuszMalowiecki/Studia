using System;

namespace POO_L3_Z4_After {
    public class Shape {
        public int CalculateArea() 
    }
    public class Rectangle : Shape {
        public virtual int Width { get; set; }
        public virtual int Height { get; set; }
        public override int CalculateArea() {
            return this.Width * this.Height;
        }
    }

    public class Square : Shape {
        public virtual int Side { get; set;}
        public override int CalculateArea() {
            return this.Side*this.Side;
        }
    }
    public class AreaCalculator {
        public int CalculateArea( Shape s ) {
            return s.CalculateArea();
        }
    }
    public class Test {
        public static void Main() {
            int w = 4, h = 5, s = 7;
            Rectangle rect = new Rectangle() { Width = w, Height = h };
            Square sqr = new Square() {Side= s};
            AreaCalculator calc = AreaCalculator();
            Console.WriteLine("prostokąt o wymiarach {0} na {1} ma pole {2}", w, h, calc.CalculateArea(rect));
            Console.WriteLine("kwadrat o wymiarze boku {0} ma pole {1}", s, calc.CalculateArea(sqr));
        }
    }
}