require 'pry-byebug'

# making board
class Board
  attr_reader :player1, :player2, :p1_sign, :p2_sign, :num , :winner_positions

  def initialize
    @num = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winner_positions = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]
    @player1_winner = false
    @player2_winner = false
  end

  def ask_player_name
    puts 'please enter player 1 name'
    @player1 = gets.chomp
    puts "player 1 name is #{player1}"
    puts 'please enter player 2 name'
    @player2 = gets.chomp
    puts "player 2 name is #{player2}"
  end

  def ask_player_sign
    puts 'enter player 1 sign'
    @p1_sign = gets.upcase
    # @p1_sign = gets.upcase while @p1_sign.size != 1 tried to limit input to char
    puts "p1 sign is #{p1_sign}"
    puts 'enter player 2 sign'
    @p2_sign = gets.upcase
    # @p2_sign = gets.upcase while @p2_sign.size != 1
    puts "p2 sign is #{p2_sign}"
  end

  def check_winner?(arr, player_sign ,count)
    true if arr[winner_positions[count][0] - 1] == arr[winner_positions[count][1] - 1] && arr[winner_positions[count][1] - 1] == arr[winner_positions[count][2] - 1] # && arr[winner_positions[count][0]] == arr[winner_positions[count][2]]
  end

  def winner?(player)
    i = 0
    result = false

    while i < winner_positions.size
      result = true if self.check_winner?(num, player, i) # add breack so its stop 
      break if result

      i += 1
    end
    result
  end

  def show_board
    puts  " #{num[0]} | #{num[1]} | #{num[2]} "
    puts  '---+---+---'
    puts  " #{num[3]} | #{num[4]} | #{num[5]} "
    puts  '---+---+---'
    puts  " #{num[6]} | #{num[7]} | #{num[8]} "
  end

  def update(index, player_sign)
    x = index.to_i - 1
    num[x] = player_sign.chomp
  end

  def p1_turn
    puts "its #{player1} turn "
    i = gets.chomp
    self.update(i, p1_sign)
    self.show_board
    if self.winner?(p1_sign)
      @player1_winner = true
      puts "#{player1} is winner"
    end
  end

  def p2_turn
    puts "its #{player2} turn "
    i = gets.chomp
    self.update(i,p2_sign)
    self.show_board
    if self.winner?(p2_sign)
      @player2_winner = true
      puts "#{player2} is winner"
    end
  end

  def play_game
    for i in 1..9 do 
      break if @player1_winner || @player2_winner

      self.p1_turn if i.odd?
      self.p2_turn if i.even?
    end
    puts game_over
  end

  def start
    self.show_board
    self.ask_player_name
    self.ask_player_sign
    self.play_game
  end

  def game_over
    "Game Over #{player1} , its draw no one won :("
  end
end

game = Board.new

game.start

