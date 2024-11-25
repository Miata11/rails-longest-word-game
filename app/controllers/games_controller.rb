# class GamesController < ApplicationController
#   def new
#     alphabet = ('A'..'Z').to_a
#     @letters = Array.new(10) { alphabet.sample }
#   end

#   def score
#     @word = params[:word]
#     @letters = params[:letters] ? params[:letters].split('.') : []
#     puts
#     @included = included?(@word, @letters)
#     @valid_word = valid_word?(@word) if @included
#   end

#   def included?(word, letters)
#     lettres_OK = letters.dup
#     word.split('').all? do |letter|
#       if lettres_OK.include?(letter)
#         lettres_OK.delete_at(lettres_OK.index(letter))
#         true
#       else
#         false
#       end
#     # { |letter| word.count(letter) <= letters.count(letter) }
#     # word_letters = word.split('')
#     # word_letters.all? do |letter|
#     # word_letters.count(letter) <= letters.count(letter)
#     end
#   end
# end
require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
