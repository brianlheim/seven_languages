# Sum a two-dimensional array
# Brian Heim
# 2017-07-14

sum2d := method(m,        # take a matrix as an argument
  result := 0             # initialize the result
  m foreach(r,            # for each column of the list
    r foreach(e,          # for each element of the column
      result = result + e # add the element to the result
    )
  )
  result                  # return the sum
)
