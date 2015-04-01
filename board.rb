require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'

class Board

  attr_accessor :matrix

  def initialize(dup = false)
    @matrix = Array.new(8) { Array.new(8) { nil } }
    setup_new_board unless dup
  end

  def setup_new_board
    (0..7).each do |index|
      self[[1, index]] = Pawn.new(self, [1, index], :b)
      self[[6, index]] = Pawn.new(self, [6, index], :w)
    end

    self[[0, 0]] = Rook.new(self, [0, 0], :b)
    self[[0, 7]] = Rook.new(self, [0, 7], :b)
    self[[0, 1]] = Knight.new(self, [0, 1], :b)
    self[[0, 6]] = Knight.new(self, [0, 6], :b)
    self[[0, 2]] = Bishop.new(self, [0, 2], :b)
    self[[0, 5]] = Bishop.new(self, [0, 5], :b)
    self[[0, 3]] = Queen.new(self, [0, 3], :b)
    self[[0, 4]] = King.new(self, [0, 4], :b)

    self[[7, 0]] = Rook.new(self, [7, 0], :w)
    self[[7, 7]] = Rook.new(self, [7, 7], :w)
    self[[7, 1]] = Knight.new(self, [7, 1], :w)
    self[[7, 6]] = Knight.new(self, [7, 6], :w)
    self[[7, 2]] = Bishop.new(self, [7, 2], :w)
    self[[7, 5]] = Bishop.new(self, [7, 5], :w)
    self[[7, 3]] = Queen.new(self, [7, 3], :w)
    self[[7, 4]] = King.new(self, [7, 4], :w)

  end

  def move(start, end_pos)
    piece = self[start]

    if piece.nil?
      raise ArgumentError.new "No piece at start position."
    elsif piece.valid_moves.include?(end_pos)
      god_move(start, end_pos)
    else
      raise ArgumentError.new "Not a valid move."
    end
  end

  def god_move(start, end_pos)

    piece = self[start]
    self[end_pos] = piece
    self[start] = nil
    piece.position = end_pos
  end

  def in_check?(color)

    color_king = pieces_of(color).find { |piece| piece.is_a?(King) }
    king_pos = color_king.position

    pieces_of(toggle_color(color)).each do |piece|
      return true if piece.moves.include?(king_pos)
    end

    false
  end

  def checkmate?(color)
    if in_check?(color)
      self.pieces_of(color).each do |piece|
        return false if !piece.valid_moves.empty?
      end
      return true
    end
    false
  end

  def pieces_of(color)
    matrix.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def toggle_color(color)
    color == :w ? :b : :w
  end

  def dup
    dup_board = Board.new(true)

    0.upto(7) do |row|
      0.upto(7) do |col|
        pos = [row, col]
        piece = self[pos]
        unless piece.nil?
          dup_board[pos] = piece.class.new(dup_board, pos, piece.color)
        end
      end
    end

    dup_board
  end

  def display
    puts render
  end

  def render
    matrix_str = "    a  b  c  d  e  f  g  h\n"
    (0..7).each do |row|
      line_str = " #{8 - row} "
      (0..7).each do |col|
        place = self[[row, col]]
        bg_color = ((row + col) % 2 == 0) ? :light_white : :white
        if place.nil?
          line_str += "   ".colorize(:background => bg_color)
        else
          line_str += place.render.colorize(:color => :black, :background => bg_color)
        end
      end
      line_str += " #{8 - row}\n"
      matrix_str += line_str
    end
    matrix_str + "    a  b  c  d  e  f  g  h\n"
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @matrix[row][col]
  end

  def []=(pos, piece)
    row, col = pos[0], pos[1]
    @matrix[row][col] = piece
  end

end
