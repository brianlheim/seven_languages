class Bear {

  val seasons = List("spring", "summer", "autumn", "winter")
  var berries = 0

  print("Initial season: ")
  println(season)

  def season() = seasons(berries)

  def inform() {
    println("Ate " + berries + " berries. Now " + season + ".")
    if (hibernating) {
      println("Hibernating...")
    } else {
      println("Not hibernating! This momma's all wired up.")
    }
  }

  def hibernating() = season == "winter"

  def eat() {
    berries = (berries + 1) % seasons.size
    inform
  }

  def vomit() {
    berries = (berries + seasons.size - 1) % seasons.size
    inform
  }
}

val bear = new Bear

bear.eat
bear.eat
bear.vomit
bear.eat
bear.eat
bear.eat
bear.vomit
bear.vomit
bear.vomit
bear.vomit
bear.vomit
