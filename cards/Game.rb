require './Deck.rb'
require './Card.rb'
require './Shuffler.rb'

class Game
  attr_accessor :deck

  def initialize
    @deck = []
  end

  def print
    deck.each do |card|
      card.print
    end
  end
end