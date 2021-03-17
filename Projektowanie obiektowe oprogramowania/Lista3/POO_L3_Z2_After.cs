using System;

namespace POO_L3_Z2_After {
    public class ReportPrinterAfter {
        public void PrintReport() {
            Console.Writeline("Contents of document:");
            FormatDocument();
        }
    }
    public class DataGetter { 
        public string GetData() {
            return "AAA";
        }
    }
    public class DocumentFormatter {
        public void FormatDocument() {
            string s=GetData();
            Console.Writeline(s);
        }
    }
}