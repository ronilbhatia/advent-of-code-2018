require_relative 'node'
require 'byebug'

def order_steps(file)
  steps = File.readlines(file).map(&:chomp).map { |step| step.split }
  nodes_hash = Hash.new { |h, k| h[k] = Node.new(k) }

  steps.each do |step|
    predecessor = nodes_hash[step[1]]
    successor = nodes_hash[step[7]]

    successor.add_predecessor(predecessor)
  end

  nodes = nodes_hash.values
  ready_nodes = nodes.select { |node| node.ready }
  nodes.reject! { |node| node.ready }

  order = []

  until ready_nodes.empty?
    ready_nodes = ready_nodes.sort_by { |node| node.letter }
    next_node = ready_nodes.shift

    order << next_node.letter
    next_node.successor_ids.each { |id| Node.get_node(id).remove_predecessor_id(next_node.id) }

    ready_nodes += nodes.select { |node| node.ready }
    nodes.reject! { |node| node.ready }
  end

  order.join
end

def time_to_completion(file)
  steps = File.readlines(file).map(&:chomp).map { |step| step.split }
  nodes_hash = Hash.new { |h, k| h[k] = Node.new(k) }
  letters = 'abcdefghijklmnopqrstuvwxyz'

  steps.each do |step|
    predecessor = nodes_hash[step[1]]
    successor = nodes_hash[step[7]]

    successor.add_predecessor(predecessor)
  end

  nodes = nodes_hash.values
  ready_nodes = nodes.select { |node| node.ready }
  nodes.reject! { |node| node.ready }

  order = []
  workers = Array.new(5, nil)
  seconds = 0

  until ready_nodes.empty? && workers.all?(&:nil?)
    ready_nodes = ready_nodes.sort_by { |node| node.letter } unless ready_nodes.empty?

    workers.each_with_index do |worker, idx|
      if !worker.nil? && worker[1].zero?
        next_node = worker[0]
        letter = next_node.letter
        order << letter
        next_node.successor_ids.each { |id| Node.get_node(id).remove_predecessor_id(next_node.id) }
        workers[idx] = nil
      end
    end

    ready_nodes += nodes.select { |node| node.ready }
    nodes.reject! { |node| node.ready }

    workers.each_with_index do |worker, idx|
      if worker.nil?
        next if ready_nodes.empty?
        next_node = ready_nodes.shift
        letter = next_node.letter
        workers[idx] = [next_node, 60 + letters.index(letter.downcase)]
      else
        worker[1] -= 1
      end
    end

    seconds += 1
  end

  seconds - 1
end

if __FILE__ == $PROGRAM_NAME
  puts order_steps("input.txt")
  puts time_to_completion("input.txt")
end
