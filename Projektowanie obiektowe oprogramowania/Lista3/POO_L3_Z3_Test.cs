using System;

namespace POO_L3_Z3_Test {
    public class Test {
        public static void Main() {
            Console.WriteLine("Przed: ");
            var items_before=new POO_L3_Z3_Before.Item[] {
                new POO_L3_Z3_Before.Item {
                    Price=45.31,
                    Name="foo"
                },
                new POO_L3_Z3_Before.Item {
                    Price=42.12,
                    Name="bar"
                },
                new POO_L3_Z3_Before.Item {
                    Price=12.42,
                    Name="qux"
                }
            };
            POO_L3_Z3_Before.CashRegister register_before=new POO_L3_Z3_Before.CashRegister();
            Console.WriteLine(register_before.PrintBill(items_before));
            Console.WriteLine(register_before.CalculatePrice(items_before));
            Console.WriteLine("Po: ");
            var items_after=new POO_L3_Z3_After.Item_with_category[] {
                new POO_L3_Z3_After.Item_with_category {
                    Price=45.31,
                    Name="foo"
                },
                new POO_L3_Z3_After.Item_with_category {
                    Price=42.12,
                    Name="bar"
                },
                new POO_L3_Z3_After.Item_with_category {
                    Price=12.42,
                    Name="qux"
                },
            };
            
            POO_L3_Z3_After.CashRegisterAfter register_after1=new POO_L3_Z3_After.CashRegister(new POO_L3_Z3_After.TaxCalculator1);
            POO_L3_Z3_After.CashRegisterAfter register_after2=new POO_L3_Z3_After.CashRegister(new POO_L3_Z3_After.TaxCalculator2);
            POO_L3_Z3_After.CashRegisterAfter register_after3=new POO_L3_Z3_After.CashRegister(new POO_L3_Z3_After.TaxCalculator3);
            
            Console.WriteLine("Pierwszy kalkulator: ");
            Console.WriteLine(register_after1.CalculatePrice(items_after));
            Console.WriteLine(register_after1.PrintBill(items_after));

            Console.WriteLine("Drugi kalkulator: ");
            Console.WriteLine(register_after2.CalculatePrice(items_after));
            Console.WriteLine(register_after2.PrintBill(items_after));
            
            Console.WriteLine("Trzeci kalkulator: ");
            Console.WriteLine(register_after3.CalculatePrice(items_after));
            Console.WriteLine(register_after3.PrintBill(items_after));
        }
    }
}--