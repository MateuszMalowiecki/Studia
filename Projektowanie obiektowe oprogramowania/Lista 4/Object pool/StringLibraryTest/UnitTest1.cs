using Microsoft.VisualStudio.TestTools.UnitTesting;
using POO_L4_Z3;
using System;

namespace StringLibraryTest {
    [TestClass]
    public class UnitTest1 {

        [TestMethod]
        public void InvalidCapacity() {
            Assert.ThrowsException<ArgumentException>(() => new Airport(-5));
            Assert.ThrowsException<ArgumentException>(() => new Airport(0));
        }

        [TestMethod]
        public void TakingFromNonEmptyPoolShouldWork() {
            var airport = new Airport(44);
            Assert.IsNotNull(airport);
            var plane = airport.AcquirePlane();
            Assert.IsNotNull(plane);
        }
        

        [TestMethod]
        public void TakeTooMuchPlanes() {
           var airport = new Airport(10);
           for(int i=0; i<10; i++ ){
               var plane = airport.AcquirePlane();
               Assert.IsNotNull(plane);
           }
            Assert.ThrowsException<ArgumentException>(() => airport.AcquirePlane());
        }
        
        [TestMethod]
        public void TakeAndReturnSamePlane() {
            var airport = new Airport(10);
            var plane = airport.AcquirePlane();
            Assert.IsNotNull(plane);
            airport.ReleasePlane(plane);
            var plane2 = airport.AcquirePlane();
            Assert.AreSame(plane, plane2);
        }

        [TestMethod]
        public void TakeAndReturnOtherPlane() {
            var airport = new Airport(10);
            var plane = airport.AcquirePlane();
            Assert.IsNotNull(plane);
            var plane2 = new Plane();
            Assert.ThrowsException<ArgumentException>(() => airport.ReleasePlane(plane2));
        }
        
        [TestMethod]
        public void MultipleAirports() {
            var airport = new Airport(10);
            var airport2 = new Airport(20);
            var plane = airport.AcquirePlane();
            Assert.IsNotNull(plane);
            var plane2 = airport2.AcquirePlane();
            Assert.IsNotNull(plane2);
            Assert.ThrowsException<ArgumentException>(() => airport.ReleasePlane(plane2));
            Assert.ThrowsException<ArgumentException>(() => airport2.ReleasePlane(plane));
        }
    }
}
