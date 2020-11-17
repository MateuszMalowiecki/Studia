package L5.Plugins
import scala.util.matching.Regex

trait SingleSpacing extends Pluginable{
  override def plugin(s: String): String = {
    val pattern = new Regex(" +")
    super.plugin(pattern.replaceAllIn(s, " "))
  }
}
