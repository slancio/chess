require_relative 'piece'

class Pawn < Piece

  def moves
    i, row = self.color == :b ? [1, 1] : [-1, 6]

    new_moves = []
    fwd_pos = [position[0] + i, position[1]]
    new_moves << fwd_pos if on_board?(fwd_pos) && board[fwd_pos].nil?
    new_moves << [position[0] + 2 * i, position[1]] if position[0] == row

    [-1, 1].each do |j|
      diag_pos = [position[0] + i, position[1] + j]
      new_moves << diag_pos if on_board?(diag_pos) && !board[diag_pos].nil?
    end

    new_moves
  end

end
