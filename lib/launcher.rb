require "./tictactoe"
require "colorize"

print "Player 1, please enter your name: "
player1 = Tictactoe::Player.new(gets.chomp.colorize(:red), "X".colorize(:red))
print "Player 2, please enter your name: "
player2 = Tictactoe::Player.new(gets.chomp.colorize(:blue), "O".colorize(:blue))

game = Tictactoe::Board.new(player1, player2)
game.play