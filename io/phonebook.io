# phonebook.io
# Brian Heim
# 2017-07-17

# create a new operator for atPutNumber
OperatorTable addAssignOperator(":", "atPutNumber")

# make { } into a method call
# create a new map, and for each argument (separated by `,`),
# do message with that argument
curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
  r
)

# same as atPut, but the first element is stripped of its leading and trailing quotes
Map atPutNumber := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
    call evalArgAt(1)
  )
)

s := File with("phonebook.txt") openForReading contents

phoneNumbers := doString(s)
phoneNumbers keys println
phoneNumbers values println
