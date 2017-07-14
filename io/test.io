Magic := Object clone

magician := Magic clone

magician trick := method( "abracadabra" println )

magician costume ::= "wolverine"

"trick: " print
magician trick
"costume: " print
magician costume println
"new costume: " print
magician setCostume("rabbit") costume println

