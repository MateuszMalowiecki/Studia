using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;


namespace POO_L8_Z3 {
    public interface IDataAccessStrategy {
        void DataConnect();
        void DataGet();
        void DataProcess();
        void ConnectionClose();
    }
    public class DataAccessHandler {
        IDataAccessStrategy str;
        public DataAccessHandler(IDataAccessStrategy str) {
            this.str=str;
        }
        public void Execute() {
            str.DataConnect();
            str.DataGet();
            str.DataProcess();
            str.ConnectionClose();
        }
    }
    public class SQLAccessStrategy : IDataAccessStrategy {
        private SqlConnection conn;
        private string ColumnName;
        private string TableName;
        private int sum;

        public SQLAccessStrategy(string ColumnName, string TableName) {
            this.ColumnName=ColumnName;
            this.TableName=TableName;
        }
        public void DataConnect() {
            conn = new SqlConnection();
        }
        public void DataGet() {
            string query=String.Format("SELECT SUM({0}) FROM {1}", ColumnName, TableName);
            SqlCommand sqlcmd = new SqlCommand(query, conn);
            sum=sqlcmd.ExecuteScalar();
        }
        public void DataProcess() {
            Console.WriteLine("Wyliczona suma: {0}", sum);
        }
        public void ConnectionClose() {
            conn.Close();
        }
    }
    public class XMLAccessStrategy : IDataAccessStrategy {
        private string XMLFileName;
        private XmlDocument doc;
        
        public XMLAccessStrategy(string XMLFileName) {
            this.XMLFileName=XMLFileName;
        }
        public void DataConnect() {
            doc=new XmlDocument();
        }
        public void DataGet() {
            doc.Load(XMLFileName);
        }
        public void DataProcess() {
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
        public void ConnectionClose() {}
    }
    public class Test {
        public static void Main() {
            DataAccessHandler xmlAccessHandler = new DataAccessHandler(new XMLAccessStrategy("./Test-file.xml"));
            xmlAccessHandler.Execute();
        }
    }
}