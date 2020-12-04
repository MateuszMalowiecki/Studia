package L8.Adapter

import java.io.{BufferedWriter, File, FileWriter}
import java.util.Calendar

import com.restfb.types.{Likes, User}
import com.restfb.{DefaultFacebookClient, Version}

import scala.concurrent.duration.Duration
import scala.concurrent.{Await, Future}
import scala.concurrent.ExecutionContext.Implicits.global

object FacebookAdapter {
  private val myAppSecret: String = "cba76ee17ea3ba3b20f7dbacf4a8c7b0" //any String (or Note1)

  class MyFacebookClient(currentAccessToken: String)
    extends DefaultFacebookClient(currentAccessToken, myAppSecret, Version.VERSION_5_0) {

  }

  def getUser(accessToken: String, id: String): Future[User] = Future {
    val client = new MyFacebookClient(accessToken)
    val user = client.fetchObject(id, classOf[User])
    user
  }

  def extendFile(logFile: String, user1: String, user2: String): Unit = {
    val file = new File(logFile)
    val bw = new BufferedWriter(new FileWriter(file))
    bw.write(s"${Calendar.getInstance().getTime} $user1 $user2")
    bw.close()
  }

  def getLikesSafe(u:User):Long ={
    u.getLikes match {
      case l:Likes => l.getTotalCount
      case _ => 0
    }
  }
  def printStats(user1: User, user2: User): Unit = {
    println(s"${user1.getName}" +
      s", likes: ${getLikesSafe(user1)} " +
      s"vs. ${user2.getName}" +
      s", likes: ${getLikesSafe(user2)}")
  }

  def compareLikes(logFile: String,
                   user1: String, user2: String): Unit = {
    val accessToken="EAAR40ZBqyVQABAO1vte4DsZCJDqkpZBOZB8MnbaAxnx4j1b9LzUsquk84SCBaH0N9cgpyQAbxzdn7gbv9aRjYKP4jqFcZCrohfZCSvb7l8v07nvZAAzSSFwJD1Y7mZAfpRb3R1MzI1fMa9kLxZAZAvJfj6D5AxAHwMLWtBAmtWaAPsds4VtAorxRZClZAZBbVfpzJg43NnNnzuWbjfQZDZD"
    val user1Future = getUser(accessToken, user1)
    val user2Future = getUser(accessToken, user2)
    val users = Await.result(user1Future zip user2Future, Duration.Inf)
    extendFile(logFile, user1, user2)
    printStats(users._1, users._2)
  }
}
