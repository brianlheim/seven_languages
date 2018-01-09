package com.brianheim.akka.chicken

import akka.actor._
import akka.actor.Actor._
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.util.Random
import scala.io.Source
import scala.util.matching._
import scala.util.matching.Regex._

object Main {
  val urls = List("http://www.amazon.com/",
    "https://www.twitter.com/",
    "https://www.google.com/",
    "https://www.github.com/",
    "https://www.netflix.com/",
    "https://stackoverflow.com/",
    "https://www.microsoft.com/",
    "https://www.youtube.com/",
    "http://jobs.com/",
    "https://www.cnn.com/")

  def timeMethod(method: () => Unit) = {
    val start = System.nanoTime
    method()
    val end = System.nanoTime
    println("Method took " + (end - start)/1000000000.0 + " seconds.")
  }

  def sequential(system: ActorSystem) = {
    val loader1 = system.actorOf(PageLoader.props(), "singleLoader")
    for (url <- urls) { loader1 ! url }
  }

  def concurrent(system: ActorSystem) = {
    val loaders = (0 until urls.length).map { i => system.actorOf(PageLoader.props(), "loader" + i) }
    for ((l, u) <- loaders.zip(urls)) { l ! u }
  }
}

object PageLoader {
  def props(): Props =
    Props(new PageLoader())

  def getPageSize(url: String): Int = getPage(url).length
  def getPage(url: String): String = try { Source.fromURL(url)("ISO-8859-1").mkString } catch {
    case _: Throwable => return ""
  }
}

class PageLoader() extends Actor() {

  def receive = {
    case (url: String, size: Int) => {
      println(url + ' ' + size)
    }
    case (url: String, contents: String) => {
      val reg = """<a href="((?:http|//www)[^"]*)"""".r

      var count = 0
      val matches: Iterator[Match] = reg.findAllMatchIn(contents)
      val sizes = matches.map { m =>
        count += 1
        println(count + " " + m.group(1))
        PageLoader.getPageSize(m.group(1))
      }

      context.self ! (url, sizes.foldLeft(0) { _ + _ })
    }
    case (url: String) => {
      context.self ! (url, PageLoader.getPage(url))
    }
  }
}

object Sizer extends App {
  import Main._

  val system = ActorSystem("sizer")

  concurrent(system)

  system.scheduler.scheduleOnce(60 second) { system.terminate() }
}
