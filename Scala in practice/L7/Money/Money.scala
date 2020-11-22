package L7.Money

case class Money(amount : BigDecimal, currency: Currency)(implicit currencyConverter: CurrencyConverter) {
  implicit class CurrVal(val v: BigDecimal) {
    def apply(currency: Currency)(implicit currencyConverter: CurrencyConverter): Money = Money(v, currency)
  }

    def +(second:Money):Money = {
      val secConvVal:BigDecimal=second.amount * currencyConverter.convert(second.currency, this.currency)
      (this.amount + secConvVal)(this.currency)
    }
    def -(second:Money):Money = {
        val secConvVal:BigDecimal=second.amount * currencyConverter.convert(second.currency, this.currency)
        (this.amount - secConvVal)(this.currency)
    }
    def *(second:BigDecimal):Money = {
        (this.amount * second) (this.currency)
    }
    def as(otherCurrency: Currency):Money = {
      val amountInOtherCurrency= amount * currencyConverter.convert(this.currency, otherCurrency)
      amountInOtherCurrency(otherCurrency)
    }
    def >(second:Money):Boolean = {
        val secConvVal:BigDecimal=second.amount * currencyConverter.convert(second.currency, this.currency)
        this.amount > secConvVal
    }
    def <(second:Money):Boolean = {
        val secConvVal:BigDecimal=second.amount * currencyConverter.convert(second.currency, this.currency)
        this.amount < secConvVal
    }
}
