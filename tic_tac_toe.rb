# frozen_string_literal: true

# Creates new player objects to play tic-tac-toe
class Player
  attr_reader :name, :token

  @@players = []
  @@tokens = []

  def self.all_players
    @@players
  end

  def self.all_tokens
    @@tokens
  end
  
  def initialize
    puts "Player name? \n"
    @name = gets
    @token = set_token
    @@players << self
    @@tokens << @token
    puts `clear`
  end

  def set_token
    puts "Choose a token:\n"
    token = gets.split[0]
    if Player.all_tokens.include? token
      puts "That token is already used!\n"
      set_token
    else
      token
    end
  end
end

# Creates new game object to run a tic-tac-toe game
class Game
  def initialize
    @data = {}
    @spots = {} # Spots == true when position is untaken
    @end_of_game = false
    (1..9).each do |i|
      @data[i] = i.to_s
      @spots[i] = true
    end
    update_display
  end

  # Runs turns back and forth until a victory condition is identified
  def run_game(player1, player2)
    update_display
    until @end_of_game
      move(player1)
      @end_of_game ? 'End of Game!' : move(player2)
    end
    game_over
  end

  def move(player)
    puts "#{player.name} choose a spot. \n"
    @pos = gets.to_i
    @current_player = player
    if @spots[@pos]
      @data[@pos] = player.token
      @spots[@pos] = false
    else
      spot_taken_error(player)
    end
    update_display
    victory_check
  end

  def update_display
    puts `clear`
    puts "  #{@data[1]} | #{@data[2]} | #{@data[3]} \n ---+---+--- \n\
  #{@data[4]} | #{@data[5]} | #{@data[6]} \n ---+---+--- \n\
  #{@data[7]} | #{@data[8]} | #{@data[9]} \n"
  end

  def spot_taken_error(player)
    puts `clear`
    puts "That spot is already used! \n"
    move(player)
  end

  def victory_check
    horizontal_win_check
    vertical_win_check
    diagonal_win_check
    no_winner_check
  end

  def horizontal_win_check
    i = 1
    3.times do
      if @data[i] == @data[i + 1] && @data[i] == @data[i + 2]
        @end_of_game = true
        @winner = @current_player
        game_over
      end
      i += 3
    end
  end

  def vertical_win_check
    i = 1
    3.times do
      if @data[i] == @data[i + 3] && @data[i] == @data[i + 6]
        @end_of_game = true
        @winner = @current_player
        game_over
      end
      i += 1
    end
  end

  def diagonal_win_check
    if @data[1] == @data[5] && @data[1] == @data[9] || \
       @data[3] == @data[5] && @data[3] == @data[7]
      @end_of_game = true
      @winner = @current_player
      game_over
    end
  end

  def no_winner_check
    game_over unless @spots.value? true == false
  end

  def game_over
    if @winner.nil?
      puts "It's a draw!\n"
    else
      puts "#{@winner.name} won the game!\n"
    end
    puts "Play again? (y/n)\n"
    ans = gets.chr
    if %w[y Y].include?(ans)
      game = Game.new
      game.run_game(Player.new, Player.new)
    elsif %w[n N].include?(ans)
      puts 'Thanks for playing!\n'
      exit
    end
  end
end

p1 = Player.new
p2 = Player.new
game = Game.new
game.run_game(p1, p2)
