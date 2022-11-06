require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = 9.times.map { ('A'..'Z').to_a.sample }
  end

 # The word is valid according to the grid, but is not a valid English word
  def exist?(word)
    # API endpoint: https://wagon-dictionary.herokuapp.com/table
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    string_serialized = URI.open(url).read
    result = JSON.parse(string_serialized)
    result['found']
  end

  # The word can’t be built out of the original grid
  def valid?(word, letters)
    word_array = word.chars
    word_array.all? { |w| letters.include?(w) }
  end

  def score
    # The word can’t be built out of the original grid
    # The word is valid according to the grid, but is not a valid English word
    # The word is valid according to the grid and is an English word
    @input = params[:word].upcase
    @letters = params[:letters].split
    @result = ''
    if valid?(@input, @letters) && exist?(@input)
      @result = "Congratulations! #{@input} is a valid English word!"
    elsif valid?(@input, @letters) && exist?(@input) == false
      @result = "Sorry but #{@input} is not a valid English word"
    elsif exist?(@input) && valid?(@input, @letters) == false
      @result = "Sorry but #{@input} can't be build out of #{@letters_array}"
    else
      @result = 'You lost! Looser.'
    end
  end
end
