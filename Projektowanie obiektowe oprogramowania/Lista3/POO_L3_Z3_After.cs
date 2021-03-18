using System;

namespace POO_L3_Z3_After {
    public interface ITaxCalc {
        Decimal CalculateTax( Decimal Price );   
    }
    public interface IItem {
        Decimal Price { get; }
        string Name { get; }
    }
    public interface IItemSort<I> where I : IItem {
        I[] SortItems(I[] items);
    }
    public class CashRegisterAfter {
        public ITaxCalc taxCalc;
        public CashRegisterAfter(ITaxCalc taxCalc) {
            this.taxCalc=taxCalc;
        }
        public Decimal CalculatePrice( IItem[] Items ) {
            Decimal _price = 0;
            foreach ( IItem item in Items ) {
                _price += item.Price + taxCalc.CalculateTax( item.Price );
            }
            return _price;
        }
        public string PrintBill<I>( I[] Items, IItemSort<I> sorter) where I:IItem {
            foreach ( var item in sorter.SortItems(Items) ) {
                Console.WriteLine( "towar {0} : cena {1} + podatek {2}", item.Name, item.Price, taxCalc.CalculateTax( item.Price ) );
            }
        }
    }
    public class TaxCalculator1: ITaxCalc {
        public Decimal CalculateTax( Decimal Price ){
            return Price * 0.22;
        }
    }
    public class TaxCalculator2: ITaxCalc {
        public Decimal CalculateTax( Decimal Price ){
            return Price * 0.15;
        }
    }
    public class TaxCalculator3: ITaxCalc {
        public Decimal CalculateTax( Decimal Price ){
            return Price * 0.31;
        }
    }
    public class Item_with_category : IItem {
        public Decimal Price {get; set;}
        public string Name { get; set; }
        public string Category {get; set;}
    }
    public class Alphabet_sort : IItemSort<Item_with_category> {
        Item_with_category[] SortItems(Item_with_category[] items){
            Array.Sort(items, delegate(Item_with_category i1, Item_with_category i2) {
                return i1.Name.CompareTo(i2.Name);
            });
        }
    }
    public class Category_sort : IItemSort<Item_with_category> {
        Item_with_category[] SortItems(Item_with_category[] items){
            Array.Sort(items, delegate(Item_with_category i1, Item_with_category i2) {
                return i1.Category.CompareTo(i2.Category)
            });
        }
    }
}