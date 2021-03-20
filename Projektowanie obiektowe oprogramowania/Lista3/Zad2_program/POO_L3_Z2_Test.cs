using System;
using POO_L3_Z2_Before;
using POO_L3_Z2_After;

namespace POO_L3_Z2_Test {
    public class Test {
        public static void Main() {
            ReportPrinter before_printer=new ReportPrinter();
            ReportPrinterAfter after_printer=new ReportPrinterAfter();

            Console.WriteLine("Przed: ");
            before_printer.PrintReport();

            Console.WriteLine("Po: ");
            after_printer.PrintReport(new DocumentFormatter(), new DataGetter());
        }
    }
}