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
    # Dup board and perform move
    # Call board.in_check?
  end

end

# Implement first
class SlidingPiece < Piece

  def move_dirs # diagonal, horizontal/vertical, both

  end

end

class Bishop < SlidingPiece
end
class Rook < SlidingPiece
end
class Queen < SlidingPiece
end

class SteppingPiece < Piece

end

# Implement this Last
class PawnPiece < Piece

end


class Board

  def self.setup_new_board

  end

  attr_accessor :matrix

  def initialize(dup = false)
    @matrix = Array.new(8) { Array.new(8) { nil } }
    self.setup_new_board unless dup
  end

  #Phase III - For duped board populated with _new_ copy pieces
  def populate_duped_pieces
  end

  def dup
    # dup_board = Board.new(true)
    #   populate_duped_pieces
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
