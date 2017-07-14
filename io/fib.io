# fibonnaci implementations
# Brian Heim
# 2017-07-14

# double-recursive method (very slow)
Number fib := method(
  if(self <= 0, 0,
    if(self <= 2, 1,
      ((self-1) fib) + ((self-2) fib)
    )
  )
)

# loop method (very fast)
Number fibLoop := method(
  if(self <= 0, 0,
    fib1 := 1
    fib2 := 0
    while(self > 1,
      tempSum := fib1 + fib2
      fib2 = fib1
      fib1 = tempSum
      self = self - 1
    )
    fib1
  )
)
