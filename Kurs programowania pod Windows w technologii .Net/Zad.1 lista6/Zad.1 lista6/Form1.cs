using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Zad._1_lista6
{
    public partial class Form1 : Form
    {
        public GroupBox fst;
        public GroupBox snd;
        public TextBox fstt;
        public TextBox sndt;
        public ComboBox c;
        public CheckBox c1;
        public CheckBox c2;
        public Button b1;
        public Button b2;
        public Label l1;
        public Label l2;
        public Label l3;
        public Label l4;
        public Label l5;
        public Label l6;
        public Label l7;
        public Form1() {
            l1 = new Label();
            l2 = new Label();
            l3 = new Label();
            l4 = new Label();
            l5 = new Label();
            l6 = new Label();
            l7 = new Label();
            fst = new GroupBox();
            snd = new GroupBox();
            fstt = new TextBox();
            sndt = new TextBox();
            c = new ComboBox();
            c1 = new CheckBox();
            c2 = new CheckBox();
            b1 = new Button();
            b2 = new Button();
            l1.Text = "Nazwa:";
            l2.Text = "Adres:";
            l3.Text = "Cykl nauki:";
            l4.Text = "Dzienne";
            l5.Text = "Uzupelniajace";
            l6.Text = "Uczelnia";
            l7.Text = "Rodzaj studiow";
            l1.Size = new Size(40, 20);
            l2.Size = new Size(40, 20);
            l3.Size = new Size(80, 20);
            l4.Size = new Size(80, 20);
            l5.Size = new Size(100, 20);
            l6.Size = new Size(50, 20);
            l7.Size = new Size(80, 20);
            l1.Location = new Point(15, 20);
            l2.Location = new Point(15, 60);
            l3.Location = new Point(15, 150);
            l4.Location = new Point(40, 185);
            l5.Location = new Point(175, 185);
            l6.Location = new Point(5, 5);
            l7.Location = new Point(10, 120);
            b1.Text = "Akceptuj";
            b2.Text = "Anuluj";
            InitializeComponent();
            fst.Controls.Add(sndt);
            fst.Controls.Add(fstt);
            snd.Controls.Add(c);
            snd.Controls.Add(c1);
            snd.Controls.Add(c2);
            fstt.AutoSize = false;
            fstt.Size = new Size(320, 20);
            fstt.Text = "Uniwersytet Wroclawski";
            fstt.Location = new Point(50, 10);
            sndt.AutoSize = false;
            sndt.Size = new Size(320, 20);
            sndt.Text = "pl.Uniwersytecki 1, 50-137 Wroclaw";
            sndt.Location = new Point(50, 50);
            c.Text = "3-letnie";
            c.Items.Add("3-letnie");
            c.Items.Add("4-letnie");
            c.Items.Add("5-letnie");
            c.Size = new Size(300, 20);
            c.Left = 90;
            c.Top += 25;
            c1.Top += 60;
            c1.Left = 15;
            c2.Top += 60;
            c2.Left = 150;
            fst.Size = new Size(400, 100);
            fst.Location = new Point(10, 10);
            snd.Size = new Size(400, 100);
            snd.Location = new Point(10, 120);
            b1.Location = new Point(10, 250);
            b1.Click += new EventHandler(this.Button_click);
            b2.Location = new Point(300, 250);
            b2.Click += new EventHandler(this.Button_click2);
            //c1.Location = new Point(15, 400);
            //c2.Location = new Point(50, 400);
            this.Text = "Wybor uczelni";
            this.Size = new Size(450, 350);
            this.Controls.Add(l1);
            this.Controls.Add(l2);
            this.Controls.Add(l3);
            this.Controls.Add(l4);
            this.Controls.Add(l5);
            this.Controls.Add(l6);
            this.Controls.Add(l7);
            this.Controls.Add(fst);
            this.Controls.Add(snd);
            this.Controls.Add(b1);
            this.Controls.Add(b2);
        }
        void Button_click(object sender, EventArgs e) { 
            String res=fstt.Text +"\n";
            res += sndt.Text + "\n";
            res += "Studia " + c.Text + "\n";
            if (c1.Checked) res += "dzienne";
            else if (c2.Checked) res += "uzupelniajace";
            MessageBox.Show(res, "Uczelnia");
        }
        void Button_click2(object sender, EventArgs e)
        {
            this.Close();
        }
        private void Form1_Load(object sender, EventArgs e)
        {

        }
        /*[STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.Run(new Form1());
        }*/
    }
}