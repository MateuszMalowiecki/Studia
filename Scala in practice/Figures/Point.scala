package Figures

import numbers.Rational
case class Point(x: Rational, y: Rational) {
    def distance(other : Point):Double = {
        val distanceCube=(other.x - x) * (other.x - x) + (other.y - y) * (other.y - y)
        distanceCube.ratSqrt
    }
    //equality method
    def isEqualTo(other: Point) = x.isEqualTo(other.x) && y.isEqualTo(other.y)

    //coefficient a of linear function beetween two points
    def slopeOfTheLineBeetweenPoints(other : Point):Option[Rational] = {
        //There aren't any linear function beetween two points with the same x value, so we return None
        if (x.isEqualTo(other.x)) None
        else Some((other.y - y) / (other.x - x))
    }
}
object Point {
    def apply(x: Rational, y: Rational): Point = new Point(x, y)

}
