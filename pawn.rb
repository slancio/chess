require_relative 'piece'

class Pawn < Piece

  PICTOGRAPH = [" ♙ ", " ♟ "]

  def moves
    i, row = self.color == :b ? [1, 1] : [-1, 6]

    new_moves = []
    fwd_pos = [position[0] + i, position[1]]
    new_moves << fwd_pos if on_board?(fwd_pos) && board[fwd_pos].nil?
    two_fwd_pos = [position[0] + 2 * i, position[1]]
    new_moves << two_fwd_pos if position[0] == row && board[two_fwd_pos].nil?

    [-1, 1].each do |j|
      diag_pos = [position[0] + i, position[1] + j]
      new_moves << diag_pos if on_board?(diag_pos) && !board[diag_pos].nil?
    end

    new_moves
  end

end
