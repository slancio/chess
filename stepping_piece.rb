class SteppingPiece < Piece

  def move_step(directions)
    moves = []
    directions.each do |direction|
      new_pos = position

      new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]

      if board[new_pos].nil?
        moves << new_pos if on_board?(new_pos)
      else
        next if board[new_pos].color == color
        moves << new_pos if on_board?(new_pos)
      end
    end

    moves
  end

  def moves
    move_step(self.class::STEP_MOVES)
  end
end

class King < SteppingPiece
  STEP_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1],
                [1, 0], [-1, 0], [0, 1], [0, -1]]


end

class Knight < SteppingPiece
  STEP_MOVES = [[-2, -1], [-2,  1], [-1, -2], [-1,  2],
                [ 1, -2], [ 1,  2], [ 2, -1], [ 2,  1]]

end

# Implement this Last
class Pawn < SteppingPiece

  # two possible ways of doing this, list possible moves in constant
  # and check with valid moves  OR
  # always check one move forward,
  #   then check if diagonal capture possible
  #   and allow move two from starting row.

  STEP_MOVES = [[0, 0]]

  def valid_moves
    moves
    # selects possible_moves down to moves that
    # 1) don't result in check
    # 2) can only move diagonally to capture
    # 3) can only move forward twice from its starting row
    # 4) no piece blocking
    # 5) end_pos is empty
    # uses duped board to hypothetically execute move and evaluate
  end

end
