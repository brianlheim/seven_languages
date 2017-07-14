# tetration operator definition
# Brian Heim
# 2017-07-14

OperatorTable addOperator("tetr", 0.5) # precedence: higher than **, lower than ?, @, @@

Number tetr := method(n,
  if(n == 0, return 1) # technically not right for negative numbers...
  absn := n abs
  result := self
  (absn-1) repeat( result = self ** result )
  if(n > 0, result, 1 / result)
)
