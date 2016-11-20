require './tictactoe'

print "Player 1, please enter your name: "
player1 = Tictactoe::Player.new(gets.chomp, "X")
print "Player 2, please enter your name: "
player2 = Tictactoe::Player.new(gets.chomp, "O")

game = Tictactoe::Board.new(player1, player2)
game.play

include Tictactoe
puts first_turn