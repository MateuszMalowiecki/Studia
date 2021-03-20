using System;
using POO_L3_Z3_Before;
using POO_L3_Z3_After;

namespace POO_L3_Z3_Test {
    public class Test {
        public static void Main() {
            Console.WriteLine("Przed: ");
            var items_before=new Item[] {
                new Item {
                    Price=45.31m,
                    Name="foo"
                },
                new Item {
                    Price=42.12m,
                    Name="bar"
                },
                new Item {
                    Price=12.42m,
                    Name="qux"
                }
            };
            CashRegister register_before=new CashRegister();
            Console.WriteLine(register_before.PrintBill(items_before));
            Console.WriteLine(register_before.CalculatePrice(items_before));
            Console.WriteLine("Po: ");
            var items_after=new Item_with_category[] {
                new Item_with_category {
                    Price=45.31m,
                    Name="foo",
                    Category="s"
                },
                new Item_with_category {
                    Price=42.12m,
                    Name="bar",
                    Category="t"
                },
                new Item_with_category {
                    Price=12.42m,
                    Name="qux",
                    Category="c"
                },
            };
            
            CashRegisterAfter register_after1=new CashRegisterAfter(new TaxCalculator1());
            CashRegisterAfter register_after2=new CashRegisterAfter(new TaxCalculator2());
            
            Console.WriteLine("Pierwszy kalkulator: ");
            Console.WriteLine(register_after1.CalculatePrice(items_after));
            Console.WriteLine(register_after1.PrintBill(items_after, new Category_sort()));

            Console.WriteLine("Drugi kalkulator: ");
            Console.WriteLine(register_after2.CalculatePrice(items_after));
            Console.WriteLine(register_after2.PrintBill(items_after, new Alphabet_sort()));
        }
    }
}