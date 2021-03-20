using System;

namespace POO_L3_Z2_After {
    public class ReportPrinterAfter {
        public void PrintReport(DocumentFormatter df, DataGetter dg) {
            Console.WriteLine("Zawartość dokumentu:");
            df.FormatDocument(dg);
        }
    }
    public class DataGetter { 
        public string GetData() {
            return "AAA";
        }
    }
    public class DocumentFormatter {
        public void FormatDocument(DataGetter dg) {
            string s=dg.GetData();
            Console.WriteLine(s);
        }
    }
}