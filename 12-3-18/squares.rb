require 'byebug'

def find_overlapping_squares(file)
  squares = File.readlines(file).map(&:chomp).map(&:split)
  grid = Array.new(1000) { Array.new(1000) }

  squares.each do |square|
    offsets = square[2].delete(":").split(",")
    left_offset = offsets[0].to_i
    top_offset = offsets[1].to_i

    spans = square[3].split("x")
    width = spans[0].to_i
    length = spans[1].to_i

    (top_offset...top_offset+length).each do |i|
      (left_offset...left_offset+width).each do |j|
        if grid[i][j].nil?
          grid[i][j] = "X"
        else
          grid[i][j] = "O"
        end
      end
    end

  end
  return grid.flatten.count("O")
end

def find_non_overlapping_square(file)
  squares = File.readlines(file).map(&:chomp).map(&:split)
  grid = Array.new(1000) { Array.new(1000) }

  squares.each do |square|
    offsets = square[2].delete(":").split(",")
    left_offset = offsets[0].to_i
    top_offset = offsets[1].to_i

    spans = square[3].split("x")
    width = spans[0].to_i
    length = spans[1].to_i

    (top_offset...top_offset+length).each do |i|
      (left_offset...left_offset+width).each do |j|
        if grid[i][j].nil?
          grid[i][j] = "X"
        else
          grid[i][j] = "O"
        end
      end

    end
  end

  squares.each do |square|
    offsets = square[2].delete(":").split(",")
    left_offset = offsets[0].to_i
    top_offset = offsets[1].to_i

    spans = square[3].split("x")
    width = spans[0].to_i
    length = spans[1].to_i

    collides = false
    (top_offset...top_offset+length).each do |i|
      (left_offset...left_offset+width).each do |j|
        collides = true if grid[i][j] == "O"
      end
    end

    return square unless collides
  end
end

if __FILE__ == $PROGRAM_NAME
  puts find_overlapping_squares("input.txt")
  puts find_non_overlapping_square("input.txt")
end
