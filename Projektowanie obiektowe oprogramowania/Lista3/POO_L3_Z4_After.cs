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
}