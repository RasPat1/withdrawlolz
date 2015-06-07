#!/usr/bin/ruby

class Country 
  @name
  @population
  @food_storage
  @food_prodcution

  # food production is dependent on the following but for now just use single value
  # @area
  # @climate
  # @fertility_rate # or fertility rate can be dependent on how hungry people are
  # @population

  def initialize(name, population, food_production)
    @name = name
    @population = population
    @food_production = food_production
    @food_storage = 0
  end

  # Every turn each country changes it's stats
  def turn
    new_population += @population * @fertility_rate
    # @population -= @population * (@hungry_percent)

    # start with simplest model of food consumption and creation
    if @food_production >= @population
      food_surplus = @food_production - @population
    elsif @food_production < @population
      food_deficit = @population - @food_production
    end

    if food_surplus
      @food_storage += food_surplus
    elsif food_deficit
      if @food_storage >= food_deficit
        @food_storage -= food_deficit
      elsif food_deficit > @food_storage
        @food_storage = 0
        shortage = food_deficit - @food_storage
        @population -= shortage # that many people starve
      end
    end
  end

  def to_s_pretty
    puts "#{@name} has #{@population} living in it making #{@food_production} \
units of food and has #{@food_storage} units stored."
  end

  def to_s
    puts "#{@name}: #{@population}, #{@food_production}, #{@food_storage}" 
  end
end


class World
  @countries
  @world_population

  def initialize
    @countries = []
    add_countries
    @world_population = get_world_population
  end

  def add_countries
    @countries.push(Country.new("USA", 3e8, 8e8))
    @countries.push(Country.new("Mexico", 2e8, 3e8))
    @countries.push(Country.new("India", 1.2e9, 6e8))
  end
  
  def turn
    @countries.each do |country|
      country.turn
    end
    @world_population = get_world_population
  end

  def get_world_population
    sum = 0
    @countries.each do |country|
      sum += country.population
    end
    sum
  end

  def to_s
    @countries.each do |country|
      country.to_s
    end
  end
end

class Game
  @world
  @turn

  def initialize
    @world = World.new
    @turn = 0
    play
  end

  def play
    max_turns = 10
    while @turn < max_turns
      puts "Hit enter for next turn"
      gets
      turn
      @turn +=1
    end
  end
  
  def game_over
    puts "everone is dead"
    puts "you lasted #{@turn} turns"
    exit
  end

  def turn
    world.turn
    if world.world_population <= 0
      game_over
    end
  end

  def to_s
    puts "Turn: #{@turn}"
    world.to_s
  end
end

Game.new
