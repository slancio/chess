require_relative 'piece'

class SteppingPiece < Piece

  def move_step(directions)
    moves = []
    directions.each do |direction|
      new_pos = position

      new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
      next unless on_board?(new_pos)

      if board[new_pos].nil?
        moves << new_pos
      else
        next if board[new_pos].color == color
        moves << new_pos
      end
    end

    moves
  end

  def moves
    move_step(self.class::STEP_MOVES)
  end
end

class King < SteppingPiece

  PICTOGRAPH = [" ♔ ", " ♚ "]

  STEP_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1],
                [1, 0], [-1, 0], [0, 1], [0, -1]]


end

class Knight < SteppingPiece

  PICTOGRAPH = [" ♘ ", " ♞ "]

  STEP_MOVES = [[-2, -1], [-2,  1], [-1, -2], [-1,  2],
                [ 1, -2], [ 1,  2], [ 2, -1], [ 2,  1]]

end
