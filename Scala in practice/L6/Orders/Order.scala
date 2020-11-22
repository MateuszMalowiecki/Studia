package L6.Orders

import L6.Pizzeria._

case class Order(name:String, address:String, phone:String, pizzas:List[Pizza], drinks:List[Drink], discount: Option[Discount], specialInfo: Option[String]) {
  require(phone.matches("[0-9]{9}"))
  override def toString: String = s"name: $name, address: $address, phone number: $phone, pizzas: ${pizzas.map(_.toString)}, drinks: ${drinks.map(_.name)}, discount: ${discount.fold("no")(_.discountType)}, specialInfo: ${specialInfo.getOrElse("no")}"
  private def checkIfZero(d:Double):Option[Double] = {
    d match {
      case 0.0 => None
      case _ => Some(d)
    }
  }
  def extraMeatPrice:Option[Double] = {
    checkIfZero(pizzas.map(_.extraMeat.fold(0.0)(_.price)).sum)
  }
  def pizzasPrice:Option[Double] = {
    checkIfZero(pizzas.map(_.price).sum)
  }
  def drinksPrice:Option[Double] = {
    checkIfZero(drinks.map(_.price).sum)
  }
  def priceByType(pizzaType: PizzaType):Option[Double] = {
    checkIfZero(pizzas.filter(_.pizzaType == pizzaType).map(_.price).sum)
  }
  val price:Double = {
    drinksPrice.getOrElse(0.0) * discount.fold(1.0)(_.drinkDiscountValue) + pizzasPrice.getOrElse(0.0) * discount.fold(1.0)(_.pizzaDiscountValue)
  }
}
