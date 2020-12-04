package cards

sealed abstract class Color

case object Clubs extends Color
case object Diamonds extends Color
case object Hearts extends Color
case object Spades extends Color

sealed abstract class Value

case class Numerical(numericalValue: Int) extends Value

case object Ace extends Value

sealed abstract class Face extends Value
case object Jack extends Face
case object Queen extends Face
case object King extends Face

case class Card(color: Color, value: Value)
