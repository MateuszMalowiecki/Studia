using System;
using System.IO;
using System.Threading.Tasks;

namespace POO_L6_Z1 {
    public interface ILogger {
        void Log(string Message);
    }
    
    //Null object
    public class NoneLogger : ILogger {
        public void Log(string Message) {}
    } 
    public class ConsoleLogger : ILogger {       
        public void Log(string Message) {
            Console.WriteLine(Message);
        }
    } 
    public class FileLogger : ILogger {
        private string filePath;
        public FileLogger(string path) {
            this.filePath = path;
        }
        public async void Log(string Message) {
            await File.WriteAllTextAsync(filePath, Message);
        }
    } 
    
    public enum LogType { None, Console, File }
    
    public class LoggerFactory {
        private static LoggerFactory singletonInstance;
        public ILogger GetLogger( LogType LogType, string Parameter = null ) { 
            switch (LogType) {
                case LogType.None:
                    return new NoneLogger();
                case LogType.Console:
                    return new ConsoleLogger();
                case LogType.File:
                    return new FileLogger(Parameter);
                default:
                    throw new ArgumentException();
            }
        }
        public static LoggerFactory Instance() { 
            if(singletonInstance == null) {
                singletonInstance = new LoggerFactory();
            }
            return singletonInstance; 
        }
    }
    public class Test {
        public static void Main() {
            var factory=LoggerFactory.Instance();
            ILogger logger1 = factory.GetLogger( LogType.File, "./foo.txt" );
            logger1.Log("foo"); // logowanie do pliku
            ILogger logger2 = factory.GetLogger( LogType.None );
            logger2.Log("bar"); // brak logowania
            ILogger logger3 = factory.GetLogger( LogType.Console );
            logger3.Log("qux"); // logowanie na konsolę
        }
    }
}