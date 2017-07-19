# bracketList.io
# Use brackets for list syntax
# Brian Heim
# 2017-07-19

squareBrackets := method(
  result := list()
  call message arguments foreach(arg,
    result append(doMessage(arg))
  )
  result
)

curlyBrackets := method(
  result := list()
  call message arguments foreach(arg,
    result append(doMessage(arg) sqrt)
  )
  result
)

List sqrt := method(
  self foreach(i, e,
    self atPut(i, e sqrt)
  )
  self
)
