using System;

namespace POO_L3_Z4_Test {
    public class Test {
        public static void Main() {
            Console.WriteLine("Przed: ");
            int w = 4, h = 5;
            POO_L3_Z4_BeforeRectangle rect_before = new POO_L3_Z4_Before.Square() { Width = w, Height = h };
            POO_L3_Z4_BeforeAreaCalculator calc_before = new POO_L3_Z4_Before.AreaCalculator();
            Console.WriteLine( "prostokąt o wymiarach {0} na {1} ma pole {2}", w, h, calc.CalculateArea( rect ) );

            Console.WriteLine("Po: ");
            int w = 4, h = 5, s = 7;
            POO_L3_Z4_After.Rectangle rect = new POO_L3_Z4_AfterRectangle() { Width = w, Height = h };
            POO_L3_Z4_After.Square sqr = new POO_L3_Z4_After.Square() {Side= s};
            POO_L3_Z4_After.AreaCalculator calc = new POO_L3_Z4_After.AreaCalculator();
            Console.WriteLine("prostokąt o wymiarach {0} na {1} ma pole {2}", w, h, calc.CalculateArea(rect));
            Console.WriteLine("kwadrat o wymiarze boku {0} ma pole {1}", s, calc.CalculateArea(sqr));
        }
    }
}