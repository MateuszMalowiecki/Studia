package Figures
import numbers.Rational

import scala.math.sqrt;
class Triangle(a:Point, b:Point, c:Point) extends Shape {
  //given points should be different
  require(!a.isEqualTo(b) && !b.isEqualTo(c) && !c.isEqualTo(a), "given points should be different")

  //given points shouldn't be collinear
  private def areNotCollinear:Boolean = {
    val slopeab=a.slopeOfTheLineBeetweenPoints(b)
    val slopeac=a.slopeOfTheLineBeetweenPoints(c)
    slopeab.isEmpty != slopeac.isEmpty || (!slopeab.isEmpty && !slopeac.isEmpty && !slopeab.get.isEqualTo(slopeac.get))
  }
  require(areNotCollinear, "given points shouldn't be collinear")

  def this(a: Point, b:Point) = this(a, b, new Point(Rational.zero, Rational.zero))

  override def area: Double = {
    //lengths of sides
    val ab_side = a.distance(b)
    val bc_side = b.distance(c)
    val ac_side = c.distance(a)

    val half_circuit = (ab_side + ac_side + bc_side) / 2

    //Heron's formula
    sqrt(half_circuit * (half_circuit - ab_side) * (half_circuit - bc_side) * (half_circuit - ac_side))
  }

  override val description: String = "Triangle"
}
object Triangle {
  def apply(a: Point, b: Point, c: Point): Triangle = new Triangle(a, b, c)
  def apply(a: Point, b: Point): Triangle = new Triangle(a, b)
}
