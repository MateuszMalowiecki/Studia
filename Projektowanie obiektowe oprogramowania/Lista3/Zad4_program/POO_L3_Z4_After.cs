using System;

namespace POO_L3_Z4_After {
    public abstract class Shape {
        public abstract int CalculateArea();
    }
    public class RectangleAfter : Shape {
        public virtual int Width { get; set; }
        public virtual int Height { get; set; }
        public override int CalculateArea() {
            return this.Width * this.Height;
        }
    }

    public class SquareAfter : Shape {
        public virtual int Side { get; set;}
        public override int CalculateArea() {
            return this.Side*this.Side;
        }
    }
    public class AreaCalculatorAfter {
        public int CalculateArea( Shape s ) {
            return s.CalculateArea();
        }
    }
}