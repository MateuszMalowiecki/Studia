package L7.Money

object Main extends App{
   implicit class CurrVal(val v: Double) {
      def apply(currency: Currency)(implicit currencyConverter: CurrencyConverter): Money = Money(v, currency)(currencyConverter)
   }
   val conversion:Map[(Currency, Currency), BigDecimal] = Map(((USD, PLN), 3.87), ((PLN, USD), 0.26), ((PLN, EUR), 0.22), ((EUR, PLN), 4.47), ((EUR, USD), 1.18), ((USD, EUR), 0.84))
   implicit val currConv: CurrencyConverter = CurrencyConverter(conversion)
   val sum1: Money = 100.01 (USD) + 200 (EUR)
   println(sum1)
   val sum2: Money = 100.01 (PLN) + 200 (USD)
   println(sum2)
   val sum3: Money = 5 (PLN) + 3 (PLN) + 20.5 (USD)
   println(sum3)
   val sub: Money = 300.01(USD) - 200 (EUR)
   println(sub)
   val mult1: Money = 30 (PLN) * 20
   println(mult1)
   val mult2: Money = 20 (USD) * 11
   println(mult2)
   val conv1: Money = 150.01 (USD) as PLN
   println(conv1)
   val conv2: Money = 120.01 (USD) as EUR
   println(conv2)
   val compare1: Boolean = 300.30 (USD) > 200 (EUR)
   println(compare1)
}
