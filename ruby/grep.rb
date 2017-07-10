# simple grep implementation
# Brian Heim, 2017-07-09
class Grep
  def self.grep(filename, regex)
    f = File.open(filename, "r")
    f.each {|line|
      if regex.match(line)
        puts "#{f.lineno}: #{line}"
      end
    }
  end
end

class String
  def grep(regex)
    Grep.grep(self, regex)
  end
end
