#Colors: Red, Green, Blue, Yellow, Cyan, Purple, (rgbycp)
class Mastermind
	Colors = "rgbycp".split('')
	def initialize
		@turn = 0
		@secret = Colors.shuffle[0..3]
		play
	end
    
    def check_exacts(colors)
        exact_matches = 0
        colors.each_with_index do |guessed_color,i|
            if guessed_color == @secret[i]
                exact_matches += 1
            end
        end
        return exact_matches
    end
    
    def check_existing(colors)
        existing_colors = 0
        colors.each do |color|
            if @secret.include?(color)
                existing_colors += 1
            end
        end
        return existing_colors
    end
    
    def play
        playing = true
        if @turn == 0
            introduction
        end
        puts "You have #{12-@turn} tries left"
        human_guess = gets.chomp.split('')
        if check_exacts(human_guess) < 4
            puts "Exact matches = " + check_exacts(human_guess).to_s
            puts "Wrong placement = #{check_existing(human_guess) - check_exacts(human_guess)}"
        else
            game_over("win")
            playing = false
        end
        
        @turn += 1
        if @turn < 12 && playing
            play
        elsif playing
            game_over("lose")
            playing = false
        end
    end
    
    def introduction
        puts "The game is played with 6 colors: Red, Green, Blue, Yellow, Cyan, Purple"
        puts "Computer has set a code of 4 colors. Can you guess it in 12 rounds?"
        puts "Input your guess as a 4 letter word which consists of first letter of the colors such as 'rgby' for 'red, green, blue, yellow'"
    end
    
    def game_over(result)
        if result == "win"
            puts "Congratulations! You have found it in #{@turn} step(s)"
        elsif result=="lose"
            puts "You could not guess the code. Sorry!"
        end
    end
    
end

game = Mastermind.new