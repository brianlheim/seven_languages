// Takes a tic-tac-toe board with X, O, blanks, detects the winner/tie/no winner

import scala.language.postfixOps

class Game() {
  val side = 3
  val arr = Array.ofDim[Char](side, side)
  var turn = 'X'

  populate(" " * (side * side))

  def this(board: String) {
    this()
    populate(board)
  }

  start

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

  def winner(): String = {
    val chars = Array('X', 'O')
    val rows: Array[Array[Char]] = arr
    val cols: Array[Array[Char]]  = arr.transpose
    val range = 0 until side toArray
    val diags: Array[Array[Char]]  = range map { i => Array(arr(i)(i), arr(i)(side-1-i)) } transpose;
    val ways: Array[Array[Char]] = Array(rows, cols, diags).flatten

    val winning = chars map { char => ways.exists { way => way.forall(_ == char) } }

    if (winning(0)) {
      if (winning(1)) {
        return "Tie"
      } else {
        return "X"
      }
    } else {
      if (winning(1)) {
        return "O"
      } else {
        return if (arr.flatten.forall(_ != ' ')) "Tie" else "None"
      }
    }
  }

  def status(): String = {
    winner
  }

  def placePiece(x: Int, y: Int): Unit = {
    if (Array(x, y).exists(i => !(0 until side).contains(i))) {
      println("Out of bounds!")
      return
    }
    if (arr(x)(y) != ' ') {
      println("That spot is already taken.")
      return
    }
    println("Placing (" + x + ", " + y + ")")
    arr(x)(y) = turn
    turn = if (turn == 'X') 'O' else 'X'
    out
  }

  def start(): Unit = {
    out

    while (winner == "None") {
      println(turn + "'s turn. What position?")
      var line = scala.io.StdIn.readLine()
      var Array(x, y) = line.split(" ").map(_.toInt)
      placePiece(x, y)
    }

    out
    println("Winner is: " + winner)
  }
}

try {
  var game = new Game()
} catch {
  case e: Exception => println(e)
}

