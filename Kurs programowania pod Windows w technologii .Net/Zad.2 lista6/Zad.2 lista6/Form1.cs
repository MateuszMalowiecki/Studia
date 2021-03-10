using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Zad._2_lista6 {
    public partial class Form1 : Form {
        ListView l;
        ListViewItem item1;
        ListViewItem item2;
        ListViewItem item3;
        ListViewItem item4;
        TreeView t;
        ToolBar p;
        private ArrayList customerArray = new ArrayList();
        private void toolBar1_ButtonClick(Object sender, ToolBarButtonClickEventArgs e)
        {
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            SaveFileDialog saveFileDialog1 = new SaveFileDialog();
            PrintDialog printDialog1 = new PrintDialog();
            switch (p.Buttons.IndexOf(e.Button))
            {
                case 0:
                    openFileDialog1.ShowDialog();
                    break;
                case 1:
                    saveFileDialog1.ShowDialog();
                    break;
                case 2:
                    printDialog1.ShowDialog();
                    break;
            }
        }
        public Form1() {
            item1 = new ListViewItem(new[] { "item1", "i1" });
            item2 = new ListViewItem(new[] { "item2", "i2" });
            item3 = new ListViewItem(new[] { "item3", "i3" });
            item4 = new ListViewItem(new[] { "item4", "i4" });
            l = new ListView();
            l.View = View.Details;
            //l.Columns.Clear();
            l.Columns.Add("Column1", -2, HorizontalAlignment.Left);
            l.Columns.Add("Column2", -2, HorizontalAlignment.Center);
            l.Bounds = new Rectangle(new Point(10, 320), new Size(170, 100));
            l.Items.Add(item1);
            l.Items.Add(item2);
            l.Items.Add(item3);
            l.Items.Add(item4);
            InitializeComponent();
            t = new TreeView();
            for (int i = 0; i < 10; i++) {
                t.Nodes.Add(new TreeNode(i.ToString()));
                for (int j = 0; j < 10; j++) {
                    t.Nodes[i].Nodes.Add(new TreeNode(j.ToString()));
                }
            }
            t.Bounds = new Rectangle(new Point(10, 200), new Size(170, 100));
            p = new ToolBar();
            p.Bounds = new Rectangle(new Point(10, 10), new Size(170, 100));
            ToolBarButton toolBarButton1 = new ToolBarButton();
            ToolBarButton toolBarButton2 = new ToolBarButton();
            ToolBarButton toolBarButton3 = new ToolBarButton();
            toolBarButton1.Text = "Open";
            toolBarButton2.Text = "Save";
            toolBarButton3.Text = "Print";
            p.Buttons.Add(toolBarButton1);
            p.Buttons.Add(toolBarButton2);
            p.Buttons.Add(toolBarButton3);
            p.ButtonClick += new ToolBarButtonClickEventHandler(this.toolBar1_ButtonClick);
            this.Controls.Add(l);
            this.Controls.Add(t);
            this.Controls.Add(p);
        }
        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
