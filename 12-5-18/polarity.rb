require 'byebug'

def find_remaining_units(file)
  input = File.read(file).chomp.split("")
  i = 0

  while i < input.length
    if i != input.length - 1 && (input[i].ord - input[i+1].ord).abs == 32
      2.times { input.delete_at(i) }
      i -= 1
    else
      i += 1
    end
  end

  input.length
end

def find_problem_polymer(file)
  input = File.read(file).chomp.split("")
  alphabet = ('a'..'z').to_a

  shortest_length = input.length
  best_letter_to_remove = nil

  alphabet.each do |letter|
    input_copy = input.dup

    input_copy.delete(letter)
    input_copy.delete(letter.upcase)

    i = 0

    while i < input_copy.length
      if i != input_copy.length - 1 && (input_copy[i].ord - input_copy[i+1].ord).abs == 32
        2.times { input_copy.delete_at(i) }
        i -= 1
      else
        i += 1
      end
    end

    if input_copy.length < shortest_length
      shortest_length = input_copy.length
      best_letter_to_remove = letter
    end
  end

  debugger
end

if __FILE__ == $PROGRAM_NAME
  # puts find_remaining_units("input.txt")
  puts find_problem_polymer("input.txt")
end
