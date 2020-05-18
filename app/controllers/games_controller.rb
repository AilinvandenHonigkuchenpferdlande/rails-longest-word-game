class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(" ")
    if grid && dictionary_check
      @score = "Congratulations! #{@word} is a valid English word"
    elsif dictionary_check
      @score = "Sorry, but #{@word} cannot be built out of #{@letters.join(', ')}"
    else
      @score = "Sorry, but #{@word} does not seem to be a valid English word..."
    end
  end

  private

  def dictionary_check
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = HTTParty.get(url)
    dictionary['found']
  end

  def grid
    @word.chars.all? { |a| @word.count(a) <= @letters.count(a) }
  end
end
