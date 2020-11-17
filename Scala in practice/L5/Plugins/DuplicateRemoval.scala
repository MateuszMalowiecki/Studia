package L5.Plugins

trait DuplicateRemoval extends Pluginable{
  override def plugin(s: String): String = {
    def removeDuplicates(s: String):String = {
      if (s.isEmpty) s
      else if (s.count(_ == s.head) > 1) removeDuplicates(s.replace(s.head.toString, ""))
      else s.head + removeDuplicates(s.tail)
    }
    super.plugin(removeDuplicates(s))
  }
}
