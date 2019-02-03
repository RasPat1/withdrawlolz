class Config
  attr_accessor :city_list, :starting_city, :edges

  MODES = [
    DEMO = :demo,
    RANDOM = :random
  ]

  def initialize(mode = RANDOM)
    # debugger
    if mode == DEMO
      demo
    else
      random
    end
  end

  def demo
    @city_list = [
      'Chicago', 'San Francisco',
      'New York', 'Portland',
      'Austin', 'Boston', 'Los Angeles'
    ]
    @starting_city = 'New York'
    @edges = [
      [0, 1], [1, 2], [2, 3], [2, 4], [3, 5], [3, 6], [5,6]
    ]
  end

  def random
    @city_list = all_city_list
    @starting_city = 'New York'
    @edges = []
    # Let's assume a minimum connectivity of 1
    # and an average connectivity of 3-5?
    # So let's make n * 3 edges...
    @city_list.each_with_index do |city, city_index|
      rand_index = random_city_index(city_index, city.size)
      @edges << [city_index, rand_index]
    end

    new_edge_count = @city_list.size * 2
    new_edge_count.times do
      rand_city_1 = (rand * @city_list.size).floor
      rand_city_2 = random_city_index(rand_city_1, @city_list.size)
      @edges << [rand_city_1, rand_city_2]
    end
  end

  # Get a random city that is not the current one
  # Todo: Make cities adjacent on the list connected
  # Thsi graph has a physical metaphor so it's logical that cities
  # that are "close" are connected. aka don't do random connectedness
  def random_city_index(current_index, size)
    adj_city_index = current_index

    while current_index == adj_city_index
      adj_city_index = (rand * size).floor
    end

    adj_city_index
  end

  def all_city_list
    [
    'Austin',
    'Boston',
    'Chicago',
    'Columbus',
    'Dallas',
    'Detroit',
    'Houston',
    'Indianapolis',
    'Kansas City',
    'Los Angeles',
    'Miami',
    'Milwaukee',
    'New Orleans',
    'New York',
    # 'Orlando',
    # 'Philadelphia',
    # 'Phoenix',
    # 'Portland',
    # 'San Francisco',
    # 'Seattle',
    # 'Tucson',
    # 'Washington, D.C.',
    ].uniq
  end

  def self.starting_city
    'New York'
  end
end