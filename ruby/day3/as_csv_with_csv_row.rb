# acts_as_csv_module.rb
# 2017-07-10

module ActsAsCsv

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(',')

      file.each do |row|
        split_row = row.chomp.split(',')
        @csv_contents << CsvRow.new(split_row, headers)
      end
    end

    def each(&block)
      @csv_contents.each {|row| block.call row }
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

  end
end

class RubyCsv # no inheritance! mixin
  include ActsAsCsv
  acts_as_csv
end

