class Deck < LibBase
  attr_accessor :cards, :discard

  def initialize(cards = [])
    @cards = cards
    @discard = []
  end

  def draw
    card = @cards.pop
  end

  def add_card(card)
    @cards << card
  end

  def discard(card)
    @discard.push(card)
  end

  def shuffle
    @cards = @cards.shuffle
  end

  def to_s
    "Remaining: #{@cards.size}
      Discard: #{Util.show_list(@discard) }"
  end
end