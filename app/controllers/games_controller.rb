class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = Array.new(10) { alphabet.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters] ? params[:letters].split('.') : []
    puts
    @included = included?(@word, @letters)
    @valid_word = valid_word?(@word) if @included
  end

  def included?(word, letters)
    lettres_OK = letters.dup
    word.split('').all? do |letter|
      if lettres_OK.include?(letter)
        lettres_OK.delete_at(lettres_OK.index(letter))
        true
      else
        false
      end
    # { |letter| word.count(letter) <= letters.count(letter) }
    # word_letters = word.split('')
    # word_letters.all? do |letter|
    # word_letters.count(letter) <= letters.count(letter)
    end
  end
end
