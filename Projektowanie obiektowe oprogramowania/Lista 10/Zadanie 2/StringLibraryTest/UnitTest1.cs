using Microsoft.VisualStudio.TestTools.UnitTesting;
using POO_L10_Z2;
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
            //Assert.IsInstanceOfType(f1, typeof(Foo));
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
            //Assert.IsInstanceOfType(q, typeof(Qux));
            //Assert.IsInstanceOfType(q.foo, typeof(Foo));        
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
    }
}
