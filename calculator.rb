class Calculator 

  PRECISION = 8

  DELIMITER = ','

  def add(numbers = '')
    numbers = '' if numbers.nil?
    numbers = numbers.split(DELIMITER)
    numbers.map!(&:to_f)
    numbers.inject(0) { |sum, s| sum += s }.round(PRECISION)
  end

end
