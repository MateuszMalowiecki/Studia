using System;
using System.Collections.Generic;
using System.IO;

namespace POO_L7_Z3 {
    abstract class Handler {
        protected Handler nextHandler;
        public abstract void handle(string mail);
    }
    class Archivizer : Handler {
        private string path;
        public Archivizer(string path, Handler h) {
            this.path=path;
            this.nextHandler=h;
        }
        public override void handle(string mail) {
            File.WriteAllText(path, mail);
            nextHandler.handle(mail);
        }
    }
    class LegalDepartment : Handler {
        public LegalDepartment() {}
        public LegalDepartment(Handler h) {
            this.nextHandler=h;
        }
        public override void handle(string mail) {
            if(mail[0] == 'c') {
                Console.WriteLine("Legal department received a complaint");
            }
            else {
                nextHandler.handle(mail);
            }
        }
    } 
    class MarketingDepartment : Handler {
        public MarketingDepartment() {}
        public MarketingDepartment(Handler h) {
            this.nextHandler=h;
        }
        public override void handle(string mail) {
            if(mail[0] == 'r') {
                Console.WriteLine("Marketing department received some mail");
            }
            else {
                nextHandler.handle(mail);
            }
        }
    }  
    class SalesDepartment : Handler {
        public SalesDepartment() {}
        public SalesDepartment(Handler h) {
            this.nextHandler=h;
        }
        public override void handle(string mail) {
            if(mail[0] == 'o') {
                Console.WriteLine("Sales department received an order");
            }
            else {
                nextHandler.handle(mail);
            }
        }
    }  
    class President : Handler {
        public President() {}
        public President(Handler h) {
            this.nextHandler=h;
        }
        public override void handle(string mail) {
            if(mail[0] == 'p') {
                Console.WriteLine("President received a praise");
            }
            else {
                nextHandler.handle(mail);
            }
        }
    }
    class Program {
        static void Main(string[] args) {
            Handler h=new Archivizer("./foo.txt", new LegalDepartment(new MarketingDepartment(new SalesDepartment(new President()))));
            string[] mails={"o", "c", "r", "p"};
            foreach(var mail in mails) {
                h.handle(mail);
            }
        }
    } 
}