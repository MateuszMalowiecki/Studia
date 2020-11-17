package L5.Plugins

trait Doubling extends Pluginable{
  override def plugin(s: String): String = {
    def double(s:String, index:Int):String = {
      if (s.isEmpty) s
      else {
        val doubledTail = double(s.tail, index + 1)
        if (index % 2 == 0) s.head + (s.head + doubledTail)
        else s.head + doubledTail
      }
    }
    super.plugin(double(s, 1))
  }
}
