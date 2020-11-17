package L4

import L4.Cards._
import L4.Deck.Deck
import L4.Games.BlackJack

object Test extends App{
  val fullDeck = Deck()
  println(fullDeck.isStandard)
  val fullDeckWithNewCard=fullDeck.push(Card(Diamonds, Numerical(10)))
  println(fullDeckWithNewCard.duplicatesOfCard(Card(Diamonds, Numerical(10))))
  val fullDeckAgain= fullDeckWithNewCard.pull()
  println(fullDeckAgain.isStandard)
  val fullDeckWithNewCardAgain=fullDeck.push(Spades, Jack)
  println(fullDeckWithNewCardAgain.duplicatesOfCard(Card(Spades, Jack)))
  val fullDeckAgainAgain=fullDeckWithNewCardAgain.pull()
  println(fullDeckAgainAgain.isStandard)
  println(fullDeck.amountOfColor(Hearts))
  println(fullDeck.amountOfNumerical(Numerical(7)))
  println(fullDeck.amountWithNumerical)
  println(fullDeck.amountOfFace(Jack))
  println(fullDeck.amountWithFace)
  val bj=BlackJack(fullDeck, 1)
  bj.play(10)
  println(bj.all21.length)
  bj.first21()
  println("-----")
  val anotherBj =BlackJack(1)
  anotherBj.play(10)
  println(anotherBj.all21.length)
  anotherBj.first21()
}
