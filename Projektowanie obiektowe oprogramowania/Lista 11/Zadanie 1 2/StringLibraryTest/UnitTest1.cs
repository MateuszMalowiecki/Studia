using Microsoft.VisualStudio.TestTools.UnitTesting;
using POO_L11_Z1_Z2_Z3;
using System;

namespace StringLibraryTest {
    [TestClass]
    public class UnitTest1 {
        interface IFoo {}
        
        class Foo : IFoo {}
        
        class Bar {
            public Bar() {}
            public Bar(Bar bar) {}
        }
        class Qux {
            public Foo foo;
            public Qux(Foo foo) {
                this.foo=foo;
            }
        } 

        class Baz {
            [DependencyConstrutor]
            public Baz() {}

            public Baz(Baz baz) {}
        }
        public class A {
            public A() { }
            
            [DependencyProperty]
            public D TheD { get; set; } 
        }
        public class B {
            public B() { }
            
            [DependencyProperty]
            public D TheD { get; private set; } 
        }
        public class C {
            public C() { }
            
            [DependencyProperty]
            public D TheD { get; } 
        }
        public class D {} 
        [TestMethod]
        public void SingletonCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Foo>(true);
            Foo f1 = c.Resolve<Foo>();
            Foo f2 = c.Resolve<Foo>();
            Assert.AreSame(f1, f2);
        }
        [TestMethod]
        public void NormalCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Foo>(false);
            Foo f1 = c.Resolve<Foo>();
            Foo f2 = c.Resolve<Foo>();
            Assert.AreNotSame(f1, f2);
        }
        [TestMethod]
        public void InterfaceCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<IFoo, Foo>(false);
            IFoo f = c.Resolve<IFoo>();
            Assert.IsInstanceOfType(f, typeof(Foo));
        }
        [TestMethod]
        public void InterfaceSingletonCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<IFoo, Foo>(true);
            IFoo f1 = c.Resolve<IFoo>();
            IFoo f2 = c.Resolve<IFoo>();
            Assert.IsInstanceOfType(f1, typeof(Foo));
            Assert.IsInstanceOfType(f2, typeof(Foo));
            Assert.AreSame(f1, f2);
        }
        [TestMethod]
        public void UnregisteredConcreteTypeCreation() {
            SimpleContainer c = new SimpleContainer();
            Assert.ThrowsException<ArgumentException>(() => {Foo f1 = c.Resolve<Foo>();});
        }
        [TestMethod]
        public void UnregisteredAbstractTypeCreation() {
            SimpleContainer c = new SimpleContainer();
            Assert.ThrowsException<ArgumentException>(() => { IFoo f1 = c.Resolve<IFoo>(); });
        }
        [TestMethod]
        public void InstanceCreation() {
            SimpleContainer c = new SimpleContainer();
            IFoo f1 = new Foo();
            c.RegisterInstance<IFoo>( f1 );
            IFoo f2 = c.Resolve<IFoo>();
            Assert.IsInstanceOfType(f2, typeof(Foo));
            Assert.AreSame(f1, f2);
        }
        [TestMethod]
        public void CyclicCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Bar>(false);
            Assert.ThrowsException<ArgumentException>(() => { Bar b = c.Resolve<Bar>(); });
        }
        [TestMethod]
        public void RegisteredParametersCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Foo>(false);
            c.RegisterType<Qux>(false);
            Qux q = c.Resolve<Qux>();
            Assert.IsInstanceOfType(q, typeof(Qux));
            Assert.IsInstanceOfType(q.foo, typeof(Foo));
        }
        [TestMethod]
        public void UnregisteredParametersCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Qux>(false);
            Assert.ThrowsException<ArgumentException>(() => { Qux q = c.Resolve<Qux>(); });
        }
        [TestMethod]
        public void RegisteredParametersSingletonCreation() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Foo>(false);
            c.RegisterType<Qux>(true);
            Qux q = c.Resolve<Qux>();
            Qux q2 = c.Resolve<Qux>();
            Assert.AreSame(q, q2);
        }
        [TestMethod]
        public void DependencyConstrutorTest() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<Baz>(false);
            Baz b = c.Resolve<Baz>();
            Assert.IsInstanceOfType(b, typeof(Baz));
        }
        
        //Testy do zadania 1
        [TestMethod]
        public void PropertyTest() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<A>(false);
            c.RegisterType<D>(false);
            Assert.IsInstanceOfType(c.Resolve<A>().TheD, typeof(D));
        }

        [TestMethod]
        public void PropertyPrivateSetterTest() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<B>(false);
            c.RegisterType<D>(false);
            Assert.IsNull(c.Resolve<B>().TheD);
        }

        [TestMethod]
        public void PropertyNoSetterTest() {
            SimpleContainer c = new SimpleContainer();
            c.RegisterType<C>(false);
            c.RegisterType<D>(false);
            Assert.IsNull(c.Resolve<C>().TheD);
        }
        
        //Testy do zadania 2
        [TestMethod]
        public void BuildUpTest() {
            SimpleContainer c = new SimpleContainer();
            A TheA = new A();
            c.RegisterType<D>(false);
            Assert.IsNull(TheA.TheD);
            c.BuildUp( TheA );
            Assert.IsNotNull(TheA.TheD); 
        }

        //Testy do zadania 3
        [TestMethod]
        public void ServiceLocatorSingletonTest() {
            SimpleContainer c = new SimpleContainer();
            ContainerProviderDelegate containerProvider = () => c;
            ServiceLocator.SetContainerProvider( containerProvider );
            ServiceLocator s=ServiceLocator.Current;
            SimpleContainer c1=s.GetInstance<SimpleContainer>();
            SimpleContainer c2=s.GetInstance<SimpleContainer>();
            Assert.AreSame(c1, c2);
        }
        
        [TestMethod]
        public void ServiceLocatorTest() {
            ContainerProviderDelegate containerProvider = () => new SimpleContainer();
            ServiceLocator.SetContainerProvider( containerProvider );
            ServiceLocator s=ServiceLocator.Current;
            SimpleContainer c1=s.GetInstance<SimpleContainer>();
            SimpleContainer c2=s.GetInstance<SimpleContainer>();
            Assert.AreNotSame(c1, c2);
        }

        [TestMethod]
        public void ServiceLocatorGetInstanceTest() {
            SimpleContainer c = new SimpleContainer();
            ContainerProviderDelegate containerProvider = () => c;
            ServiceLocator.SetContainerProvider( containerProvider );
            c.RegisterType<Baz>(false);
            Baz baz = ServiceLocator.Current.GetInstance<Baz>();
            Assert.IsNotNull(baz);
        }
    }
}
