# builder.io
# Turn simple io notation into XML-style output
# Brian Heim
# 2017-07-17

Builder := Object clone

Builder indentLevel := 0
Builder indent := method(self indentLevel = self indentLevel + 1)
Builder deindent := method(self indentLevel = self indentLevel - 1)
Builder writeIndent := method((self indentLevel-1) repeat(write("  ")) )

Builder forward := method(
  self indent
  self writeIndent
  writeln("<", call message name, ">")
  call message arguments foreach(arg,
    content := self doMessage(arg);
    if(content type == "Sequence",
      self indent
      self writeIndent
      writeln(content)
      self deindent
    )
  )
  self writeIndent
  writeln("</", call message name, ">")
  self deindent
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
