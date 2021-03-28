using System;
using System.Collections.Generic;

namespace POO_L4_Z2 {
    public interface IShapeFactoryWorker {
        bool AcceptsParameters(string s, object[] parameters);
        IShape CreateShape(object[] parameters);
    }

    public class SquareWorker : IShapeFactoryWorker {
        public bool AcceptsParameters(string s, object[] parameters) {
            return s == "Square" && parameters.Length == 1;
        }
        public IShape CreateShape(object[] parameters) {
            return new Square((int)parameters[0]);
        }
    }
    
    public class RectangleWorker : IShapeFactoryWorker {
        public bool AcceptsParameters(string s, object[] parameters) {
            return s == "Rectangle" && parameters.Length == 2;
        }
        public IShape CreateShape(object[] parameters) {
            return new Rectangle((int)parameters[0], (int)parameters[1]);
        }
    }
    
    public class CircleWorker : IShapeFactoryWorker {
        public bool AcceptsParameters(string s, object[] parameters) {
            return s == "Circle" && parameters.Length == 1;
        }
        public IShape CreateShape(object[] parameters) {    
            return new Circle((int)parameters[0]);
        }
    }

    public interface IShape {
        double getArea();
        double getPerimeter();
    }
    
    public class Square : IShape {
        int side;
        public Square(int side) {
            this.side = side;
        }
        public double getArea() {
            return this.side * this.side;
        }
        public double getPerimeter() {
            return 4 * this.side;
        }
    }
    
    public class Rectangle : IShape {
        int width;
        int height;
        public Rectangle(int width, int height) {
            this.width = width;
            this.height = height;
        }
        public double getArea() {
            return this.width * this.height;
        }
        public double getPerimeter() {
            return 2 * (this.width + this.height);
        }
    }
    
    public class Circle : IShape {
        int radius;
        public Circle(int radius) {
            this.radius=radius;
        }
        public double getArea() {
            return System.Math.PI * this.radius * this.radius;
        }
        public double getPerimeter() {
            return 2 * System.Math.PI * this.radius;
        }
    }

    public class ShapeFactory {
        List<IShapeFactoryWorker> workers=new List<IShapeFactoryWorker>();
       
        // Factory can create only squares at the beginning.
        public ShapeFactory() {
            RegisterWorker(new SquareWorker());
        }

        public void RegisterWorker( IShapeFactoryWorker worker ) {
            workers.Add(worker);
        }

        public IShape CreateShape( string ShapeName, params object[] parameters ) {
            foreach(var worker in workers) {
                if(worker.AcceptsParameters(ShapeName, parameters)) {
                    return worker.CreateShape(parameters);
                }
            }
            throw new ArgumentException(String.Format("Our factory doesn't create {0} shape", ShapeName));
        }
    }
}