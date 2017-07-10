# simple grep implementation
# Brian Heim, 2017-07-09
class Grep
  def self.grep(filename, regex)
    f = File.open(filename, "r")
    f.each {|line|
      accum = 0
      orig_line = line
      while i = (regex =~ line)
        i += 1
        accum += i
        puts "#{f.lineno}[#{accum-1}]: #{orig_line}"
        line = line.slice(i, line.size-i)
      end
    }
  end
end

class String
  def grep(regex)
    Grep.grep(self, regex)
  end
end
