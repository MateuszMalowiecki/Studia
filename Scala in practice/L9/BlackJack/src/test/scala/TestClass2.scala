import Games.BlackJack
import cards._
import deck._
import org.scalatest.funsuite.AnyFunSuite;
class TestClass2 extends AnyFunSuite {
  test("pointsFromCard function should work in both variants") {
    val deck = Deck()
    val bj = BlackJack(deck, 1)
    assert(bj.pointsFromCard(Card(Diamonds, Numerical(6))) == 6)
    assert(bj.pointsFromCard(Card(Diamonds, Ace)) == 1)
    assert(bj.pointsFromCard(Card(Diamonds, King)) == 10)
    val anotherBj = BlackJack(1)
    assert(anotherBj.pointsFromCard(Card(Diamonds, Numerical(6))) == 6)
    assert(anotherBj.pointsFromCard(Card(Spades, Ace)) == 11)
    assert(anotherBj.pointsFromCard(Card(Clubs, King)) == 10)
  }
  test("pointsFromList function should work in both variants") {
    val deck = Deck()
    val bj = BlackJack(deck, 1)
    assert(bj.pointsFromList(List(Card(Diamonds, Numerical(6)), Card(Spades, Ace), Card(Clubs, King))) == 17)
    assert(bj.pointsFromList(List(Card(Diamonds, Ace), Card(Spades, Ace), Card(Clubs, Jack))) == 12)
    assert(bj.pointsFromList(List(Card(Hearts, Numerical(7)), Card(Clubs, Numerical(4)), Card(Diamonds, Ace))) == 12)
    val anotherBj = BlackJack(1)
    assert(anotherBj.pointsFromList(List(Card(Diamonds, Numerical(6)), Card(Spades, Ace), Card(Clubs, King))) == 27)
    assert(anotherBj.pointsFromList(List(Card(Diamonds, Ace), Card(Spades, Ace), Card(Clubs, Jack))) == 32)
    assert(anotherBj.pointsFromList(List(Card(Hearts, Numerical(7)), Card(Clubs, Numerical(4)), Card(Diamonds, Ace))) == 22)

  }
  test("first element of all21 function should have sum of 21 in both variants") {
    val deck = Deck()
    val bj = BlackJack(deck, 1)
    assert(bj.all21.head.map(bj.pointsFromCard(_)).sum == 21)
    val anotherBj = BlackJack(1)
    assert(anotherBj.all21.head.map(anotherBj.pointsFromCard(_)).sum == 21)
  }
}
