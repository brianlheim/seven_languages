# Add a slot that computes the average of all the numbers in a list
# Brian Heim
# 2017-07-14

List myAverage := method(
  if(self isEmpty, return) # return nil
  sum := 0
  self foreach(e, sum = sum + e)
  sum / self size
)

