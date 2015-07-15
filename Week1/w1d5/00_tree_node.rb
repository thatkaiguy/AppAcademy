class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    return if self.parent == node
    self.parent.children.delete(self) unless self.parent.nil?
    @parent = node
    node.children << self if node && !node.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "No such children" unless self.children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      return_node = child.dfs(target_value)
      return return_node if return_node
    end
    nil
  end

  def bfs(target_value)
    return self if self.value == target_value

    queue = self.children.dup

    until queue.empty?
      current_node = queue.shift
      if current_node.value == target_value
        return current_node
      end
      queue.concat(current_node.children)
    end
    nil
  end

end
