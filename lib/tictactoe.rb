require "./tictactoe/version"

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
    	else
    		puts "Illegal move!"
    	end
    end

    def to_s
    	value.nil? ? index.to_s : value.to_s
    end
  end

  class Board
  	attr_accessor :players, :grid

  	def initialize(player1, player2)
  		@grid = []
  		new_grid 
  		@players = [player1, player2]
  	end

  	def new_grid
  		add_to_grid = Proc.new { |num| grid << Cell.new(num) }
	  	
	  	(7..9).each(&add_to_grid)
	  	(4..6).each(&add_to_grid)
	  	(1..3).each(&add_to_grid)
	end

  	def play
  		draw_board
  		grid[5].mark("F")
  		draw_board
  		grid[5].mark("G")
  		draw_board
  	end

  	def draw_board
  		h_separator = "+---+---+---+"
  		puts h_separator
  		grid.each_slice(3) do |a, b, c|
  			puts "| #{a} | #{b} | #{c} |"
  			puts h_separator
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