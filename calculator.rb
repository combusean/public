require 'pry'

class Calculator 

  PRECISION = 8
  DEFAULT_DELIMITERS = [',']

  attr_accessor :delimiters
  
  def initialize
    @delimiters ||= DEFAULT_DELIMITERS
  end

  def add(numbers = '')

    numbers = sanitize_input(numbers)
    check_input(numbers)
    regex = '[' + @delimiters.join() + ']'
    @delimiters = DEFAULT_DELIMITERS

    numbers = numbers.split(/#{regex}/)
    numbers.map!(&:to_f)
    numbers.inject(0) { |sum, s| sum += s }.round(PRECISION)
  end

  def sanitize_input(numbers)
    numbers ||= ''
    numbers = configure_delimiters(numbers) if numbers.index("//") == 0
    numbers.gsub!(' ', '')
    numbers
  end

  def configure_delimiters(configuration)
    @delimiters = [configuration[2..configuration.index("\n")]]
    configuration = configuration.split("\n")
    configuration.shift
    configuration.join("\n")
  end

  def check_input(numbers)
    check_delimiters(numbers) if @delimiters.length > 1
  end

  def check_delimiters(numbers)
    @delimiters.all_possibilities(@delimiters.length).map(&:join).each do |invalid_occurence|
      raise ArgumentError, "Invalid delimiters in input." if numbers =~ /#{invalid_occurence}/ 
    end
  end

end

#http://stackoverflow.com/questions/14375055/generate-all-possible-permutations-of-characters-with-a-given-maximum-length
class Array
  def all_possibilities(range)
    return permutation(range).to_a if range < size

    (size..range).flat_map do |i|
      permutation(range - i).flat_map do |e|
        (self + e).permutation.to_a
      end
    end
  end
end
