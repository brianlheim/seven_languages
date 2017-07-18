# builder.io
# Turn simple io notation into XML-style output
# Brian Heim
# 2017-07-17

Builder := Object clone

Builder forward := method(
  writeln("<", call message name, ">")
  call message arguments foreach(arg,
    content := self doMessage(arg);
    if(content type == "Sequence", writeln(content))
  )
  writeln("</", call message name, ">")
)

Builder squareBrackets := method(
  call message arguments foreach(arg,
    self doMessage(arg)
  )
)

Builder ol(
  li("io"),
  li("happy"),
  ol(
    li("test"),
    li("this"),
    li("out"),
    em(li("bold list element"))
  ),
  p("paragraph text")
  table(tr(td("table element")))
)
