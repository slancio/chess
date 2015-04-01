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

  # STEP_MOVES = [[1, 0], [1, 1], [1, -1]]
  #
  # def moves
  #   if color == :b
  #     move_step(self.class::STEP_MOVES)
  #   else
  #     white_moves = STEP_MOVES
  #     white_moves.map {:&first}
  # end
  #
  # def move_step(directions)
  #   moves = []
  #
  #   directions.each do |direction|
  #     new_pos = position
  #     if self.color == :b
  #       new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
  #     else
  #       new_pos = [new_pos[0] - direction[0], new_pos[1] + direction[1]]
  #     end
  #     next unless on_board?(new_pos)
  #
  #     if board[new_pos].nil?
  #       moves << new_pos if (direction[1] == 0)
  #     else
  #       next if board[new_pos].color == color
  #       moves << new_pos
  #     end
  #   end
  #
  #   moves
  # end

  def moves
    i, row = self.color == :b ? [1, 1] : [-1, 6]

    new_pos, new_moves = [], []
    forward_pos = [position[0] + i, position[1]]
    new_pos << forward_pos if on_board?(forward_pos)
    new_moves += new_pos if board[new_pos[0]].nil?

    new_moves << [position[0] + 2 * i, position[1]] if position[0] == row

    capture_pos = []
    left_pos = [position[0] + i, position[1] - 1]
    right_pos = [position[0] + i, position[1] + 1]
    capture_pos << left_pos if on_board?(left_pos)
    capture_pos << right_pos if on_board?(right_pos)

    capture_pos.each do |pos|
      new_moves << pos unless board[pos].nil?
    end

    new_moves
  end
    # selects possible_moves down to moves that
    # 1) don't result in check

    # 2) can only move diagonally to capture
    # 3) can only move forward twice from its starting row

    # 4) no piece blocking
    # 5) end_pos is empty
    # uses duped board to hypothetically execute move and evaluate

  def valid_moves
    [].tap do |valid_pos|
      moves.select do |move|
        valid_pos << move unless move_into_check?(move)
      end
    end
  end

end
