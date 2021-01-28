package controllers

import javax.inject._
import play.api._
import play.api.mvc._
import models.{DB, Student}
/**
 * This controller creates an `Action` to handle HTTP requests to the
 * application's home page.
 */
@Singleton
class HomeController @Inject()(val controllerComponents: ControllerComponents) extends BaseController {

  /**
   * Create an Action to render an HTML page.
   *
   * The configuration in the `routes` file means that this method
   * will be called when the application receives a `GET` request with
   * a path of `/`.
   */
  def index() = Action { implicit request: Request[AnyContent] =>
    Ok(views.html.index())
  }
  def stu() = Action { implicit request: Request[AnyContent] =>
    Ok(views.html.students(DB.students))
  }
  def lect() = Action { implicit request: Request[AnyContent] =>
    Ok(views.html.lectures(DB.lectures))
  }
  def one_stu(index : Int) = Action { implicit request: Request[AnyContent] =>
    DB.students.find(s => s.index == index) match {
      case None => NotFound(f"We haven't got any student with index $index in database")
      case Some(s) => Ok(views.html.one_student(s))
    }
  }
  def one_lect(id:String) = Action { implicit request: Request[AnyContent] =>
    DB.lectures.find(l => l.id == id) match {
      case None => NotFound(f"We haven't got any lecture with id $id in database")
      case Some(l) => DB.enrollments.find(e => e.id  == id) match {
        case None => Ok(views.html.one_lecture(l, Nil))
        case Some(e) => Ok(views.html.one_lecture(l, e.students))
      }
    }
  }
}
