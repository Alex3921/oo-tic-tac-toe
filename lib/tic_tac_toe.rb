require 'pry'
class TicTacToe
    attr_accessor :board

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
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
        @board.all? {(0..@board.length-1).include?(position) && @board[position].include?(" ")}
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Please choose your next position.(1-9)!"
        position = gets.chomp
        index_pos = nil
        while true
            index_pos = self.input_to_index(position)
            if self.valid_move?(index_pos)
                break
            else
                position = gets.chomp
            end
        end

        player = self.current_player
        self.move(index_pos, player)
        self.display_board
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
        while !self.won? && !self.full?
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}"
        elsif self.draw?
            puts "The game ended in a draw. Better luck next time!"
        end
    end

end

