package L7.Money

trait Currency {
    val name:String
}

case object USD extends Currency {
  override val name: String = "USD"
}

case object EUR extends Currency {
  override val name: String = "EUR"
}
case object PLN extends Currency {
  override val name: String = "PLN"
}