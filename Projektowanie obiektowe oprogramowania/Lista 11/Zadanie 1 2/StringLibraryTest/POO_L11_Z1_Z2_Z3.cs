using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;

namespace POO_L11_Z1_Z2_Z3 {
    public class DependencyConstrutorAttribute: Attribute {}
    public class DependencyPropertyAttribute : Attribute {}
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

        //Zadanie 1
        public void ResolveProperty(object instance, List<Type> typesResolved) {
            foreach (var property in instance.GetType().GetProperties()) {
                if(Attribute.IsDefined(property, typeof(DependencyPropertyAttribute))
                    && property.CanWrite
                    && property.SetMethod.IsPublic) {
                        property.SetValue(instance, Resolve(property.PropertyType, typesResolved));
                }
            }
        }

        public object Resolve(Type objectType, List<Type> typesResolved) {
            if(typesResolved.Contains(objectType)) {
                throw new ArgumentException("Detected cycle in derivation tree");
            }
            object hiddenObject;
            if (!objects.TryGetValue(objectType, out hiddenObject)) {
                //I can't use variable as generic type in RegisterType function, 
                //when objectType is concrete, so I throw an exception instead.
                throw new ArgumentException(String.Format("Not registered class {0} passed to function resolve", objectType));
            }
            if(hiddenObject is Type) {
                typesResolved.Add(objectType);
                ConstructorInfo[] constrs=((Type)hiddenObject).GetConstructors();
                ConstructorInfo chosenConstr=Enumerable.ToList(constrs.OrderByDescending(constr => constr.GetParameters().Length))[0];
                ConstructorInfo[] dependencyConstrs = Array.FindAll(constrs, constr => Attribute.IsDefined(constr, typeof(DependencyConstrutorAttribute)));
                if(dependencyConstrs.Length == 1) {
                    chosenConstr=dependencyConstrs[0];
                }
                object newObject = chosenConstr.Invoke(chosenConstr.GetParameters().Select(param => {
                        return Resolve(param.ParameterType, typesResolved);
                    }
                ).ToArray());
                ResolveProperty(newObject, typesResolved);
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

        //Zadanie 2
        public void BuildUp<T>( T Instance ) {
            ResolveProperty(Instance, new List<Type>());
        }
    }

    //Zadanie 3
    public delegate SimpleContainer ContainerProviderDelegate();

    public class ServiceLocator {
        private static ContainerProviderDelegate ContProv;
        private static ServiceLocator Instance;
        public static void SetContainerProvider( ContainerProviderDelegate ContainerProvider ) {
            ContProv=ContainerProvider;
        }
        public static ServiceLocator Current {
            get { 
                if(Instance == null) {
                    Instance=new ServiceLocator();
                }
                return Instance;
            }
        }
        public T GetInstance<T>() where T : class {
            if (typeof(T) == typeof(SimpleContainer)) {
                return (T)(object)ContProv();
            }
            return ContProv().Resolve<T>();
        }
    }
}