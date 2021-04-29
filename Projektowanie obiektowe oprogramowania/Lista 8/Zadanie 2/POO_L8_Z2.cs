using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

namespace POO_L8_Z2 {
    public abstract class DataAccessHandler {
        public abstract void DataConnect();
        public abstract void DataGet();
        public abstract void DataProcess();
        public abstract void ConnectionClose();
        public void Execute() {
            DataConnect();
            DataGet();
            DataProcess();
            ConnectionClose();
        }
    }

    public class SQLAccessHandler : DataAccessHandler {
        private SqlConnection conn;
        private string ColumnName;
        private string TableName;
        private int sum;

        public SQLAccessHandler(string ColumnName, string TableName) {
            this.ColumnName=ColumnName;
            this.TableName=TableName;
        }
        public override void DataConnect() {
            conn = new SqlConnection();
        }
        public override void DataGet() {
            string query=String.Format("SELECT SUM({0}) FROM {1}", ColumnName, TableName);
            SqlCommand sqlcmd = new SqlCommand(query, conn);
            sum=sqlcmd.ExecuteScalar();
        }
        public override void DataProcess() {
            Console.WriteLine("Wyliczona suma: {0}", sum);
        }
        public override void ConnectionClose() {
            conn.Close();
        }
    }
    public class XMLAccessHandler : DataAccessHandler {
        private string XMLFileName;
        private XmlDocument doc;
        
        public XMLAccessHandler(string XMLFileName) {
            this.XMLFileName=XMLFileName;
        }
        public override void DataConnect() {
            doc=new XmlDocument();
        }
        public override void DataGet() {
            doc.Load(XMLFileName);
        }
        public override void DataProcess() {
            XmlNode FileRoot = doc.FirstChild;
            Console.WriteLine("Longest node: {0}", FindLongestNode(FileRoot.ChildNodes));
        }
        private string FindLongestNode(XmlNodeList nodes) {
            string res="";
            foreach (XmlNode node in nodes) {
                string fromChildren=FindLongestNode(node.ChildNodes);
                if (fromChildren.Length > res.Length) {
                    res=fromChildren;
                }
                if (node.LocalName.Length > res.Length) {
                    res=node.LocalName;
                }
            }
            return res;
        }
        public override void ConnectionClose() {}
    }
    public class Test {
        public static void Main() {
            XMLAccessHandler xmlAccessHandler = new XMLAccessHandler("./Test-file.xml");
            xmlAccessHandler.Execute();
        }
    }
}