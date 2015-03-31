require_relative 'piece'

class Board

  attr_accessor :matrix

  def initialize(dup = false)
    @matrix = Array.new(8) { Array.new(8) { nil } }
    setup_new_board unless dup
  end

  #Phase III - For duped board populated with _new_ copy pieces
  def setup_new_board
    (0..7).each do |index|
      @matrix[1, index] = Pawn.new(self, [1, index], :b)
      @matrix[6, index] = Pawn.new(self, [6, index], :w)
    end

    @matrix[0, 0] = Rook.new(self, [0, 0], :b)
    @matrix[0, 7] = Rook.new(self, [0, 7], :b)
    @matrix[0, 1] = Knight.new(self, [0, 1], :b)
    @matrix[0, 6] = Knight.new(self, [0, 6], :b)
    @matrix[0, 2] = Bishop.new(self, [0, 2], :b)
    @matrix[0, 5] = Bishop.new(self, [0, 5], :b)
    @matrix[0, 3] = Queen.new(self, [0, 3], :b)
    @matrix[0, 4] = King.new(self, [0, 4], :b)

    @matrix[7, 0] = Rook.new(self, [7, 0], :w)
    @matrix[7, 7] = Rook.new(self, [7, 7], :w)
    @matrix[7, 1] = Knight.new(self, [7, 1], :w)
    @matrix[7, 6] = Knight.new(self, [7, 6], :w)
    @matrix[7, 2] = Bishop.new(self, [7, 2], :w)
    @matrix[7, 5] = Bishop.new(self, [7, 5], :w)
    @matrix[7, 3] = Queen.new(self, [7, 3], :w)
    @matrix[7, 4] = King.new(self, [7, 4], :w)

    # (0..7).each do |index|
    #   idx2 = 7 - index
    #   case index
    #   when 0
    #     @matrix[0, index] = Rook.new(self, [0, index], :w)
    #     @matrix[0, idx2] = Rook.new(self, [0, idx2], :w)

  end

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
    color_king = pieces_of(color).select { |piece| piece.is_a?(King) }

    king_pos = color_king[0].position

    pieces_of(toggle_color(color)).each do |piece|
      return true if piece.valid_moves.include?(king_pos)
    end

    false
  end

  def move(start, end_pos)
    # Executes move only if Piece.valid_moves.includes? move
    # updates matrix - DOING NOW
    # updates moved Piece's position - DOING NOW
    # raise exception if a) no piece at start
    # =>                 b) piece can't move to end_pos (not in possible_moves)

    # start_pos = @matrix[start].position
    # start_pos = [start[0], start[1]]
    piece = matrix[start[0], start[1]]
    matrix[end_pos[0], end_pos[1]] = piece
    matrix[start[0], start[1]] = nil
    piece.position = end_pos
  end

  # Phase IV
  def checkmate?(color)
    # checks each piece of color for valid moves, mate if none
  end

  def pieces_of(color)
    matrix.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def toggle_color(color)
    color == :w ? :b : :w
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @matrix[row][col]
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
