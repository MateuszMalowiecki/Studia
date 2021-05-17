using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;

namespace POO_L10_Z2 {    
    public class SimpleContainer {
        private Dictionary<Type, object> objects;
        private List<Type> singletonTypes;
        public SimpleContainer() {
            objects=new Dictionary<Type, object>();
            singletonTypes=new List<Type>();
        }
        public void RegisterType<T>( bool Singleton ) where T : class {
            objects[typeof(T)] = typeof(T);
            if(Singleton) {
                singletonTypes.Add(typeof(T));
            }
            else {
                singletonTypes.Remove(typeof(T));
            }
        }
        public void RegisterType<From, To>( bool Singleton ) where To : From {
            objects[typeof(From)] = typeof(To);
            if(Singleton) {
                singletonTypes.Add(typeof(From));
            }
            else {
                singletonTypes.Remove(typeof(From));
            }
        }
        public void RegisterInstance<T>( T Instance ) {
            objects[typeof(T)]=Instance;
        }
        public object Resolve(Type objectType, List<Type> typesResolved) {
            if(typesResolved.Contains(objectType)) {
                throw new ArgumentException("Detected cycle in derivation tree");
            }
            object hiddenObject;
            if (!objects.TryGetValue(objectType, out hiddenObject)) {
                if(objectType.IsInterface) {
                    throw new ArgumentException(String.Format("Not registered interface {0} passed to function resolve", objectType));
                }
                if(objectType.IsAbstract) {
                    throw new ArgumentException(String.Format("Not registered abstract class {0} passed to function resolve", objectType));
                }
                throw new ArgumentException(String.Format("Not registered abstract class {0} passed to function resolve", objectType));
                //RegisterType<objectType>(false);
                //objects.TryGetValue(objectType, out hiddenObject);
            }
            if(hiddenObject is Type) {
                typesResolved.Add(objectType);
                ConstructorInfo[] constrs=((Type)hiddenObject).GetConstructors();
                ConstructorInfo chosenConstr=Enumerable.ToList(constrs.OrderByDescending(constr => constr.GetParameters().Length))[0];
                object newObject = chosenConstr.Invoke(chosenConstr.GetParameters().Select(param => {
                        return Resolve(param.ParameterType, typesResolved);
                    }
                ).ToArray());
                if (singletonTypes.Contains(objectType)) {
                    objects[objectType]=newObject;
                }
                return newObject;
            }
            return hiddenObject;
        }
        public T Resolve<T>() where T : class {
            return (T)Resolve(typeof(T), new List<Type>());
        }
    }
}