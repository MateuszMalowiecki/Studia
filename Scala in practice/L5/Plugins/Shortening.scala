package L5.Plugins

trait Shortening extends Pluginable{
  override def plugin(s: String): String = {
    def shorten(s: String, index: Int): String = {
      if (s.isEmpty) s
      else {
        val shortenedTail = shorten(s.tail, index + 1)
        if (index % 2 == 0) shortenedTail
        else s.head + shortenedTail
      }
    }
    super.plugin(shorten(s, 1))
  }
}
