package Figures

import numbers.Rational

class Square(a : Point, b : Point, c: Point, d : Point) extends Rectangle(a, b, c, d) {
  //points that form a rectangle, can form a square only if distances between neighboring points are the same
  require(a.distance(b) == a.distance(d), "given points create rectangle, but don't create square")
  override def area: Double = {
    val sidesize:Double = a.distance(d)
    sidesize * sidesize
  }
  def this(a: Point, b:Point, c:Point) = this(a, b, c, new Point(Rational.zero, Rational.zero))
  override val description: String = "Square"
}
object Square {
  def apply(a: Point, b: Point, c: Point, d: Point): Square = new Square(a, b, c, d)

  def apply(a: Point, b: Point, c: Point): Square = new Square(a, b, c)
}