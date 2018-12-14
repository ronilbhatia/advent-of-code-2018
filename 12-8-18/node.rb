require 'securerandom'

class Node
  @@nodes = {}

  def self.get_node(id)
    @@nodes[id]
  end

  def initialize()

  end
end
