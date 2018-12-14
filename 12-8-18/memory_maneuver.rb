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

def find_root_value(file)
  instructions = File.read(file).split.map(&:to_i)
  res = build_node_2(instructions)

  res[:points]
end

def build_node_2(instructions)
  num_children = instructions.shift
  num_meta = instructions.shift
  points = 0

  children = []

  until num_children == 0
    num_children -= 1
    res = build_node_2(instructions)

    children << res
  end

  until num_meta == 0
    num_meta -= 1
    child_idx = instructions.shift

    if children.empty?
      points += child_idx
    else
      points += children[child_idx-1][:points] if children[child_idx-1]
    end
  end

  return { points: points, instructions: instructions}
end

if __FILE__ == $PROGRAM_NAME
  puts build_tree("input.txt")
  puts find_root_value("input.txt")
end
