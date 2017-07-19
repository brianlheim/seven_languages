# builderAttr.io
# XML builder with attributes!
# Brian Heim
# 2017-07-17

# do phonebook file to give access to {"key": "value"} notation
doFile("phonebook.io")

Builder := Object clone

Builder indentLevel := 0
Builder indent := method(self indentLevel = self indentLevel + 1)
Builder deindent := method(self indentLevel = self indentLevel - 1)
Builder writeIndent := method((self indentLevel-1) repeat(write("  ")) )

# return a string with the right level of indentation
Builder indentStr := method(
  result := "" 
  (self indentLevel-1) repeat(result = result .. "  ") 
  result
)

Map asXMLAttributes := method(
  result := ""
  self keys foreach(key,
    result = result .. " " .. key .. "=\"" .. self at(key) .. "\""
  )
  result
)

Builder forward := method(
  self indent

  attrs := Map clone # attributes for this tag
  result := ""      # resulting string
  call message arguments foreach(arg,
    argContent := self doMessage(arg)
    # if it's a sequence, it could either be a real string or a new tag structure
    if(argContent type == "Sequence",
      if(argContent containsSeq("<") not,
        self indent
        result = result .. self indentStr .. argContent .. "\n"
        self deindent
      ,
        result = result .. argContent
      )
    ,
      if(argContent type == "Map",
        attrs = argContent
      )
    )
  )

  openTag := "<" .. call message name .. attrs asXMLAttributes .. ">"
  openTag = self indentStr .. openTag .. "\n"
  closeTag := "</" .. call message name .. ">"
  closeTag = self indentStr .. closeTag .. "\n"
  result = openTag .. result .. closeTag

  self deindent
  result
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
