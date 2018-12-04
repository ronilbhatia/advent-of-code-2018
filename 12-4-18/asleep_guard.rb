require 'byebug'

def strategy_1(file)
  sleep_times = sort_times(File.readlines(file).map(&:chomp))
  debugger

end

def sort_times(times)
  times.map! { |time| time.delete("[]") }.map!(&:split)
  times.sort_by { |el| el[0] + el[1] }
end

if __FILE__ == $PROGRAM_NAME
  strategy_1("input.txt")
end
