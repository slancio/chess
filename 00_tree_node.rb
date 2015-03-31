class PolyTreeNode

  attr_accessor :children, :parent
  attr_reader :value

  def initialize(value)
    @parent = parent
    @children = []
    @value = value
  end


  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    unless node.parent == self
      raise ArgumentError.new "Child does not have this Parent."
    end
    node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      if node.value == target_value
        return node
      else
        queue.concat(node.children)
      end
    end

    nil
  end

  def trace_path_back
    return [self.value] if self.parent.nil?

    prev_positions = @parent.trace_path_back
    prev_positions.concat([self.value])

  end

  def parent=(node = nil)
    self.parent.children.delete self unless self.parent.nil?
    @parent = node

    unless node.nil? || node.children.include?(self)
      node.children << self
    end

  end

end
