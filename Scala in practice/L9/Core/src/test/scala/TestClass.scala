import cards._
import deck._
import org.scalatest.funsuite.AnyFunSuite
class TestClass extends AnyFunSuite {
  test("Default deck is standard Deck") {
    val deck = Deck()
    assert(deck.isStandard)
  }
  test("Default deck with additional card should have duplicate of this card") {
    val deck = Deck()
    val fullDeckWithNewCard = deck.push(Card(Diamonds, Numerical(10)))

    assert(fullDeckWithNewCard.duplicatesOfCard(Card(Diamonds, Numerical(10))) == 1)
  }
  test("Default deck with card") {
    val deck = Deck()
    val fullDeckWithNewCard = deck.push(Card(Diamonds, Numerical(10)))
    val fullDeckAgain = fullDeckWithNewCard.pull()
    assert(fullDeckAgain.isStandard)
  }
  test("Adding card in different way should also work") {
    val deck = Deck()
    val fullDeckWithNewCard = deck.push(Diamonds, Numerical(10))

    assert(fullDeckWithNewCard.duplicatesOfCard(Card(Diamonds, Numerical(10))) == 1)
    val fullDeckAgain = fullDeckWithNewCard.pull()
    assert(fullDeckAgain.isStandard)
  }
  test("amountOfColor function should work") {
    val deck = Deck()
    assert(deck.amountOfColor(Hearts) == 13)
  }
  test("amountOfNumerical function should work") {
    val deck = Deck()
    assert(deck.amountOfNumerical(Numerical(7)) == 4)
  }
  test("amountWithNumerical function should work") {
    val deck = Deck()
    assert(deck.amountWithNumerical == 36)
  }
  test("amountOfFace function should work") {
    val deck = Deck()
    assert(deck.amountOfFace(Jack) == 4)
  }
  test("amountWithFace function should work") {
    val deck = Deck()
    assert(deck.amountWithFace == 12)
  }
}
