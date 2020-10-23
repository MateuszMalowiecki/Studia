package L2

import Figures._
import numbers.Rational

object Test extends App {
  val r1 = Rational(42)
  val r2 = Rational(50, 6)
  val one = Rational.one
  val zero = Rational.zero
  println(s"SUM: ${r1 + r2}, difference: ${r1 - r2}, product: ${r1 * r2}, quotient: ${r1 / r2}")
  try {
    val bad_rational = Rational(42, 0)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }
  val point1 = Point(r1, r2)
  val point2 = Point(one, r2)
  val point3 = Point(one, zero)
  val point4 = Point(r1, zero)
  val point5 = Point(zero, r2)
  val point6 = Point(zero, one)
  val point7 = Point(one, one)
  val triangle1 = Triangle(point1, point2, point3)
  println(triangle1.description)
  println(triangle1.area)
  val triangle2=Triangle(point1, point5)
  println(triangle2.description)
  println(triangle2.area)
  try {
    val bad_triangle1 = Triangle(point1, point2, point5)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }
  try {
    val bad_triangle2 = Triangle(point1, point2, point2)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }
  val rectangle1 = Rectangle(point1, point2, point3, point4)
  println(rectangle1.description)
  println(rectangle1.area)
  val rectangle2=Rectangle(point4, point1, point5)
  println(rectangle2.description)
  println(rectangle2.area)
  try {
    val bad_rectangle1 = Rectangle(point1, point5, point3, point4)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }
  try {
    val bad_rectangle2 = Rectangle(point1, point2, point2, point4)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }
  val square1=Square(point6, point7, point3)
  println(square1.description)
  println(square1.area)
  try {
    val bad_square1 = Square(point1, point2, point3, point4)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }
  try {
    val bad_square2 = Square(point1, point2, point2, point4)
  }
  catch {
    case ex: Throwable => println(ex.getMessage)
  }

}