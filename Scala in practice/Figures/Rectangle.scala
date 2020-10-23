package Figures

import numbers.Rational

class Rectangle(a : Point, b : Point, c : Point, d: Point) extends Shape {
  //given points should be different
  require(!a.isEqualTo(b) && !a.isEqualTo(d) && !a.isEqualTo(c) && !b.isEqualTo(d) && !b.isEqualTo(c) && !c.isEqualTo(d), "given points should be different")

  //in rectangle opposite sides should have equal length
  require( a.distance(b) == d.distance(c) && a.distance(d) == b.distance(c), "given points create quadrilateral, but don't create rectangle or square")

  def this(a: Point, b:Point, c:Point) = this(a, b, c, new Point(Rational.zero, Rational.zero))

  override def area: Double = {
    val width = a.distance(d)
    val height = a.distance(b)
    height * width
  }
  override val description: String = "Rectangle"
}

object Rectangle {
  def apply(a: Point, b: Point, c: Point, d: Point): Rectangle = new Rectangle(a, b, c, d)
  def apply(a: Point, b: Point, c: Point): Rectangle = new Rectangle(a, b, c)
}