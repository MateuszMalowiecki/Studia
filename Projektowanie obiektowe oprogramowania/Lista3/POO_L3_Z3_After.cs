using System;

namespace POO_L3_Z3_After {
    public interface ITaxCalc
    {
        public Decimal CalculateTax( Decimal Price );   
    }
    public class TaxCalculator: ITaxCalc {
        public Decimal CalculateTax( Decimal Price ){
            return Price * 0.22;
        }
    }
    public interface IItem {
        Decimal Price { get {  } }
        string Name { get {  } }
    }
    public interface IItemSorter:IEnumerable<> {
       
    }
    public class CashRegister {
        public TaxCalculator taxCalc = new TaxCalculator();
        public Decimal CalculatePrice( Item[] Items ) {
            Decimal _price = 0;
            foreach ( Item item in Items ) {
                _price += itemPrice + taxCalc.CalculateTax( item.Price );
            }
            return _price;
        }
        public string PrintBill( Item[] Items ) {
            foreach ( var item in Items ) {
                Console.WriteLine( "towar {0} : cena {1} + podatek {2}", item.Name, item.Price, taxCalc.CalculateTax( item.Price ) );
            }
        }
    }
}