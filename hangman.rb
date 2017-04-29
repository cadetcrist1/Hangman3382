class Hangman
	attr_accessor :name,:guessed,:correct_blank, :counter

	def initialize(password_name)
		@name = password_name.upcase
		@guessed = []
		@correct_blank = blank()
		@counter = 7
	end
	def charcount
		name.length
	end
	def blank()
		Array.new(charcount,"_")
	end
	def update_guessed(choice)
		guessed.push(choice)
	end
	def make_move(letter)
		if correct_letter?(letter) == true
			correct_index(letter)
		else
			@counter -= 1
		end

	end

	def correct_letter?(letter)
		name.include?(letter)
	end
	def verified_guessed(letter)
		guessed.include?(letter)
	end
	def correct_index(guessed_letter)
		password=name.split ("")
		password.each_with_index do |letter,index_position|
			if letter == guessed_letter
				correct_blank[index_position] = guessed_letter
			end
		end
	end
	def available_guess(choice)
		if guessed.count(choice) == 0
			true
		else
			false
		end
	end
	def loser
		counter == 0
	end
	def winner
		if correct_blank.include?("_")
			false
		else 
			true
		end
	end
end