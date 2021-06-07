class GamesController < ApplicationController
  def new
    @letters = 9.times.map{("a".."z").to_a.sample}
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @correct = @word.split("").all? do |letter|
      @word.count(letter) <= @letters.count(letter)
    end
    if @correct
      require 'json'
      require 'open-uri'
      @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      result_serialized = URI.open(@url).read
      @result = JSON.parse(result_serialized)
      if @result["found"]
        @score = @word.length
        @message = "Well done!"
      else
        @score = 0
        @message = "Your word is not an English word"
      end
    else
      @score = 0
      @message = "You used at least one illegal character"
    end
    
  end
  
end
