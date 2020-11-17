package L5.Plugins

trait NoSpacing extends Pluginable{
  override def plugin(s: String): String =  super.plugin(s.replace(" ", ""))
}
