package numbers

import scala.math.sqrt

class Rational(n: Int, d: Int) {
  require(d != 0, "Denominator shouldn't be equal to zero.")

  private def gcd (a : Int, b : Int ): Int = if (b > a) gcd(b, a) else if (b == 0) a else gcd (b , a % b )
  private val g = gcd(n.abs, d.abs)

  val numerator = n / g
  val denominator = d / g

  def +(other: Rational): Rational = new Rational(numerator * other.denominator + denominator * other.numerator,
    denominator * other.denominator) // addition

  def -(other: Rational): Rational =  new Rational(numerator * other.denominator - denominator * other.numerator,
    denominator * other.denominator) // subtraction

  def *(other: Rational): Rational =  new Rational(numerator * other.numerator, denominator * other.denominator) // multiplication

  def /(other: Rational): Rational = new Rational(numerator * other.denominator, denominator * other.numerator) // division

  //sqrt method
  def ratSqrt : Double = sqrt(numerator.toDouble) / sqrt(denominator.toDouble)

  //equality method
  def isEqualTo(other : Rational) = numerator == other.numerator && denominator == other.denominator

  override def toString: String = {
    val divideResult = numerator / denominator
    val reminder = numerator % denominator
    if (reminder > 0) s"$divideResult $reminder/$denominator"
    else if (reminder < 0) s"$divideResult ${reminder.abs}/$denominator"
    else divideResult.toString
  }
}
object Rational {
  val zero: Rational = Rational(0)
  val one: Rational = Rational(1)
  def apply(n:Int, d:Int = 1) = new Rational(n, d)
}