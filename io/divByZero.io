# Change the behavior of / to return 0 if denom is 0
# Brian Heim
# 2017-07-14

Number oldDiv := Number getSlot("/")
Number / := method(d, 
  if(d == 0, 0, self oldDiv(d))
)
