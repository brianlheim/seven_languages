package com.brianheim.akka.chicken

import akka.actor._
import akka.actor.Actor._
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.util.Random

case object Pet
case object Feed
case object Cluck
case class Befriend(val friend: ActorRef)
case class GetEaten(val by: String)

object Chicken {
  def props(name: String, friends: Array[ActorRef]): Props =
    Props(new Chicken(name, friends))

}

class Chicken(val name: String, var friends: Array[ActorRef]) extends Actor() {
  import context._

  def receive = {
    case Pet => {
      println(name + ": I AM PET")
    }
    case Feed => {
      println(name + ": nom nom nom")
      context.system.scheduler.scheduleOnce(Random.nextFloat * 4 second) { friends foreach { _ ! Pet } }
      friends foreach { c => context.system.scheduler.scheduleOnce(Random.nextFloat * 3 second) { c ! Cluck } }
      friends foreach { c =>
        if (Random.nextInt % 10 > 7) {
          c ! GetEaten("bog monster summoned by " + name)
        }
      }
    }
    case Cluck => {
      println(name + ": cluck!")
      context.system.scheduler.scheduleOnce(Random.nextFloat * 4 second) { friends foreach { _ ! Feed } }
    }
    case Befriend(friend) => {
      println(name + ": friends with " + friend.path + " now.")
      addFriend(friend)
    }
    case GetEaten(by) => {
      println(name + ": I was eaten by a " + by + ". I'm not quite dead yet though.")
    }
  }

  def addFriend(friend: ActorRef): Unit = {
    friends = friends ++ Array(friend)
  }
}

object AkkaChickenTest extends App {

  val system = ActorSystem("chickens")

  val garrett = system.actorOf(Chicken.props("garrett", Array()), "garrettActor")
  val martha = system.actorOf(Chicken.props("martha", Array(garrett)), "marthaActor")
  val jacobus = system.actorOf(Chicken.props("jacobus", Array(garrett, martha)), "jacobusActor")

  println("Let the chickens begin.")
  garrett ! Cluck
  martha ! Cluck
  jacobus ! Cluck

  garrett ! Befriend(martha)

  system.scheduler.scheduleOnce(2 second) { martha ! GetEaten("wolve") }

  system.scheduler.scheduleOnce(1 second) { partTwo}


  system.scheduler.scheduleOnce(5 second) { system.terminate() }

  def partTwo() = {
    garrett ! Befriend(jacobus)

    val randolph = system.actorOf(Chicken.props("randolph", Array()), "randolphActor")

    garrett ! Befriend(randolph)
    martha ! Befriend(randolph)
    martha ! Pet
    jacobus ! Befriend(randolph)
    randolph ! Feed
    randolph ! Cluck
  }
}
