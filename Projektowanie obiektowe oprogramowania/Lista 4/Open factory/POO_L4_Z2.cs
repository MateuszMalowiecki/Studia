using System;

namespace POO_L4_Z2 {
    public interface IShapeFactoryWorker {
        bool AcceptsParameters(string s);
        IShape CreateShape(params object[] parameters);
    }

    public class SquareWorker : IShapeFactoryWorker {
        bool AcceptsParameters(string s) {
            return s == "Square";
        }
        IShape CreateShape(object[] parameters) {
            return new Square(parameters[0]);
        }
    }
    
    public class RectangleWorker : IShapeFactoryWorker {
        bool AcceptsParameters(string s) {
            return s == "Rectangle";
        }
        IShape CreateShape(object[] parameters) {
            return new Rectangle(parameters[0], parameters[1]);
        }
    }
    
    public class CircleWorker : IShapeFactoryWorker {
        bool AcceptsParameters(string s) {
            return s == "Circle";
        }
        IShape CreateShape(object[] parameters) {    
            return new Circle(parameters[0]);
        }
    }
    public interface IShape {
        double getArea();
    }
    
    public class Square : IShape {
        int Side
        Square(int side) {
            this.side=side
        }
        public double getArea() {
            return this.side * this.side;
        }
    }
    
    public class Rectangle : IShape {
        int width;
        int height;
        Rectangle(int width, int height) {
            this.width=width;
            this.height=height;
        }
        public double getArea() {
            return this.width * this.height;
        }
    }
    
    public class Circle : IShape {
        int radius;
        Circle(int radius) {
            this.radius=radius;
        }
        public double getArea () {
            return System.Math.PI * this.radius * this.radius;
        }
    }

    public class ShapeFactory {
        List<IShapeFactoryWorker> workers=new List<IShapeFactoryWorker>();
        public RegisterWorker( IShapeFactoryWorker worker ) {
            workers.Add(worker);
        }
        public IShape CreateShape( string ShapeName, params object[] parameters ) {
            foreach(var worker in workers) {
                if(worker.AcceptsParameters(ShapeName)) {
                    worker.CreateShape(parameters);
                }
            }
            throw new ArgumentException();
        }
    }
}