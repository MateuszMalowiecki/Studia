using Microsoft.VisualStudio.TestTools.UnitTesting;
using POO_L4_Z2;
using System;

namespace StringLibraryTest {
    [TestClass]
    public class UnitTest1 {
        [TestMethod]
        public void SquareIsAlreadyDefined() {
            ShapeFactory factory = new ShapeFactory();
            IShape square = factory.CreateShape( "Square", 5 );
            
            Assert.IsNotNull(square);
            Assert.AreEqual(25, square.getArea());
            Assert.AreEqual(20, square.getPerimeter());
        }
        
        [TestMethod]
        public void CircleIsNotYetDefined() {
            ShapeFactory factory = new ShapeFactory();
            Assert.ThrowsException<ArgumentException>(() => factory.CreateShape( "Circle", 5 ));
        }

        [TestMethod]
        public void CircleIsNowDefined() {
            ShapeFactory factory = new ShapeFactory();
            factory.RegisterWorker(new CircleWorker());
            IShape circle=factory.CreateShape("Circle", 1);
            Assert.IsNotNull(circle);
            Assert.AreEqual(System.Math.PI, circle.getArea());
            Assert.AreEqual(2 * System.Math.PI, circle.getPerimeter());
        }
        
        [TestMethod]
        public void TooManyParameters() {
            ShapeFactory factory = new ShapeFactory();
            Assert.ThrowsException<ArgumentException>(() => factory.CreateShape( "Square", 5 , 42));
        }

        [TestMethod]
        public void TooLessParameters() {
            ShapeFactory factory = new ShapeFactory();
            factory.RegisterWorker(new RectangleWorker());
            Assert.ThrowsException<ArgumentException>(() => factory.CreateShape( "Rectangle", 5));
        }

        [TestMethod]
        public void RectangleTest() {
            ShapeFactory factory = new ShapeFactory();
            factory.RegisterWorker(new RectangleWorker());
            var rectangle=factory.CreateShape( "Rectangle", 3, 5);
            Assert.IsNotNull(rectangle);
            Assert.AreEqual(15, rectangle.getArea());
            Assert.AreEqual(16, rectangle.getPerimeter());
        }
    }
}
