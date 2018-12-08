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

end

if __FILE__ == $PROGRAM_NAME
  puts order_steps("input.txt")
end
