require 'pry'
class TicTacToe

    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
        ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end 

    def input_to_index(player_choice)
        player_choice.to_i - 1      
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        !@board[index].include?(" ")
    end

    def valid_move?(position)
        @board.all? {(0..@board.length-1).include?(position) && !position_taken?(position)}
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please choose your next position between 1-9:"
        user_input = gets.strip
        index_pos = input_to_index(user_input)
        if valid_move?(index_pos)
            move(index_pos, current_player)
            display_board
        else
            self.turn
        end
    end

    def won?
        winner = []
        WIN_COMBINATIONS.each do |combination|
            while winner.length < combination.length
                combination.each do |index|
                    winner << @board[index]
                end
            end

            if winner.all?{|val| val == "X"} or winner.all?{|val| val == "O"}
                return combination
            else
                winner.clear
                next
            end
        end
        !winner == []
    end

    def full?
        !@board.include?(" ")
    end

    def draw?
        if self.won?
            false
        elsif self.full?
            true
        else
            false
        end
    end

    def over?
        self.draw? || self.won?
    end

    def winner
        if self.won?
            @board[self.won?[0]]
        end
    end

    def play
        while !over?
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        end
    end
end

