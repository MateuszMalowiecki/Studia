using System;

namespace POO_L3_Z2_Before {
    public class ReportPrinter {
        public string GetData() {
            return "AAA";
        }
        public void FormatDocument() {
            string s=GetData();
            Console.Writeline(s);
        }
        public void PrintReport() {
            Console.Writeline("Contents of document:");
            FormatDocument();
        }
    }
}