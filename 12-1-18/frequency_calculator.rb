require 'byebug'

def frequency_calculator(file)
  frequencies = File.readlines(file).map(&:chomp)
  frequencies.reduce(0) do |sum, delta|
    direction = delta[0]
    magnitude = delta[1..-1].to_i
    if direction == "+"
      sum + magnitude
    else
      sum - magnitude
    end
  end
end

def first_frequency_reached_twice(file)
  frequency_deltas = File.readlines(file).map(&:chomp)
  frequencies = Hash.new(0)
  current_frequency = 0

  while true
    frequency_deltas.each do |delta|
      direction = delta[0]
      magnitude = delta[1..-1].to_i
      frequencies[current_frequency] += 1

      if frequencies[current_frequency] == 2
        return current_frequency
      end

      if direction == "+"
        current_frequency += magnitude
      else
        current_frequency -= magnitude
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts first_frequency_reached_twice("input.txt")
end
