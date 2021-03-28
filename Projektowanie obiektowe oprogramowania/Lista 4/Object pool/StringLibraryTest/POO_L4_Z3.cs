using System;
using System.Collections.Generic;

namespace POO_L4_Z3 {
    public class Plane {}
    public class Airport {
        private int capacity;
        private List<Plane> released = new List<Plane>();
        private List<Plane> ready = new List<Plane>();
        public Airport(int capacity) {
            if (capacity <= 0) {
                throw new ArgumentException();
            }
            this.capacity=capacity;
        }

        public Plane AcquirePlane() {
            if (released.Count >= capacity) {
                throw new ArgumentException();
            }
            if(ready.Count == 0) {
                ready.Add(new Plane());
            }
            var plane=ready[0];
            released.Add(plane);
            ready.Remove(plane);
            return plane;
        }

        public void ReleasePlane(Plane plane) {
            if (!released.Contains(plane)) {
                throw new ArgumentException();
            }
            released.Remove(plane);
            ready.Add(plane);
        }       
    }
}