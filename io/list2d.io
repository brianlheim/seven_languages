# 2d list prototype
# Brian Heim
# 2017-07-15

List2D := List clone

dim := method(x, y,
  result := List2D clone
  y repeat(
    result append(list())
    x repeat(
      result last append(0)
    )
  )
  result
)

List2D set := method(x, y, val,
  self at(x) atPut(y, val)
)

List2D get := method(x, y, val, self at(x) at(y))
