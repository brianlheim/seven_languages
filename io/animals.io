# animals.io
# Brian Heim
# 2017-07-13

Object ancestors := method(
  prototype := self proto
  if(prototype != Object,
    writeln("Slots of ", prototype type, "\n----------")
    prototype slotNames foreach(slotName, writeln(slotName))
    writeln
    write("speaking: "); prototype speak
    write("walking: "); prototype walk
    prototype ancestors))

Animal := Object clone
Animal speak := method("ambiguous animal noise" println)
Animal walk := method("ambiguous animal walk" println)

Duck := Animal clone
Duck speak := method("quack" println)
Duck walk := method("waddle" println)

disco := Duck clone
disco ancestors

MagicDuck := Duck clone
MagicDuck speak := method("quackracadabra" println)
MagicDuck walk := method("walkracadabra" println)

disco2 := MagicDuck clone
disco2 ancestors
