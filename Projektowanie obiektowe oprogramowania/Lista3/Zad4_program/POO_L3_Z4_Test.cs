using System;
using POO_L3_Z4_After;
using POO_L3_Z4_Before;

namespace POO_L3_Z4_Test {
    public class Test {
        public static void Main() {
            int w = 4, h = 5, s = 7;

            Console.WriteLine("Przed: ");
            Rectangle rect_before = new Square() { Width = w, Height = h };
            AreaCalculator calc_before = new AreaCalculator();
            Console.WriteLine( "prostokąt o wymiarach {0} na {1} ma pole {2}", w, h, calc_before.CalculateArea(rect_before));

            Console.WriteLine("Po: ");
            RectangleAfter rect_after = new RectangleAfter() { Width = w, Height = h };
            SquareAfter sqr_after = new SquareAfter() {Side= s};
            AreaCalculatorAfter calc_after = new AreaCalculatorAfter();
            Console.WriteLine("prostokąt o wymiarach {0} na {1} ma pole {2}", w, h, calc_after.CalculateArea(rect_after));
            Console.WriteLine("kwadrat o wymiarze boku {0} ma pole {1}", s, calc_after.CalculateArea(sqr_after));
        }
    }
}