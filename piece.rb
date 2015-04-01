class Piece

  attr_reader :board, :color
  attr_accessor :position

  def initialize(board, position, color)
    @board, @position, @color = board, position, color
  end

  def moves # returns an array of possible move positions
  end

  # Phase III
  def move_into_check?(pos)
    # new_board = board.dup
    # Dup board and perform move
    # Call board.in_check?
  end

  # Todo, make sure dup works for all subclasses
  def dup(new_board)
    self.class.New(new_board, self.position, self.color)
  end

  def valid_moves
    raise NotImplementedError
    # selects possible_moves down to moves that
    # 1) don't result in check
    # 2) no piece blocking
    # 3) end_pos is empty
    # uses duped board to hypothetically execute move and evaluate
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @position[row][col]
  end

  def on_board?(pos)
    pos.all? { |i| i.between?(0,7) }
  end

  def inspect
    { :position => position,
      :color => color,
      :piece => self.class,
      :obj_id => self.object_id.to_s[-5..-1] }.inspect
  end

end
