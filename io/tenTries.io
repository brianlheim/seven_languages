# Program that gives you 10 tries to guess a number between 0 and 100
# Brian Heim
# 2017-07-16

secretNumber := (Random value * 100) round

"Guess a secret number!" println

guessCount := 0
guessed := false

while ( guessed not and guessCount < 10,
  number := File standardInput readLine
  number = number asNumber
  if ( number == secretNumber,
    guessed = true
    ("You guessed it! It was " .. number .. ".") println
  , 
    "Wrong! Go " print
    if ( number < secretNumber, "higher", "lower" ) println
    guessCount = guessCount + 1
  )
)

if ( guessed, "you did it", "you failed" )
