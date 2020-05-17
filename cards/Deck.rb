require './Card.rb'

class Deck
  attr_accessor :contents

  SUITS = ['D', 'S', 'C', 'H']
  VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K']

  def initialize(contents = [])
    @contents = contents
  end

  def ==(deck2)
    return false if contents.length != deck2.contents.length
    deck_equal = true

  	contents.each_with_index do |card, index|
	    card1 = contents[index]
	    card2 = deck2.contents[index]

      card_equal = card1.value != card2.value || card1.suit != card2.suit
      deck_equal = deck_equal && card_equal
	  end

    deck_equal
  end

  def self.generate_deck
    deck = []

    VALUES.each do |value|
      SUITS.each do |suit|
        deck << Card.new(value, suit)
      end
    end

    deck
  end

  def to_s
    contents.map(&:to_s).join(', ')
  end
end

