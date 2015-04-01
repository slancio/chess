require_relative 'piece'
require 'byebug'

class SlidingPiece < Piece

  DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  HORIZONTAL = [[1, 0], [-1, 0]]
  VERTICAL = [[0, 1], [0, -1]]

  def moves
    move_list = []
    move_list += vector(DIAGONAL) if move_dirs.include?(:diagonal)
    move_list += vector(HORIZONTAL) if move_dirs.include?(:horizontal)
    move_list += vector(VERTICAL) if move_dirs.include?(:vertical)
    move_list
  end

  def vector(directions)
    moves = []
    directions.each do |direction|
      new_pos = position

      loop do
        new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
        break unless on_board?(new_pos)

        if board[new_pos].nil?
          moves << new_pos
        else
          break if board[new_pos].color == color
          moves << new_pos
          break
        end
      end
    end

    moves
  end

end

class Bishop < SlidingPiece

  PICTOGRAPH = [" ♗ ", " ♝ "]

  def move_dirs
    [:diagonal]
  end

end

class Rook < SlidingPiece

  PICTOGRAPH = [" ♖ ", " ♜ "]

  def move_dirs
    [:horizontal, :vertical]
  end

end

class Queen < SlidingPiece

  PICTOGRAPH = [" ♕ ", " ♛ "]

  def move_dirs
    [:diagonal, :horizontal, :vertical]
  end

end
