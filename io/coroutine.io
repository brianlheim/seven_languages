# basic coroutine playground
# Brian Heim
# 2017-07-17

vizzini := Object clone
vizzini talk := method(
  "Fezzik, be there rox ahied?" println
  yield
  "stop rhyming please" println
  yield
)

fezzik := Object clone
fezzik rhyme := method(
  yield
  "If there are we'll all be died?" println
  yield
  "好不好？" println
)

vizzini @@talk; fezzik @@rhyme

