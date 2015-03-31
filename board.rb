class Board

  def self.setup_new_board

  end

  attr_accessor :matrix

  def initialize(matrix = nil)
    # TODO check this works for duping the board
    if matrix.nil?
      @matrix = Array.new(8) { Array.new(8) { nil } }
      self.setup_new_board
    else
      @matrix = matrix
    end
  end

# PHASE II

  def in_check?(color)
    # 1 - find king position
    # 2 - see if any opponent pieces have king_pos in possible_moves
  end

  def move(start, end_pos)
    # updates matrix
    # updates moved Piece's position
    # raise exception if a) no piece at start
    # =>                 b) piece can't move to end_pos (not in possible_moves)
  end

end
