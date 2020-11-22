package L7.Money

case class CurrencyConverter(conversion: Map[(Currency, Currency), BigDecimal]) {
  def convert(from:Currency, to:Currency):BigDecimal = conversion.getOrElse((from, to), 1)
}
