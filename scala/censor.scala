// Censor trait
// Replaces curse words with non
// Brian Heim, 2018-01-06
import scala.io.Source

trait Censor {
  val replacements: Array[(String, String)] = {
    Source.fromFile("curses.txt").getLines()
      .map { _.split(' ') }
      .map { ss =>
        ("\\b" + ss(0) + "\\b", ss(1))
      }
      .toArray
  }

  def censor(s: String): String = {
    replacements.foldLeft(s) {
      (partial, censation) => partial.replaceAll(censation._1, censation._2)
    }
  }
}

class Person(val greeting: String) {
  def greet() = println(greeting)
}

class CensoredPerson(override val greeting: String) extends Person(greeting) with Censor {
  override def greet() = println(censor(greeting))
}

val censed = new CensoredPerson("classic!fuck")
val person = new Person(censed.greeting)
censed.greet()
person.greet()
