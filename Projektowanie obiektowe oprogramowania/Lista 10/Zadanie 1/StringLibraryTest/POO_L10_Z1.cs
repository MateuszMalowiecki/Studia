using System;
using System.Reflection;
using System.Collections.Generic;

namespace POO_L10_Z1 {
    public abstract class Creator {
        public abstract T ObjCreate<T>();
    }
    public class SinglCreator : Creator {
        object instance;
        public ConstructorInfo constr;
        public SinglCreator(ConstructorInfo constr) {
            this.constr=constr;
        }
        public override T ObjCreate<T>() {
            if(instance==null) {
                instance=constr.Invoke(new object[] {});
            }
            return (T)instance;
        }
    }
    public class ObjCreator : Creator {
        public ConstructorInfo constr;
        public ObjCreator(ConstructorInfo constr) {
            this.constr=constr;
        }
        public override T ObjCreate<T>() {
            return (T)constr.Invoke(new object[] {});
        }
    }
    public class InstCreator : Creator {
        object instance;
        public InstCreator(object instance) {
            this.instance=instance;
        }
        public override T ObjCreate<T>() {
            return (T)instance;
        }
    }
    public class SimpleContainer {
        private Dictionary<Type, Creator> creators;
        public SimpleContainer() {
            creators=new Dictionary<Type, Creator>();
        }
        public void RegisterType<T>( bool Singleton ) where T : class {
            ConstructorInfo constr=typeof(T).GetConstructor(new Type[] {});
            if(Singleton) {
                creators[typeof(T)] = new SinglCreator(constr);
            }
            else {
                creators[typeof(T)] = new ObjCreator(constr);
            }
        }
        public void RegisterType<From, To>( bool Singleton ) where To : From {
            ConstructorInfo constr=typeof(To).GetConstructor(new Type[] {});
            if(Singleton) {
                creators[typeof(From)] = new SinglCreator(constr);
            }
            else {
                creators[typeof(From)] = new ObjCreator(constr);
            }
        }
        public void RegisterInstance<T>( T Instance ) {
            creators[typeof(T)]=new InstCreator(Instance);
        }
        public T Resolve<T>() where T : class {
            var objectType=typeof(T);
            Creator creator=null;
            if (!creators.TryGetValue(objectType, out creator)) {
                if(objectType.IsInterface) {
                    throw new ArgumentException(String.Format("Not registered interface {0} passed to function resolve", objectType));
                }
                if(objectType.IsAbstract) {
                    throw new ArgumentException(String.Format("Not registered abstract class {0} passed to function resolve", objectType));
                }
                RegisterType<T>(false);
                creators.TryGetValue(objectType, out creator);
            }
            return creator.ObjCreate<T>();
        }
    }
}