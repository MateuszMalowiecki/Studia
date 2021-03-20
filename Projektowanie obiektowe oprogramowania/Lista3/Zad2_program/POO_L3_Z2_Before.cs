using System;

namespace POO_L3_Z2_Before {
    public class ReportPrinter {
        public string GetData() {
            return "AAA";
        }
        public void FormatDocument() {
            string s=GetData();
            Console.WriteLine(s);
        }
        public void PrintReport() {
            Console.WriteLine("Zawartość dokumentu:");
            FormatDocument();
        }
    }
}