package L5

object Test extends App {

  val s = "A BB  CD"
  val sa = Action.actionA.plugin(s)
  println(sa)
  val sb = Action.actionB.plugin(s)
  println(sb)
  val sc = Action.actionC.plugin(s)
  println(sc)
  val sd = Action.actionD.plugin(s)
  println(sd)
  val se = Action.actionE.plugin(s)
  println(se)
  val sf = Action.actionF.plugin(s)
  println(sf)
  val sg = Action.actionG.plugin(s)
  println(sg)
}
