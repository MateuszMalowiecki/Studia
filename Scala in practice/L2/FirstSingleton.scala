package L2

import Figures.Shape

object FirstSingleton {
  def areaSum(figures: List[Shape]): Double = figures.map(_.area).sum //Sum all areas
  def printAll(figures: List[Shape]): Unit = figures.foreach(_.description) //Print all descriptions
}
