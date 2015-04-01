require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require_relative 'board'
require_relative 'player'

require 'colorize'

class Game

  attr_reader :board, :white, :black

  def initialize( board = Board.new,
                  white = HumanPlayer.new(board, :white),
                  black = HumanPlayer.new(board, :black) )

    @board, @white, @black = board, white, black
  end

  def play

    end_str = ""
    turn_order = [white, black]
    loop do
      turn_order.first.play_turn
      if board.checkmate?(:b)
        end_str = " White has checkmated Black!"
        break
      elsif board.checkmate?(:w)
        end_str = " Black has checkmated White!"
        break
      end
      turn_order.rotate!
    end

    # TODO let move only the color's turn
    board.display
    puts end_str
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
