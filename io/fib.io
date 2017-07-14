# fibonnaci implementations
# Brian Heim
# 2017-07-14

# methods using messages to number

# double-recursive method (very slow)
Number fib := method(
  (self < 2) ifTrue(return self)
  (self-1) fib + (self-2) fib
)

# loop method (very fast)
Number fibLoop := method(
  (self < 2) ifTrue(return self)
  fib1 := 1
  fib2 := 0
  (self-1) repeat(
    tempSum := fib1 + fib2
    fib2 = fib1
    fib1 = tempSum
  )
  fib1
)
