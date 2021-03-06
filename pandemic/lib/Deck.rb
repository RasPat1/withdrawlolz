class Deck
  attr_accessor :cards, :discard

  def initialize(cards = [])
    @cards = cards
    @discard = []
  end

  def draw
    card = @cards.pop
  end

  def bottom_draw
    card = @cards.shift
  end

  def add_card(card)
    @cards << card
  end

  def add_all_discard_to_deck
    @discard = @discard.shuffle
    @cards += @discard
    @discard = []
  end

  def discard(card)
    @discard.push(card)
  end

  def shuffle
    @cards = @cards.shuffle
  end

  def empty?
    @cards.size == 0
  end

  def to_s
    "Remaining: #{@cards.size}
      Discard: #{Util.show_list(@discard) }"
  end
end
