require 'byebug'

def build_tree(file)
  instructions = File.read(file).split.map(&:to_i)
  res = build_node(instructions)

  res[:points]
end

def build_node(instructions)
  num_children = instructions.shift
  num_meta = instructions.shift
  points = 0

  until num_children == 0
    num_children -= 1
    res = build_node(instructions)
    instructions = res[:instructions]
    points += res[:points]
  end

  until num_meta == 0
    num_meta -= 1
    points += instructions.shift
  end

  return { points: points, instructions: instructions}
end

if __FILE__ == $PROGRAM_NAME
  puts build_tree("input.txt")
end
