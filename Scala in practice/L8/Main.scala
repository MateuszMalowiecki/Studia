package L8

import L8.Adapter.FacebookAdapter

object Main extends App{
  val s=FacebookAdapter
  s.compareLikes("Logs.txt", "100010360056201", "100010360056201")
}
