using System;

namespace POO_L11_Z4 {
    public interface IPrinter {
        void print();
    }

    public class FirstPrinter {
        public void print() {
            Console.WriteLine("First printer prints.");
        }
    }
    public class SecondPrinter {
        public void print() {
            Console.WriteLine("Second printer prints.");
        }
    }
    public class LocalFactory {
        private static Func<FirstPrinter> FirstPrinterProvider;
        private static Func<SecondPrinter> SecondPrinterProvider;
        public static void SetProviders(Func<FirstPrinter> FirstProvider, Func<SecondPrinter> SecondProvider) {
            FirstPrinterProvider=FirstProvider;
            SecondPrinterProvider=SecondProvider;
        }
        public FirstPrinter CreateFirst() {
            if(FirstPrinterProvider != null) {
                return FirstPrinterProvider();
            }
            throw new ArgumentException();
        }
        public SecondPrinter CreateSecond() {
            if(SecondPrinterProvider != null) {
                return SecondPrinterProvider();
            }
            throw new ArgumentException();
        }
    }
    public class Test {
        public static void CompositionRoot() {
            LocalFactory.SetProviders(() => new FirstPrinter(), () => new SecondPrinter());
        }
        public static void Main() {
            CompositionRoot();
            LocalFactory factory=new LocalFactory();
            var First=factory.CreateFirst();
            First.print();
            var Second = factory.CreateSecond();
            Second.print();
        }
    }
}