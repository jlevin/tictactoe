include Enumerable

# initialize empty board, set current player as X, and start game
$board = Array.new(3) {Array.new(3, " ")}
current_player = "X"
$game = true

def print_board(board_array)
    rows = 0
    print "\n  A   B   C \n"
    board_array.each do |x|
        columns = 0
        print (rows +1)
        x.each do |i|
            print " " + i.to_s + " "
            print "|" if columns != 2
            columns += 1
        end
        if rows != 2 then print "\n --- --- ---\n" else print "\n" end
        rows +=1
    end
    print "\n"
end

def make_a_move(player)
    puts "Make your move player " + player + ".\nEx: a2, c1.\n\n"
    move = gets.chomp

    # quit game if user enters "quit"
    if move.downcase == "quit"
        $game = false
    else
            # check if move is valid
        while move.length != 2 || $board[move[1].to_i - 1][((move[0].downcase.ord) - 97)] != " "
            puts "Invalid move, try again. Ex: A1"
            move = gets.chomp
        end

        # record move in $board
        $board[move[1].to_i - 1][(move[0].downcase.ord - 97)] = player
    end
end

while $game == true do
    # print current game board and make a move
    print_board($board)
    make_a_move(current_player)

    # check for vertical or horizontal wins
    0.upto(2) do |i|
        if $board[i][0] == current_player && $board[i][0] == $board[i][1] && $board[i][1] == $board[i][2] ||
            $board[0][i] == current_player && $board[0][i] == $board[1][i] && $board[1][i] == $board[2][i]
            print_board($board)
            puts "YOU WIN, PLAYER " + current_player + "!\n\n"
            $game = false
        end
    end
    # check for diagonal wins
    if $board[0][0] == current_player && $board[0][0] == $board[1][1] && $board[1][1] == $board[2][2] ||
        $board[0][2] == current_player && $board[0][2] == $board[1][1] && $board[1][1] == $board[2][0]
        print_board($board)
        puts "YOU WIN, PLAYER " + current_player + "!\n\n"
        $game = false
    end

    # check for a full board / tie
    if ($board.all? { |i| i.all? { |x| x != " "}} == true)
        print_board($board)    
        puts "A TIE (no more moves)!\n\n"
        $game = false
    end

    # change players
    if current_player == "X"
        current_player = "O"
    else
        current_player = "X"
    end
end