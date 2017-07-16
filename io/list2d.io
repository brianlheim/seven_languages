# 2d list prototype
# Brian Heim
# 2017-07-15

List2D := List clone

dim := method(x, y,
  result := List2D clone
  x repeat(
    result append(list())
    y repeat(
      result last append(0)
    )
  )
  result
)

List2D cols := method(self at(0) size)
List2D rows := method(self size)

List2D set := method(x, y, val,
  self at(x) atPut(y, val)
  self
)

List2D get := method(x, y, val, self at(x) at(y))

List2D transpose := method(
  result := dim(self cols, self rows)
  for(i, 0, result rows - 1,
    for(j, 0, result cols - 1,
      result set(i, j, self get(j, i))
    )
  )
  result
)
