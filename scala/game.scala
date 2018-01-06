// Takes a tic-tac-toe board with X, O, blanks, detects the winner/tie/no winner

import scala.language.postfixOps

class Game() {
  val side = 3
  val arr = Array.ofDim[Char](side, side)

  def this(board: String) {
    this()
    populate(board)
  }

  def populate(board: String): Unit = {
    val matrix = board split '\n' map { _.toArray } reduce { _ ++ _ }

    if (matrix.size != side * side) {
      throw new Exception("board must be of length " + (side * side))
    }

    if (matrix map { "XO " contains _ } reduce { !_ && !_ }) {
      throw new Exception("some character is bad")
    }

    var ctr = 0
    arr.indices.foreach { x =>
      arr(x).indices.foreach { y =>
        arr(x)(y) = matrix(ctr)
        ctr += 1
      }
    }
  }

  def out(): Unit = {
    val rowSep = "-" * (side * 2 + 1)

    println(rowSep)
    arr foreach { row =>
      print('|')
      row foreach { col =>
        print(col.toString + '|')
      }
      println
      println(rowSep)
    }
  }

  def hasWinner(): Boolean = true

  def winner(): Option[Char] = Some('X')

  def status(): String = {
    val str: String = winner getOrElse "null" toString()
    str
  }
}

try {
  val game = new Game("XXX\nOOO\n   ")
  println(game.hasWinner)
  println(game.winner)
  println(game.status)
  println(game.arr)
  game.out
} catch {
  case e: Exception => println(e)
}

