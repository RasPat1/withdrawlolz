require './Deck.rb'
require './Card.rb'

class DeckSpec
  def initialize
    puts "Deck Test Started"
  end

  def run
    methods = [:test_equality, :test_equality]
    all_passed = true

    methods.each do |method_name|
      passed = self.send(method_name)
      puts "Test Failed: #{method_name}" unless passed
      all_passsed = all_passsed && passed
    end
    if all_passed
      puts "All tests passed"
    end
  end

  def test_equality
    d1 = Deck.new
    d1.contents = [Card.new("3", "H")]

    d2 = Deck.new
    d2.contents = [Card.new("3", "H")]

    d1 == d2
  end

  def test_inequality
    d1 = Deck.new
    d1.contents = [Card.new("3", "H")]

    d2 = Deck.new
    d2.contents = [Card.new("3", "H"), Card.new("4", "H")]

    d1 != d2
  end
end

ds = DeckSpec.new
ds.run