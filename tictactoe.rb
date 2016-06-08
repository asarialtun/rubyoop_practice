class Board
  SIZE = 3
  attr_reader :lines
  attr_reader :matrix_board
  def initialize
    @lines = Array.new
    SIZE.times do |i|
      @lines << Line.new(i)
    end
  end
  
  def print_board
    @matrix_board = Array.new
    @matrix_line = Array.new
    
    @lines.each do |line|
        line.cells.each do |cell|
            print " #{cell.play} "
            @matrix_line << cell.play
        end
        puts
        @matrix_board << @matrix_line.dup
        @matrix_line.clear
    end
  end
  
  def play(coordinate,player_id)
      line_no = coordinate[0]
      column_no = coordinate[1]
    
      if @lines[line_no].cells[column_no].play == 0
        @lines[line_no].cells[column_no].play = player_id
      else
        puts "The coordinate is already occupied"
        return false
      end
      
  end
  
  class Line
    attr_reader :cells
    
    def initialize(row_no)
      @row_no = row_no
      @cells = Array.new
      SIZE.times do |i|
        @cells << Cell.new(i)
      end
    end
    
    class Cell
      attr_accessor :play
      attr_reader :column_no
      def initialize(column_no)
        @play = 0
        @column_no = column_no
      end
    end #Cell
    
  end #Line
  
  def win?(matrix_board)
    winners = [
      [[0,0],[0,1],[0,2]],
      [[1,0],[1,1],[1,2]],
      [[2,0],[2,1],[2,2]],
      [[0,0],[1,0],[2,0]],
      [[0,1],[1,1],[2,1]],
      [[0,2],[1,2],[2,2]],
      [[0,0],[1,1],[2,2]],
      [[2,0],[2,1],[0,2]]
      
      ]
      
      winners.each do |x,y,z|
       if (matrix_board[x[0]][x[1]] == matrix_board[y[0]][y[1]])&&(matrix_board[x[0]][x[1]] != 0) && matrix_board[y[0]][y[1]] == matrix_board[z[0]][z[1]]
         return true
       else
         next
       end
      end
      return false
  end
  
end #Board

class Player
  attr_reader :player_id, :player_name
  @@player_count = 0
  
  def initialize (name)
    @player_name = name
    @@player_count += 1
    @player_id = @@player_count
  end
  
end

game = Board.new
players = Array.new
2.times do |i|
  puts "Enter name for Player#{i+1}"
  name = gets.chomp
  players << Player.new(name)
end

counter=2

while true
  player_id = players[counter%2].player_id
  puts "#{players[counter%2].player_name} 's turn:"
  puts "Please enter coordinates (e.g: '0,2')"
  arr = gets.chomp.split(",").map! do |i|
          i=i.to_i
        end
 
  if not game.play(arr,player_id)
  	next
  end
  game.print_board
  if game.win?(game.matrix_board)
  	puts "#{players[counter%2].player_name} wins"
  	return
  end
  counter +=1
  if counter>=11
  	puts "The game is a tie, no winner"
  	return
  end
end
