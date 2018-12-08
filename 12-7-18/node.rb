require 'byebug'
require 'securerandom'

class Node
  attr_reader :predecessor_ids, :successor_ids, :letter, :id

  @@nodes = {}

  def self.get_node(id)
    @@nodes[id]
  end

  def initialize(letter)
    @letter = letter
    @predecessor_ids = []
    @successor_ids = []
    @id = SecureRandom.urlsafe_base64

    until Node.get_node(@id).nil?
      @id = SecureRandom.urlsafe_base64
    end

    @@nodes[id] = self
  end

  def add_predecessor(predecessor)
    predecessor_ids << predecessor.id
    predecessor.add_successor(self)
  end

  def remove_predecessor_id(predecessor_id)
    predecessor_ids.delete(predecessor_id)
  end

  def add_successor(successor)
    successor_ids << successor.id
  end

  def ready
    predecessor_ids.empty?
  end
end
