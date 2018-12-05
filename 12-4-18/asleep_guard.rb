require 'byebug'

def strategy_1(file)
  log = sort_times(File.readlines(file).map(&:chomp))

  guards = Hash.new(0)
  guard_sleep_times = Hash.new { |h, k| h[k] = Array.new(60, 0) }

  curr_guard = nil
  start_time = nil
  end_time = nil

  log.each do |entry|
    if entry[2] == "Guard"
      curr_guard = entry[3]
    elsif entry[2] == "falls"
      start_time = entry[1].split(":")[1].to_i
    else
      end_time = entry[1].split(":")[1].to_i
      sleep_time = end_time - start_time

      guards[curr_guard] += sleep_time
      (start_time...end_time).each do |minute|
        guard_sleep_times[curr_guard][minute] += 1
      end
    end
  end


  sleepiest_guard = guards.sort_by { |_, v| v }.last[0]
  sleepiest_guard_times = guard_sleep_times[sleepiest_guard]
  favorite_sleeping_minute = sleepiest_guard_times.max
  minute = sleepiest_guard_times.index(favorite_sleeping_minute)
  sleepiest_guard_num = sleepiest_guard.delete("#").to_i

  minute * sleepiest_guard_num
end

def strategy_2(file)
  log = sort_times(File.readlines(file).map(&:chomp))

  guards = Hash.new(0)
  guard_sleep_times = Hash.new { |h, k| h[k] = Array.new(60, 0) }

  curr_guard = nil
  start_time = nil
  end_time = nil

  log.each do |entry|
    if entry[2] == "Guard"
      curr_guard = entry[3]
    elsif entry[2] == "falls"
      start_time = entry[1].split(":")[1].to_i
    else
      end_time = entry[1].split(":")[1].to_i
      sleep_time = end_time - start_time

      guards[curr_guard] += sleep_time
      (start_time...end_time).each do |minute|
        guard_sleep_times[curr_guard][minute] += 1
      end
    end
  end

  longest_minute_sleeping = 0
  guard = nil
  guard_favorite_minute = 0

  guard_sleep_times.each do |curr_guard, sleep_times|
    favorite_sleeping_minute = sleep_times.max
    minute = sleep_times.index(favorite_sleeping_minute)

    if favorite_sleeping_minute > longest_minute_sleeping
      longest_minute_sleeping = favorite_sleeping_minute
      guard_favorite_minute = minute
      guard = curr_guard
    end
  end

  guard_num = guard.delete("#").to_i

  debugger
  return guard_num * guard_favorite_minute
end

def sort_times(times)
  times.map! { |time| time.delete("[]") }.map!(&:split)
  times.sort_by { |el| el[0] + el[1] }
end

if __FILE__ == $PROGRAM_NAME
  puts strategy_1("input.txt")
  puts strategy_2("input.txt")
end
