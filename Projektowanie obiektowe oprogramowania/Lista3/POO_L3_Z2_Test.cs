using System;

namespace POO_L3_Z2_Test {
    public class Test {
        public static void Main() {
            var before_printer=new POO_L3_Z2_Before.ReportPrinter();
            var after_printer=new POO_L3_Z2_After.ReportPrinterAfter();

            Console.Writeline("Przed: ");
            before_printer.PrintReport();

            Console.Writeline("Po: ");
            after_printer.PrintReport();
        }
    }
}