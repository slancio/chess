class Player

end

class HumanPlayer < Player

  attr_reader :board, :color

  def initialize(board, color)
    @board, @color = board, color
  end

  def play_turn
    render_turn
    move = get_input
    board.move(move[0], move[1])
    # get input for move
    # board.move
    # handle/rescue exceptions if any (retry)
  end

  def get_input
    puts "Enter your move (i.e., e2e4):"
    input = gets.chomp
    # TODO finish check input
    raise ArgumentError.new "Please enter a valid move." if input.length > 4
    start_pos = convert_pos(input[0..1])
    end_pos = convert_pos(input[2..3])
    [start_pos, end_pos]
  end

  def convert_pos(str)
    row = 8 - str[1].to_i
    col = "abcdefgh".index(str[0])
    [row, col]
  end

  def render_turn
    board.display
    puts "#{color.to_s.capitalize}, it is your turn!"
  end

end
