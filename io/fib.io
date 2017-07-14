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

