require './Game'
require './Shuffler'
require './Deck'

class GameSpec
  def initialize
  end

  def run
  	Game.new.print
  end

  def test_shuffle
    d1 = Deck.new(Deck.generate_deck)
    d2 = Deck.new(Deck.generate_deck)

    puts "d1 equals d2: #{d1 == d2}"
    d1 = Shuffler.shuffle(d1)
    puts "Shuffle!"
    puts "d1 equals d2: #{d1 == d2}"
  end

  def shuffle_till_equal
    d1 = Deck.new(Deck.generate_deck)
    d2 = Deck.new(Deck.generate_deck)

    puts d1

    d1 = Shuffler.shuffle(d1)
    shuffle_count = 1

    while !(d1 == d2)
      d1 = Shuffler.shuffle(d1)
      shuffle_count += 1

      puts d1
      puts d2
      return if shuffle_count > 9
    end

    puts "Shuffled #{shuffle_count} times until decks were equal"
  end
end

game = GameSpec.new
game.run

game.test_shuffle

game.shuffle_till_equal