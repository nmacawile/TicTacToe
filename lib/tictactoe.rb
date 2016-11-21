require "./tictactoe/version"
require "colorize"

module Tictactoe
  

  class Cell
  	attr_accessor :value, :index

    def initialize(index)
    	@index = index
    	@value = nil
    end

    def mark(symbol)
    	if value.nil?
    		self.value = symbol
    	end
    end

    def to_s
    	value.nil? ? index.to_s.colorize(:light_black) : value.to_s
    end
  end

  class Board
  	@@first_turn = :player1
  	attr_accessor :players, :grid, :current_player

  	def initialize(player1, player2)
  		@grid = []
  		new_grid 
  		@players = [player1, player2]
  		@current_player = @@first_turn
  	end

  	def new_grid
  		grid.clear
  		add_to_grid = Proc.new { |num| grid << Cell.new(num) }
	  	
	  	(7..9).each(&add_to_grid)
	  	(4..6).each(&add_to_grid)
	  	(1..3).each(&add_to_grid)
	end

  	def play
  		loop do
	  		draw_board
	  		loop do
				player_turn
				draw_board
				break if game_over?
				switch_player
	  		end
	  		#@@first_turn = switch_player(@@first_turn)
	  		#current_player = @@first_turn
	  		show_scores
	  		new_grid
	  		print "Play again? (Type in 'Y' to play again): "
	  		play_again = gets.chomp.upcase
	  		break unless play_again == "Y"
  		end
  	end

  	def draw_board
  		h_separator = "+---+---+---+"
  		puts h_separator
  		grid.each_slice(3) do |a, b, c|
  			puts "| #{a} | #{b} | #{c} |"
  			puts h_separator
  		end
  	end

  	def player_turn
  		current_player_index = player_index[current_player]
  		turn = nil
  		loop do
	  		print "#{players[current_player_index].name}'s turn "\
	  		"(#{players[current_player_index].symbol}): "
	  		turn = gets.chomp.to_i
	  		break if turn.between?(1, 9) && grid[map(turn)].value.nil? 
	  		puts "Invalid move!"
  		end	
  		grid[map(turn)].mark(players[current_player_index].symbol)  		
  	end

  	def game_over?
  		draw? || winner?
  	end

  	def draw?
  		if grid.none? { |cell| cell.value.nil? }
  			puts "It's a draw."
  			true
  		else
  			false
  		end
  	end

  	def winner?
  		current_player_index = player_index[current_player]
  		winning_pattern = Proc.new { 
  			|cell| cell.value == players[current_player_index].symbol
  		}

  		if grid.values_at(0, 4, 8).all?(&winning_pattern) ||
  			grid.values_at(2, 4, 6).all?(&winning_pattern) ||
  			grid.values_at(0, 3, 6).all?(&winning_pattern) ||
  			grid.values_at(1, 4, 7).all?(&winning_pattern) ||
  			grid.values_at(2, 5, 8).all?(&winning_pattern) ||
  			grid[0..2].all?(&winning_pattern) ||
  			grid[3..5].all?(&winning_pattern) ||
  			grid[6..8].all?(&winning_pattern)
  			players[current_player_index].score += 1
 			puts "#{players[current_player_index].name} wins!"
  			true
  		else
  			false
  		end
  	end

  	def switch_player
  		case current_player
  		when :player1
  			self.current_player = :player2
  		when :player2
  			self.current_player = :player1
  		end
  	end

  	def show_scores
  		puts "Scores:"
  		players.each do |player| 
  			puts "#{player.name}: #{player.score}"
  		end
  	end

  	def player_index
  		index = {player1: 0, player2: 1}
  	end

  	def map(number)
  		if number >= 7
  			number -= 7
  		elsif number <= 3
  			number += 5
  		else
  			number -= 1
  		end
  	end
  end

  class Player
  	attr_accessor :name, :score, :symbol

  	def initialize(name, symbol)
  		@name = name  		
  		@symbol = symbol
  		@score = 0
  	end
  end
end