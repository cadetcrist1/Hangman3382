require "Minitest/autorun"
require_relative "hangman.rb"

class Testhangmanfunctions < Minitest::Test

	def test_class_returns_password
		hangman = Hangman.new("crist")
		assert_equal(5,hangman.charcount)
	end

	def test_class_returns_five_blanks
		hangman = Hangman.new("crist")
		assert_equal(["_","_","_","_","_"],hangman.blank)
	end

	def test_class_returns_if_included_in_password
		hangman = Hangman.new("crist")
		letter = "i"
		assert_equal(true,hangman.correct_letter?(letter))
	end
	def test_class_user_guess_is_pushed_into_guessing_array
		hangman = Hangman.new("crist")
		hangman.guessed = ["l","x","z"]
		letter = "y"
		assert_equal(["l","x","z","y"],hangman.update_guessed(letter))
	end
	def test_return_correct_index_positions
		hangman = Hangman.new("crist")
		letter = "c"
		hangman.correct_index(letter)
		assert_equal(["c","_","_","_","_"],hangman.correct_blank)
	end
	def test_return_correct_position
		hangman = Hangman.new("crist")
		hangman.correct_blank = ["c","_","_","_","_"]
		letter = "s"
		hangman.correct_index(letter)
		assert_equal(["c","_","_","s","_"],hangman.correct_blank)
	end
	def test_return_if_false_position
		hangman = Hangman.new("crist")
		hangman.correct_blank = hangman.correct_blank
	end
	def test_class_see_if_guess_has_been_guessed
		hangman = Hangman.new("crist")
		hangman.guessed = ["s","w","p"]
		letter = "s"
		assert_equal(false,hangman.available_guess(letter))
	end