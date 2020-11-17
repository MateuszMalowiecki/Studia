package L6.Pizzeria

case class Pizza(pizzaType: PizzaType, size:Size, crust:Crust, extraMeat:Option[Meat], extraTopping:Option[Topping]) {
  override def toString: String = s"Pizza type: ${pizzaType.name}, size: ${size.sizeType}, crust: ${crust.crustType}, extraMeat: ${extraMeat.map(_.name).getOrElse("no")}, extra Topping: ${extraTopping.map(_.name).getOrElse("no")}"
  val price:Double = {
    size.sizeMultiplier*(pizzaType.price + extraMeat.map(_.price).getOrElse(0.0) + extraTopping.map(_.price).getOrElse(0.0))
  }
}
case class PizzaType(name:String) {
  require(List("Margarita", "Pepperoni", "Funghi").contains(name))
  val price:Double = name match {
    case "Margarita" => 5
    case "Pepperoni" => 6.5
    case "Funghi" => 7
  }
}
case class Size(sizeType:String) {
  require(List("small", "regular", "large").contains(sizeType))
  val sizeMultiplier:Double  = {
    //toLowerCase for convenience
    sizeType match {
      case "small" => 0.9
      case "regular" => 1
      case "large" => 1.5
    }
  }
}
case class Crust(crustType:String) {
  require(List("thin", "thick").contains(crustType))
}
case class Topping(name:String) {
  require(List("ketchup", "garlic").contains(name))
  val price:Double = 0.5
}
case class Meat(name:String) {
  require(name == "salami")
  val price:Double = 1.0
}
case class Drink(name:String) {
  require(List("lemonade").contains(name))
  val price:Double = 2
}
case class Discount(discountType : String) {
  require(List("student", "senior").contains(discountType))
  val pizzaDiscountValue:Double = discountType match {
    case "student" => 0.95
    case "senior" => 0.93
  }
  val drinkDiscountValue:Double = discountType match {
    case "student" => 1.0
    case "senior" => 0.93
  }
}