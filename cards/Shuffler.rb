require './Deck'

class Shuffler
  def initialize
  end

  def self.shuffle(deck)
    stack1 = []
    stack2 = []

    deck.contents.each_with_index do |card, index|

      card = deck.contents[index]
      if index % 2 == 0
        stack1 << card
      else
        stack2 << card
      end
    end

    new_deck = Deck.new

    new_deck.contents = stack1
    new_deck.contents += stack2
    new_deck
  end
end

