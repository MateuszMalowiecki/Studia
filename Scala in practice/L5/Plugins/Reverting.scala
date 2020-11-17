package L5.Plugins

//reverts text
trait Reverting extends Pluginable {
   override def plugin(s: String): String =  super.plugin(s.reverse)
}
