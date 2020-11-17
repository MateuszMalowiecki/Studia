package L5.Plugins

trait LowerCasing extends Pluginable {
  override def plugin(s: String): String =  super.plugin(s.toLowerCase)
}
