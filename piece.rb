class Piece

  attr_reader :board, :color
  attr_accessor :position

  def initialize(board, position, color)
    @board, @position, @color = board, position, color
  end

  def moves # returns an array of possible move positions

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
