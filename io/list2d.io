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

List2D asString := method(
  result := ""
  for(i, 0, self rows - 1,
    result = result .. "[ "
    for(j, 0, self cols - 1,
      result = result .. self get(i, j) .. if(j == self cols - 1, "", ", ")
    )
    result = result .. if(i == self rows - 1, " ]", " ]\n")
  )
  result
)

Sequence asList2D := method(
  splitSelf := self split("\n")
  lists := splitSelf mapInPlace( x, x exSlice(2, x size - 2) split(", ") )
  result := dim(lists size, lists at(0) size)
  for(i, 0, lists size - 1,
    for(j, 0, lists at(0) size - 1,
      result set(i, j, lists at(i) at(j))
    )
  )
  result
)

