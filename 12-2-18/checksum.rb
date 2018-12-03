require 'byebug'

def checksum(file)
  words = File.readlines(file).map(&:chomp)
  twos = 0
  threes = 0

  words.each do |word|
    res = twos_and_threes(word)

    twos += 1  if res['two']
    threes += 1 if res['three']
  end

  twos * threes
end

def twos_and_threes(str)
  letters = Hash.new(0)

  str.each_char { |char| letters[char] += 1 }

  res = Hash.new(false)

  res['two'] = true if letters.any? { |_, count| count == 2 }
  res['three'] = true if letters.any? { |_, count| count == 3 }

  res
end

def find_correct_boxes(file)
  words = File.readlines(file).map(&:chomp)

  i = 0

  while i < words.length
    j = i + 1

    while j < words.length
      res = compare_strings(words[i], words[j])

      if res
        word = words[i]
        str = ''

        str += word[0...res]
        str += word[i+1..-1] unless word[i+1..-1].nil?
        
        return str
      end

      j += 1
    end

    i +=1
  end
end

def compare_strings(str1, str2)
  diffs = 0
  split_idx = 0

  str1.chars.each_index do |i|
    if str1[i] != str2[i]
      diffs += 1
      split_idx = i
    end
  end

  return split_idx if diffs == 1
  false
end

if __FILE__ == $PROGRAM_NAME
  puts find_correct_boxes("input.txt")
end
