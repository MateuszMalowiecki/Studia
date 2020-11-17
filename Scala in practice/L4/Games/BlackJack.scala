package L4.Games

import L4.Cards._
import L4.Deck.Deck

import scala.util.Random.shuffle

case class BlackJack(deck: Deck, aceValue: Int=11) {
  // Points calculation:
  //1. Numerical cards as their numerical value = 2 - 10.
  //2. Face cards (Jack, Queen, King) = 10
  //3. Ace = 1 or 11 (player could choose)
  require(aceValue == 1 || aceValue == 11, "Value of ace should be either 1 or 11")

  private def pointsFromCard(card:Card) ={
    card.value match {
      case Ace => aceValue
      case _:Face => 10
      case Numerical(i) => i
    }
  }

  // loop taking n cards from the deck, pretty-printing them with points & printing the sum of points on the end
  def play(n: Int): Unit = {
    def printAndAddToSum(part_sum:Int, card: Card): Int = {
      val card_val=pointsFromCard(card)
      println(s"$card gives $card_val points")
      part_sum + card_val
    }
    val n_cards=deck.cards.take(n)
    val sum=n_cards.foldLeft(0)((part_sum, card) => printAndAddToSum(part_sum, card))
    println(sum)
  }
  // finds all subsequences of cards which could give 21 points
  lazy val all21: List[List[Card]] = {
     def pointsFromList(xs : List[Card]):Int = xs.foldLeft(0)((part_sum, card) => part_sum + pointsFromCard(card))

     def subsequences(list: List[Card]):List[List[Card]] = {
       list match {
        case Nil => List(List.empty)
        case head :: tail => {
           val tailSubseq=subsequences(tail)
           val allsubSeq=tailSubseq.map(xs => head::xs) ++ tailSubseq
          allsubSeq.filter(xs => pointsFromList(xs) <= 21)
         }
       }
     }

     subsequences(deck.cards).filter(p => pointsFromList(p) == 21)
  }
  // finds and pretty-prints the first subsequence of cards which could give 21 points
  def first21(): Unit = {
    if(all21.isEmpty) ()
    else{
      val first=all21.head
      first.foreach(c => println(s"$c gives ${pointsFromCard(c)} points"))
    }
  }
}
object BlackJack {
  // creates Blackjack game having numOfDecks-amount of standard decs with random order of cards. For example, with Blackjack(3) deck would have 156 cards
  def apply(numOfDecks: Int):BlackJack = {
    val standardDeck=for{
      value <- (for (i <- 2 to 10) yield Numerical(i)).toList ::: List(Ace, Jack, Queen, King);
      color <- List(Clubs, Diamonds, Hearts, Spades)
    } yield Card(color, value)

    val decks=for (i <- 1 to numOfDecks) yield shuffle(standardDeck)
    BlackJack(Deck(decks.toList.foldLeft(List() : List[Card])((someDecks, nextDeck) => someDecks ++ nextDeck)))
  }
}