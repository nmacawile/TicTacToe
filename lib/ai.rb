require "./helper"
require "./tictactoe"

module Tictactoe
	class Board
		def ai_turn	
			
			
			#puts go_for_win.inspect+"w" unless go_for_win.empty?
			#puts go_for_win.collect { |a| map(a) }.inspect+"wi" unless go_for_win.empty?
			return go_for_win.sample unless go_for_win.empty?
			
			#puts avoid_loss.inspect+"d" unless avoid_loss.empty?
			#puts avoid_loss.collect { |a| map(a) }.inspect+"di" unless avoid_loss.empty?
			return avoid_loss.sample unless avoid_loss.empty?
			
			#puts setup_for_win.inspect+"s" unless setup_for_win.empty?
			#puts setup_for_win.collect { |a| map(a) }.inspect+"si" unless setup_for_win.empty?
			return setup_for_win.sample unless setup_for_win.empty?
			
			return empty_cells.sample unless empty_cells.empty?

			
			#rand(0..8)
		end

		def go_for_win
			current_player_index = player_index[current_player]
			moves = []
			PATTERNS.each do |pattern|
				if pattern.has_exactly?(2) { |n| grid[n].value == players[current_player_index].symbol }
					cell = pattern.find { |m| grid[m].empty? }
					moves << cell unless cell.nil?
				end
			end
			moves
		end

		def avoid_loss
			current_player_index = player_index[current_player]
			moves = []
			PATTERNS.each do |pattern|
				if pattern.has_exactly?(2) { |n| grid[n].value != players[current_player_index].symbol && !grid[n].empty? }
					cell = pattern.find { |m| grid[m].empty? }
					moves << cell unless cell.nil?
				end
			end
			moves
		end

		def setup_for_win
			current_player_index = player_index[current_player]
			moves = []
			PATTERNS.each do |pattern|
				if pattern.any? { |n| grid[n].value == players[current_player_index].symbol }
					moves.concat(pattern.find_all { |m| grid[m].empty? })
				end
			end
			moves
		end

		def empty_cells
			current_player_index = player_index[current_player]
			moves = []

			grid.each_with_index { |cell, index| moves << index if cell.empty?  }

			moves
		end
	end
end