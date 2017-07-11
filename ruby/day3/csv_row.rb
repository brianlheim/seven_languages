# CsvRow.rb
# Brian Heim
# 2017-07-10

# Acts as a 
class CsvRow

  def initialize row, headers
    @elements = {}
    headers.each_with_index do |item, i|
      @elements[item] = row[i]
    end
  end

  def method_missing name, *args
    @elements[name.to_s]
  end

  attr_accessor :elements

end

