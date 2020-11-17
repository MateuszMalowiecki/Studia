package L6

import L6.Pizzeria._
import L6.Orders._

object Test extends App{
    val pizza1= Pizza(PizzaType("Margarita"), Size("regular"), Crust("thin"), None, Some(Topping("ketchup")))
    val pizza2= Pizza(PizzaType("Pepperoni"), Size("large"), Crust("thick"), Some(Meat("salami")), Some(Topping("garlic")))
    val pizza3= Pizza(PizzaType("Funghi"), Size("small"), Crust("thin"), Some(Meat("salami")), None)
    println(pizza1)
    println(pizza1.price)
    println(pizza2)
    println(pizza2.price)
    println(pizza3)
    println(pizza3.price)
    val order1=Order("Adrian", "ul.Fryderyka Joliot-Curie 15", "123456789",List(pizza1, pizza2), List(Drink("lemonade")), Some(Discount("student")), None)
    val order2=Order("Matthew", "plac Uniwersytecki 1", "987654321",List(pizza2, pizza3), List(Drink("lemonade"), Drink("lemonade")), Some(Discount("senior")), Some("Ring doesn't work, please knock"))
    val order3=Order("Michael", "plac Nankiera 2/3", "781352469", List(pizza1), List(), None, None)
    println(order1)
    println(order1.extraMeatPrice)
    println(order1.pizzasPrice)
    println(order1.drinksPrice)
    println(order1.priceByType(PizzaType("Pepperoni")))
    println(order1.price)
    println(order2)
    println(order2.extraMeatPrice)
    println(order2.pizzasPrice)
    println(order2.drinksPrice)
    println(order2.priceByType(PizzaType("Funghi")))
    println(order2.price)
    println(order3)
    println(order3.extraMeatPrice)
    println(order3.pizzasPrice)
    println(order3.drinksPrice)
    println(order3.priceByType(PizzaType("Margarita")))
    println(order3.price)
}
