class Piece

  attr_reader :board, :color
  attr_accessor :position

  def initialize(board, position, color)
    @board, @position, @color = board, position, color
  end

  def moves # returns an array of possible move positions
  end

  # Phase III
  def move_into_check?(pos)
    # Dup board and perform move
    # Call board.in_check?
  end

  # Todo, make sure dup works for all subclasses
  def dup(new_board)
    self.class.New(new_board, self.position, self.color)
  end

  def valid_moves
    # selects possible_moves down to moves that
    # 1) don't result in check
    # 2) no piece blocking
    # 3) end_pos is empty
    # uses duped board to hypothetically execute move and evaluate
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @position[row][col]
  end

  def on_board?(pos)
    pos.all? { |i| i.between?(0,7) }
  end

end

# Implement first
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
        moves << new_pos if is_on_board
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

class SteppingPiece < Piece

  def move_step(directions)
    moves = []
    directions.each do |direction|
      new_pos = position
      new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
      moves << new_pos if on_board?(new_pos)
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
class PawnPiece < SteppingPiece

  # two possible ways of doing this, list possible moves in constant
  # and check with valid moves  OR
  # always check one move forward,
  #   then check if diagonal capture possible
  #   and allow move two from starting row.

  # STEP_MOVES = []

  def valid_moves
    # selects possible_moves down to moves that
    # 1) don't result in check
    # 2) can only move diagonally to capture
    # 3) can only move forward twice from its starting row
    # 4) no piece blocking
    # 5) end_pos is empty
    # uses duped board to hypothetically execute move and evaluate
  end

end


class Board

  def self.setup_new_board

  end

  attr_accessor :matrix

  def initialize(dup = false)
    @matrix = Array.new(8) { Array.new(8) { nil } }
    self.setup_new_board unless dup
  end

  #Phase III - For duped board populated with _new_ copy pieces
  def populate_duped_pieces
  end

  # TODO question if need here or can move all to Piece class
  def dup
    # dup_board = Board.new(true)
    #   populate_duped_pieces
  end

# PHASE II

  def in_check?(color)
    # 1 - find king position
    # 2 - see if any opponent pieces have king_pos in possible_moves
  end

  def move(start, end_pos)
    # Executes move only if Piece.valid_moves.includes? move
    # updates matrix
    # updates moved Piece's position
    # raise exception if a) no piece at start
    # =>                 b) piece can't move to end_pos (not in possible_moves)
  end

  # Phase IV
  def checkmate?(color)
    # checks each piece of color for valid moves, mate if none
  end

end

class Game

  def initialize(board = nil)
    if board.nil?
      @board = Board.new
    else
      @board = board
    end
  end

#
#   Write a Game class that constructs a Board object, that alternates between players (assume two human players for now) prompting them to move. The Game should handle exceptions from Board#move and report them.
#
# It is fine to write a HumanPlayer class with one method (#play_turn). In that case, Game#play method just continuously calls play_turn.
#
# It is not a requirement to write a ComputerPlayer, but you may do this as a bonus. If you write your Game class cleanly, it should be relatively straightforward to add new player types at a later date.

end
