using Microsoft.VisualStudio.TestTools.UnitTesting;
using POO_L4_Z1;
using System.Threading;

namespace StringLibraryTest {
    
    [TestClass]
    public class UnitTest1 {
        
        [TestMethod]
        public void UniversalSingletonHasOneInstance() {
            var us1 = UniversalSingleton.Instance();
            var us2 = UniversalSingleton.Instance();
            
            Assert.IsNotNull(us1);
            Assert.AreSame(us1, us2);
        }
        
        [TestMethod]
        public void UniversalSingletonCreatedWithThreadsHasOneInstance() {
            UniversalSingleton us1=null, us2=null; 
            
            var Thread1=new Thread(() => us1=UniversalSingleton.Instance());
            var Thread2=new Thread(() => us2=UniversalSingleton.Instance());

            Thread1.Start();
            Thread2.Start();
            
            Thread1.Join();
            Thread2.Join();
            
            Assert.IsNotNull(us1);
            Assert.AreSame(us1, us2);
        }

        [TestMethod]
        public void ThreadSingletonHasOneInstance() {
            var us1 = ThreadSingleton.Instance();
            var us2 = ThreadSingleton.Instance();
            
            Assert.IsNotNull(us1);
            Assert.AreSame(us1, us2);
        }
        
        
        [TestMethod]
        public void ThreadSingletonCreatedWithThreadsHasOneInstance() {
            ThreadSingleton us1=null, us2=null; 
            
            var Thread1=new Thread(() => us1=ThreadSingleton.Instance());
            var Thread2=new Thread(() => us2=ThreadSingleton.Instance());

            Thread1.Start();
            Thread2.Start();
            
            Thread1.Join();
            Thread2.Join();
            
            Assert.IsNotNull(us1);
            Assert.IsNotNull(us2);
            Assert.AreNotSame(us1, us2);
        }
        
        [TestMethod]
        public void TimedSingletonHasOneInstance() {
            var us1 = TimedSingleton.Instance();
            var us2 = TimedSingleton.Instance();
            
            Assert.IsNotNull(us1);
            Assert.AreSame(us1, us2);
        }
        
        [TestMethod]
        public void TimedSingletonChangesInstanceAfterSomeTime() {
            var us1 = TimedSingleton.Instance();
            Thread.Sleep(6000);
            var us2 = TimedSingleton.Instance();
            
            Assert.IsNotNull(us1);
            Assert.IsNotNull(us2);
            Assert.AreNotSame(us1, us2);
        }
    }
}