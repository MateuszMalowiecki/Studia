package L5.Plugins

trait Rotating extends Pluginable{
  override def plugin(s: String): String =  super.plugin(s.last + s.init)
}
