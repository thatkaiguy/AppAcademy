require_relative '00_tree_node'

class KnightPathFinder
  attr_accessor :start_node

  def initialize(start_pos)
    @start_node = PolyTreeNode.new(start_pos)
    @visited_positions = [start_pos]
    @move_tree = self.build_move_tree_bf(@start_node)
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, val)
    @grid[row][col] = val
  end

  def find_path(end_pos)
    @target_node = @move_tree.dfs(end_pos)
  end

  def trace_path_back
    node = @target_node
    path = []

    until node.parent.nil?
      path << node.value
      node = node.parent
    end

    path
  end

  def build_move_tree(start_node)
    queue = new_move_positions(start_node.value)
    parent_node = start_node

    queue.each do |pos|
      child_node = PolyTreeNode.new(pos)
      child_node.parent = parent_node
      build_move_tree(child_node)
    end
    @start_node
  end

  def build_move_tree_bf(start_node)
    queue = new_move_positions(start_node.value).map {|pos| PolyTreeNode.new(pos)}

    parent_node = start_node
    queue.each { |node| node.parent = parent_node }
    until queue.empty?
      current_node = queue.shift
      new_nodes = new_move_positions(current_node.value).map { |pos| PolyTreeNode.new(pos)}
      new_nodes.each { |node| node.parent = current_node}
      queue.concat(new_nodes)
    end
    @start_node
  end

    #
    # until queue.empty?
    #
    #   current_pos = queue.shift
    #
    #   move = PolyTreeNode.new(current_pos)
    #
    #   move.parent=(parent_node)
    #

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos) - @visited_positions
    @visited_positions.concat(possible_moves)
    possible_moves
  end

  def self.valid_moves(start_pos)
    possible_moves = []

    row, column = start_pos
    distance = [1,2,2,1]
    height = [2,1,-1,-2]

    x_coords = []
    y_coords = []

    distance.each do |x|
      x_coords << x + row
    end
    height.each do |y|
      y_coords << y + column
    end
    distance.each do |x|
      x_coords << row - x
    end
    height.each do |y|
      y_coords << y + column
    end

    x_coords.each_with_index do |x, idx|
      y = y_coords[idx]
      possible_moves << [x, y] if x >= 0 && x <= 7 && y >= 0 && y <= 7
    end

    possible_moves

  end

end
