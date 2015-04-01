require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require_relative 'board'
require 'colorize'

class Game

  attr_reader :board, :white, :black

  def initialize( board = Board.new,
                  white = HumanPlayer.new(:w),
                  black = HumanPlayer.new(:b) )

    @board, @white, @black = board, white, black

  end

  def play

    turn_order = [white, black]
    loop do
      turn_order.first.play_turn(board)
      turn_order.rotate
    end

  end

#
#   Write a Game class that constructs a Board object, that alternates between players (assume two human players for now) prompting them to move. The Game should handle exceptions from Board#move and report them.
#
# It is fine to write a HumanPlayer class with one method (#play_turn). In that case, Game#play method just continuously calls play_turn.
#
# It is not a requirement to write a ComputerPlayer, but you may do this as a bonus. If you write your Game class cleanly, it should be relatively straightforward to add new player types at a later date.

end
