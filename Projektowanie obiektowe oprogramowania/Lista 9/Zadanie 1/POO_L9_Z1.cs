using System;

namespace POO_L9_Z1 {
    public class SimpleContainer {
        public void RegisterType<T>( bool Singleton ) where T : class;
        public void RegisterType<From, To>( bool Singleton ) where To : From;
        public T Resolve<T>();
    }

}