require_relative 'piece.rb'

class SlidingPiece < Piece

  DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  HORIZONTAL = [[1, 0], [-1, 0]]
  VERTICAL = [[0, 1], [0, -1]]

  def moves
    possible_moves = []
    possible_moves += move_vector(DIAGONAL) if move_dirs.include?(:diagonal)
    possible_moves += move_vector(HORIZONTAL) if move_dirs.include?(:horizontal)
    possible_moves += move_vector(VERTICAL) if move_dirs.include?(:vertical)
    possible_moves
  end

  def move_vector(directions)
    moves = []
    directions.each do |direction|
      new_pos = position
      is_on_board = true

      while is_on_board
        new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
        is_on_board = on_board?(new_pos)

        if board[new_pos].nil?
          moves << new_pos if is_on_board
        else
          break if board[new_pos].color == color
          moves << new_pos if is_on_board
          break
        end

      end
    end

    moves
  end

end

# Can override superclass methods
# def dup(new_board)
#   self.class.New(new_board, self.position, self.color, ...)
# end
class Bishop < SlidingPiece

  def move_dirs
    [:diagonal]
  end

  def valid_moves
    blocked_moves = []
    moves.select do |move|
      unless board[move].nil? && !move_into_check(move)
        blocked_moves << move unless board[move].nil?
      end
    end
    # selects possible_moves down to moves that
    # 1) don't result in check
    # 2) no piece blocking
    # 3) end_pos is empty
    # uses duped board to hypothetically execute move and evaluate

  end


end

class Rook < SlidingPiece

  def move_dirs
    [:horizontal, :vertical]
  end

end

class Queen < SlidingPiece

  def move_dirs
    [:diagonal, :horizontal, :vertical]
  end

end
