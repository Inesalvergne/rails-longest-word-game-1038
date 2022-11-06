class GamesController < ApplicationController
  def new
    letters = ("A".."Z").to_a
    @letters_array = 9.times.map { letters.sample }
  end

  def score
    @score = params[:word]
  end
end
