using System;

namespace POO_L4_Z1 {
    public class UniversalSingleton {
        public static UniversalSingleton singlInstance;
        private static object lockObject=new object();
        public static UniversalSingleton Instance() {
            if(singlInstance == null) {
                lock (lockObject) {
                    if(singlInstance == null) {
                        singlInstance = new UniversalSingleton();
                    }
                }
            }
            return singlInstance;
        }
    }
    public class ThreadSingleton {
        [ThreadStatic] public static ThreadSingleton singlInstance;
         public static UniversalSingleton Instance() {
            if(singlInstance == null) {
                singlInstance = new ThreadSingleton();
            }
            return singlInstance;
        }
    }
    public class TimedSingleton {
        public static TimedSingleton singlInstance;
        private static object lockObject=new object();
        private static DateTime update;

        TimedSingleton() {
            update=DateTime.Now;
        }
        
        public static TimedSingleton Instance() {
            bool isExpired = update.AddSeconds(5) <= DateTime.Now;
            if(singlInstance == null || isExpired) {
                lock (lockObject) {
                    if(singlInstance == null || isExpired) {
                        singlInstance = new TimedSingleton();
                    }
                }
            }
            return singlInstance;
        }
    }
}