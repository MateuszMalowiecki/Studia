using System;

namespace POO_L3_Z7 {
    public class ReportPrinterAfter {
        public void PrintReport(ReportComposer rc) {
            Console.Writeline("Zawartość dokumentu:");
            rc.FormatDocument();
        }
    }
    public class ReportComposer {
        private DataGetter dg;
        private DocumentFormatter df;
        public ReportComposer(DataGetter dg, DocumentFormatter df) {
            this.dg=dg;
            this.df=df;
        }
        public void FormatDocument() {
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
            Console.Writeline(s);
        }
    }
}