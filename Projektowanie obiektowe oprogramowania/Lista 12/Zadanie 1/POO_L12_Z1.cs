using System;
using System.Data.SqlClient;

namespace POO_L12_Z1 {
    public class Parent {
        public int id { get; }
        public Parent(int id) {
            this.id=id;
        }
    }
    public class Child {
        public int id { get; }
        public Parent parent { get; }
        public Child(int id, Parent parent) {
            this.parent=parent;
            this.id=id;
        }
    }
    public class ORM {
        public SqlConnection connection;
        public ORM() {
            connection=new SqlConnection();
            connection.Open();
        }
        public void InsertParent(Parent parent) {
            SqlCommand command=new SqlCommand("INSERT INTO PARENTS(id) VALUES(" + parent.id + ")", connection);
            command.ExecuteNonQuery();
        }
        public void InsertChild(Child child) {
            SqlCommand command=new SqlCommand("INSERT INTO CHILDREN(id, parent_id) VALUES(" + child.id + ", " + child.parent.id +")", connection);
            command.ExecuteNonQuery();
        }
        public Parent GetParentByID(int id) {
            SqlCommand command=new SqlCommand("SELECT * FROM PARENTS WHERE id=" + id, connection);
            SqlDataReader reader=command.ExecuteReader();
            Parent res=null;
            while(reader.Read()) {
                int foundID = (int)reader[0];
                if(foundID == id) {
                    res=new Parent(foundID);
                    break;
                }
            }
            return res;
        }
        public Child GetChildByID(int id) {
            SqlCommand command=new SqlCommand("SELECT * FROM CHILDREN WHERE id=" + id, connection);
            SqlDataReader reader=command.ExecuteReader();
            Child res=null;
            while(reader.Read()) {
                int foundID=(int)reader[0];
                if(foundID == id) {
                    res=new Child(foundID, new Parent((int)reader[1]));
                    break;
                }
            }
            return res;
        }
    }
    public class LocalFactory {
        private static Func<ORM> ORMProvider;
        public static void SetProvider(Func<ORM> ORMProv) {
            ORMProvider=ORMProv;
        }
        public ORM CreateORM() {
            if(ORMProvider != null) {
                return ORMProvider();
            }
            throw new ArgumentException();
        }
    }
    public class Test {
        public static void CompositionRoot() {
            LocalFactory.SetProvider(() => new ORM());
        }
        public static void Main() {
            CompositionRoot();
            LocalFactory factory=new LocalFactory();
            ORM orm=factory.CreateORM();
            Parent parent = new Parent(42);
            orm.InsertParent(parent);
            Child child=new Child(51, parent);
            orm.InsertChild(child);

            orm.GetParentByID(42);
            orm.GetChildByID(51);
        }
    }
}