require 'byebug'

def calculate_manhattan_distance(loc_a, loc_b)
  x = (loc_a[0] - loc_b[0]).abs
  y = (loc_a[1] - loc_b[1]).abs
  x + y
end

def find_largest_noninfinite_area(file)
  coords = File.readlines(file).map(&:chomp).map { |coord| coord.split(", ").map(&:to_i) }
  max_x = coords.map { |coord| coord[0] }.max
  max_y = coords.map { |coord| coord[1] }.max

  grid = Array.new(max_y) { Array.new(max_x) }
  closest_coord_frequencies = Hash.new(0)

  grid.each_with_index do |row, row_idx|
    row.each_index do |col_idx|
      loc = [col_idx, row_idx]
      closest_coord = nil
      closest_dist = nil

      coords.each do |coord|
        dist = calculate_manhattan_distance(coord, loc)
        if closest_dist.nil? || dist < closest_dist
          closest_coord = coord
          closest_dist = dist
        elsif dist == closest_dist
          closest_coord = nil
        end
      end
      grid[row_idx][col_idx] = closest_coord
      closest_coord_frequencies[closest_coord] += 1 if closest_coord
    end
  end

  grid.each_with_index do |row, row_idx|
    if row_idx == 0 || row_idx == grid.length - 1
      row.each { |coord| closest_coord_frequencies.delete(coord) }
    end

    closest_coord_frequencies.delete(row[0])
    closest_coord_frequencies.delete(row[-1])
  end

  closest_coord_frequencies.sort_by { |_, v| v }.last[1]
end

def find_safe_region(file)
  coords = File.readlines(file).map(&:chomp).map { |coord| coord.split(", ").map(&:to_i) }
  max_x = coords.map { |coord| coord[0] }.max
  max_y = coords.map { |coord| coord[1] }.max

  grid = Array.new(max_y) { Array.new(max_x) }
  safe_region_coords = 0

  grid.each_with_index do |row, row_idx|
    row.each_index do |col_idx|
      loc = [col_idx, row_idx]
      total_dist = 0

      coords.each do |coord|
        dist = calculate_manhattan_distance(coord, loc)
        total_dist += dist
      end

      safe_region_coords += 1 if total_dist < 10000
    end
  end

  safe_region_coords
end


if __FILE__ == $PROGRAM_NAME
  puts find_largest_noninfinite_area("input.txt")
  puts find_safe_region("input.txt")
end
