package L1

import com.sun.javaws.exceptions.InvalidArgumentException

object List1 extends App {
  def scalarUgly(xs: List[Int], ys: List[Int]): Int = {
    if (xs.length != ys.length) {
      throw new InvalidArgumentException(Array("lists should have equal length"))
    }
    var sum = 0
    var iter = 0
    while (iter < xs.length) {
      sum += xs(iter) * ys(iter)
      iter += 1
    }
    sum
  }

  def scalar(xs: List[Int], ys: List[Int]): Int = {
    if (xs.length != ys.length) {
      throw new InvalidArgumentException(Array("lists should have equal length"))
    }
    //we get list of products of elements at each position and then we sum it
    val products = for {
      i <- 0 to xs.length - 1
    } yield xs(i) * ys(i)
    products.sum
  }

  //quicksort algorithm
  def sortUgly(xs: List[Int]): List[Int] = {
    if (xs.isEmpty || xs.tail.isEmpty)
      xs
    else {
      var iter = 1
      val pivot = xs.head
      var lessThanPivot: List[Int] = List()
      var moreThanPivot: List[Int] = List()
      while (iter < xs.length) {
        if (pivot >= xs(iter)) lessThanPivot = (xs(iter) :: lessThanPivot)
        else moreThanPivot = (xs(iter) :: moreThanPivot)
        iter += 1
      }
      sortUgly(lessThanPivot) ::: List(pivot) ::: sortUgly(moreThanPivot)
    }
  }

  def sort(xs: List[Int]): List[Int] = {
    if (xs.isEmpty || xs.tail.isEmpty)
      xs
    else {
      val pivot = xs.head
      val lessThanPivot: List[Int] =
        for {x <- xs.tail; if x <= pivot} yield x
      val moreThanPivot: List[Int] =
        for {x <- xs.tail; if x > pivot} yield x
      sort(lessThanPivot) ::: List(pivot) ::: sort(moreThanPivot)
    }
  }

  //checks if n is prime
  def isPrimeUgly(n: Int): Boolean = {
    if (n < 0) isPrimeUgly(n * -1)
    else if (n == 0 || n == 1) false
    else {
      var res = true
      var num = 2
      while (num * num <= n) {
        if (n % num == 0) res = false
        num += 1
      }
      res
    }
  }

  def isPrime(n: Int): Boolean =
    if (n < 0) isPrime(n * -1)
    else if (n == 0 || n == 1) false
    else {
      //we get the list of all the values bigger than 1, smaller than n and dividing n
      val res = for {num <- 2 to n - 1; if n % num == 0} yield num
      //and then n is prime iff res is empty
      res.isEmpty
    }


  //for given positive integer n, find all pairs of integers i and j,where 1 ≤ j < i < n such that i + j is prime
  def primePairsUgly(n: Int): List[(Int, Int)] = {
    var i = 2
    var res: List[(Int, Int)] = List()
    do {
      var j = 1
      do {
        if (isPrimeUgly(i + j))
          res = (i, j) :: res
        j += 1
      } while (j < i)
      i += 1
    } while (i < n)
    res
  }

  def primePairs(n: Int): List[(Int, Int)] = {
    val res = for (i <- 2 to n - 1; j <- 1 to i - 1; if (isPrime(i + j))) yield (i, j)
    res.toList
  }

  val filesHere = new java.io.File(".").listFiles
  val aaa = filesHere.tail.head

  def fileLinesUgly(file: java.io.File): List[String] = {
    val sourceFile = scala.io.Source.fromFile(file)
    val lines = sourceFile.getLines()
    var res: List[String] = List()
    while (lines.hasNext) {
      res = (lines.next() :: res)
    }
    sourceFile.close
    res
  }


  def fileLines(file: java.io.File): List[String] = {
    val sourceFile = scala.io.Source.fromFile(file)
    val lines = sourceFile.getLines().toList
    sourceFile.close
    lines
  }

  //print names of all .scala files which are in filesHere & are non empty
  def printNonEmptyUgly(pattern: String): Unit = {
    var iter = 0
    while (iter < filesHere.length) {
      val file = filesHere(iter)
      if (file.getName.contains(pattern) && fileLines(file).length > 0) {
        println(file.getName)
      }
      iter += 1
    }
  }

  def printNonEmpty(pattern: String): Unit = {
    for {file <- filesHere; if file.getName.contains(pattern) && fileLines(file).length > 0} {
      println(file.getName)
    }
  }
}
