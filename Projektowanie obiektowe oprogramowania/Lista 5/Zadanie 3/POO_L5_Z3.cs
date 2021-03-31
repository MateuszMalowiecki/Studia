using System;
using POO_L4_Z3;

namespace POO_L5_Z3 {
    public class ProtectingAirportProxy : IAirport {
        Airport airport;
        
        public ProtectingAirportProxy(int capacity) {
            airport=new Airport(capacity);
        }
        
        private bool areMethodsAvailable() {
            var now=DateTime.Now;
            //Console.WriteLine(now.Hour);
            return now.Hour >= 8 && now.Hour <= 21;
        }
        
        public Plane AcquirePlane() {
            if(areMethodsAvailable()) {
                return this.airport.AcquirePlane();
            }
            throw new InvalidOperationException("Operations are available only between 8 and 22");
        }
        
        public void ReleasePlane(Plane plane) {
            if(areMethodsAvailable()) {
                this.airport.ReleasePlane(plane);
                return;
            }
            throw new InvalidOperationException("Operations are available only between 8 and 22");
        }
    }
    public class LoggingAirportProxy : IAirport {
        Airport airport;
        
        public LoggingAirportProxy(int capacity) {
            airport=new Airport(capacity);
        }
        
        public Plane AcquirePlane() {
            Console.WriteLine("AcquirePlane call at: {0} with no parameters", DateTime.Now);
            var plane = this.airport.AcquirePlane();
            Console.WriteLine("Call finished at: {0}. Plane {1} returned", DateTime.Now, plane.ToString());
            return plane;
        }
        
        public void ReleasePlane(Plane plane) {
            Console.WriteLine("ReleasePlane call at: {0} with parameter {1}", DateTime.Now, plane.ToString());
            this.airport.ReleasePlane(plane);
            Console.WriteLine("Call finished at: {0}.", DateTime.Now);
        }
    }
    class Test {
        public static void Main() {

            var protAirport = new ProtectingAirportProxy(6);
            var plane = protAirport.AcquirePlane();
            protAirport.ReleasePlane(plane);

            var logAirport = new LoggingAirportProxy(6);
            plane = logAirport.AcquirePlane();
            logAirport.ReleasePlane(plane);
        }
    }  
}