package deck

import cards._

import scala.math.max
import scala.util.Random.shuffle

case class Deck(cards: List[Card]) {
  val fullDeckLen:Int=52
  //creates new deck without first card
  def pull():Deck = {
    if(cards.isEmpty) this
    else Deck(cards.tail)
  }

  //creates new deck with given card pushed on top
  def push(c: Card):Deck = Deck(c::cards)

  //creates new deck with new card(color, value) pushed on top
  def push(color:Color, value: Value):Deck =  Deck(Card(color, value)::cards)

  // checks if deck is a standard deck
  val isStandard: Boolean = {
    val standardDeck=for{
      value <- Deck.fullDeckValues
      color <- Deck.fullDeckcolors
    } yield Card(color, value)
    cards.length == fullDeckLen  && standardDeck.forall(x => cards.contains(x))
  }
  //amount of duplicates of the given card in the deck
  def duplicatesOfCard(card: Card):Int = max(cards.filter(_ == card).length - 1, 0)
  //amount of cards in the deck for the given color
  def amountOfColor(color: Color): Int = cards.filter(_.color == color).length

  //amount of cards in the deck for given numerical card(2, 3, 4, 5, 6, 7, 8, 9, 10)
  def amountOfNumerical(numerical: Numerical): Int = cards.filter(_.value == numerical).length

  //amount of all numerical cards in the deck(2, 3, 4, 5, 6, 7, 8, 9, 10)
  val amountWithNumerical: Int =  {
    val numerics=(for (i <- 2 to 10) yield Numerical(i)).toList
    cards.filter(x => numerics.contains(x.value)).length
  }

  //amount of cards in the deck for the given face(Jack, Queen & King)
  def amountOfFace(face: Face): Int = cards.filter(_.value == face).length

  //amount of all cards in the deck with faces (Jack, Queen & King)
  val amountWithFace: Int = {
    val faces=List(Jack, Queen, King)
    cards.filter(x => faces.contains(x.value)).length
  }
}
object Deck {
  val fullDeckValues:List[Value]=(for (i <- 2 to 10) yield Numerical(i)).toList ::: List(Ace, Jack, Queen, King)
  val fullDeckcolors:List[Color]= List(Clubs, Diamonds, Hearts, Spades)
  //creates the standard deck with random order of cards. Check Random.shuffle1 function
  def apply():Deck = {
    val standardDeck=for{
      value <- fullDeckValues
      color <- fullDeckcolors
    } yield Card(color, value)
    Deck(shuffle(standardDeck))
  }
}