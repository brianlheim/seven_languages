(
  i = rand(10)
  puts "Enter your number: "
  g = -1
  until g == i
    g = gets.to_i
    if (g > i)
      puts "Sorry! #{g} is too high."
    else 
      if (g < i)
        puts "Sorry, #{g} is too low."
      else
        puts "Yay! #{g} is just right."
      end
    end
  end
)
