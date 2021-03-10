using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.Serialization;

namespace Zad._1_lista9 {
    //Zad.6
    class Client {
        public string Read(string filename) {
            XmlTextReader reader = new XmlTextReader(filename);
            string listBox1 ="";
            while (reader.Read()) {
                switch (reader.NodeType) {
                    case XmlNodeType.Element:
                        listBox1 += "<" + reader.Name + ">";
                        break;
                    case XmlNodeType.Text:
                        listBox1 += reader.Value;
                        break;
                    case XmlNodeType.EndElement:
                        listBox1 += "";
                        break;
                }
            }
            return listBox1;
        }
        public void Write(string filename, string text) {
            XmlTextWriter w = new XmlTextWriter(filename, null);
            w.WriteString(text);
            w.Close();
        }
    }
    //Zad.4
    class Client2 {
        XmlSerializer s;
        public void Write(object serializableObject, string fileName)
        {
            if (serializableObject == null) { return; }
            try {
                XmlDocument xmlDocument = new XmlDocument();
                XmlSerializer serializer = new XmlSerializer(serializableObject.GetType());
                MemoryStream stream = new MemoryStream();
                serializer.Serialize(stream, serializableObject);
                //stream.Position = 0;
                xmlDocument.Load(stream);
                xmlDocument.Save(fileName);
            }
            catch (Exception ex) {
                Console.WriteLine("Aplikacja wygenerowala nastepujacy wyjatek:" + ex.Message);
            }
        }
        public object Read(string fileName) {
            if (string.IsNullOrEmpty(fileName)) { return default(object); }
            var objectOut = default(object);
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(fileName);
            string xmlString = xmlDocument.OuterXml;
            StringReader read = new StringReader(xmlString);
            XmlSerializer serializer = new XmlSerializer(typeof(object));
            XmlReader reader = new XmlTextReader(read);
            try { 
                objectOut = serializer.Deserialize(reader);                
            }
            catch (Exception ex) {
                Console.WriteLine("Aplikacja wygenerowala nastepujacy wyjatek:" + ex.Message);
            }
            return objectOut;
        }
    }
    //Zad.5
    class Client3
    {
        private XmlDocument doc=new XmlDocument();
        public object Read(string filename) {
            doc.Load(filename);
            XmlNode n = doc.DocumentElement;
            return n.Value;
        }
        public void Write(string filename, object o) {
            doc.Load(filename);
            XmlAttribute a = doc.CreateAttribute("new elem");
            a.Value = o.ToString();
            doc.Attributes.Append(a);
            doc.Save(filename);
        }
    }
    class Program {
        static void booksSettingsValidationEventHandler(object sender, ValidationEventArgs e) {
            if (e.Severity == XmlSeverityType.Warning) {
                Console.Write("WARNING: ");
                Console.WriteLine(e.Message);
            }
            else if (e.Severity == XmlSeverityType.Error) {
                Console.Write("ERROR: ");
                Console.WriteLine(e.Message);
            }
        }
        static void Main(string[] args)
        {
            //Zad.3
            /*Console.WriteLine("Podaj nazwe pliku do walidacji");
            String filename = Console.ReadLine();
            try
            {
                XmlSchemaSet schemaSet = new XmlSchemaSet();
                schemaSet.Add("urn:bookstore-schema", "Studenci.xsd");
                XmlReaderSettings booksSettings = new XmlReaderSettings();
                booksSettings.Schemas.Add(schemaSet);
                booksSettings.ValidationType = ValidationType.Schema;
                booksSettings.ValidationEventHandler += new ValidationEventHandler(booksSettingsValidationEventHandler);
                XmlReader books = XmlReader.Create(filename, booksSettings);
                while (books.Read()) { }
                books.Close();
            }
            catch(Exception e) {
                Console.WriteLine("Wyjatek: " +  e.Message);
            }*/
            /*
            Client c1 = new Client();
            var r1 = c1.Read("Studenci.xml");
            //Console.WriteLine(r1);
            Client2 c2 = new Client2();
            var r2 = c2.Read("Studenci.xml");
            Console.WriteLine(r2);
            Client3 c3 = new Client3();
            var r3 = c3.Read("Studenci.xml");
            */


            XmlSerializer xs = new XmlSerializer(typeof(Database));

            Database d = new Database();
            d.Studenci = new List<Student>();
            d.Studenci.Add(new Student() { Imie = "Jan", Nazwisko = "Kowalski" });


            xs.Serialize(new StreamWriter("database.xml", false, Encoding.UTF8), d);
            //Console.WriteLine(r3);
            //Zad.7
            /*Console.WriteLine("Podaj litere na ktora maja zaczynac sie nazwiska studentow");
            char letter = Console.ReadLine()[0];
            XDocument xdoc = XDocument.Load("Studenci.xml");
            var c = from data in xdoc.Descendants("Student")
                    where data.Attribute("Surname").Value[0] == letter
                    select data.Descendants("Address");
            foreach (var data in c) {
                foreach (var d in data) {
                    Console.WriteLine(d.Attribute("City").Value);
                }
            }*/
            Console.Read();
        }
    }

    public class Database
    {
        public List<Student> Studenci { get; set; }
    }

    public class Student
    {
        [XmlAttribute]
        public string Nazwisko { get; set; }
        public string Imie { get; set; }
    }
}
