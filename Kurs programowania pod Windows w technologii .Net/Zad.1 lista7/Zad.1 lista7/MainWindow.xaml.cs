using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Zad._1_lista7
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
           
        }
       

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            string res = t1.Text + "\n" + t2.Text + "\nStudia " + c.Text +"\n";
            if (c1.IsChecked == true) res += "dzienne";
            else if (c2.IsChecked == true) res += "uzupełniające";
            MessageBox.Show(res, "Uczelnia");
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ComboBox_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
        {

        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void CheckBox_Checked(object sender, RoutedEventArgs e)
        {

        }
    }
}
