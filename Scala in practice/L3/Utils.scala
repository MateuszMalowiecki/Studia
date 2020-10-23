package L3

object Utils extends App{

  //checks if as is sorted according to ordering
  def isSorted(as: List[Int], ordering: (Int, Int) => Boolean): Boolean = {
    if (as.length <= 1) true
    else ordering(as(0), as(1)) && isSorted(as.tail, ordering)
  }

  //checks if as is sorted in ascending order
  def isAscSorted(as: List[Int]):Boolean = isSorted(as, (x, y) => x <= y)

  //checks if as is sorted in descending order
  def isDescSorted(as: List[Int]):Boolean = isSorted(as, (x, y) => x >= y)

  //applies binary operator to a start value and all elements of l, going left to right. Dont use build-in List.foldLeft1
  def foldLeft[A, B](l: List[A], z: B)(f: (B, A) => B): B = {
    if (l.isEmpty) z
    else foldLeft(l.tail, f(z, l.head))(f)
  }

  //sum elements of l with usage of foldLeft function
  def sum(l: List[Int]):Int = foldLeft(l, 0)((x, y) => x+y)

  //length of l with usage of foldLeft function
  def length[A](l: List[A]) = foldLeft(l, 0)((z, _) => z+1)

  //compose two unary: functions:compose(f,g)(x) = f(g(x)). Don't use Funtion1.compose.
  def compose[A, B, C](f: A => B, g: B => C )(x: A):C = g(f(x))

  //takes unary function f with integer n & returns the n-th repeated application of the function. For example: repeated(f, 3) = f(f(f(3)))
  def repeated[A, B](f : A => A , n: Int) : A => A= {
    if (n<=0) x => x
    else compose(f, repeated(f, n-1))
  }

  //converts a binary function f of two arguments into a function of one argument that partially applies f. For example, when def add(a: Int, b: Int) = a + b,
  //than curry(add)(1)(1) == add(1, 1)
  def curry[A, B, C](f : (A, B) => C)(a : A)(b : B) : C = f(a, b)

  //reverse of curry function. For example, uncurry(f)(1, 1) == f(1)(1)
  def uncurry[A, B, C](f: A => B => C)(a : A, b : B): C = f(a)(b)

  //catch any exception, log the error & throw the ex exception instead
  def unSafe[T](ex: Exception)(block: => T) = {
    try {
      block
    }
    catch {
      case e:Exception => {
        println(e.getMessage)
        throw ex
      }
    }
  }
  def add(a: Int, b: Int) = a + b

  class MyException(s:String) extends Exception(s)

  //tests
  println(isAscSorted(List(1,2,3,4,5)))
  println(isAscSorted(List(5,4,3,2,1)))
  println(isDescSorted(List(1,2,3,4,5)))
  println(isDescSorted(List(5,4,3,2,1)))
  println(sum(List(1,2,3,4,5)))
  println(length(List(1,2,3,4,5)))
  println(repeated((a:Int) => 2*a, 6)(5))
  val curried: Int => Int => Int = curry(add)
  println(curried(1)(2))
  val uncurried: (Int, Int) => Int=uncurry(curried)
  println(uncurried(1, 2))
  unSafe(new MyException("You should not divide by zero")) {
    val x=42
    val y=0
    x / y + 200
  }

}