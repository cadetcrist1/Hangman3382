require 'sinatra'
require_relative "hangman.rb"
enable :sessions

get '/' do
	erb :index
end 

post '/player_names' do 
	session[:player1] = params[:player1]
	session[:player2] = params[:player2]
	# "Player 1 is #{player1} and Player 2 is #{player2}"
	redirect '/password'
end

get '/password' do
	erb :password, locals:{p1_name: session[:player1], p2_name: session[:player2]}

end	

post '/secretword' do

	password = params[:word]
	session[:game]=Hangman.new(password)
	redirect '/guessing'
end

get '/guessing' do
	erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, already_guessed: session[:game].guessed, message: "Pick a Letter", message2: "", counter: session[:game].counter}
end

post '/guess' do
	choice = params[:letter].upcase
	
	if session[:game].available_guess(choice)
		true
		
		session[:game].update_guessed(choice)
		session[:game].make_move(choice)
		if session[:game].loser == true
		redirect "/loser"
		elsif 
		session[:game].winner == true
		redirect '/winner'
		end
		redirect '/guessing'
	else
		erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, already_guessed: session[:game].guessed, message: "", message2: "That letters already been picked, pick again.", counter: session[:game].counter} 
	end
end
get "/loser" do
	erb :loser, locals:{p1_name: session[:player1], p2_name: session[:player2], word: session[:game].name}

end
get "/winner" do
	erb :winner, locals:{p1_name: session[:player1], p2_name: session[:player2], word: session[:game].name}
end