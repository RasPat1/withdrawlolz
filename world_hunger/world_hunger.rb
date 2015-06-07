#!/usr/bin/ruby

class Country
  # food production is dependent on the following but for now just use single value
  # @area
  # @climate
  # @fertility_rate # or fertility rate can be dependent on how hungry people are
  # @population
  attr_reader :population
  def initialize(name, population, food_production)
    @name = name
    @population = population
    @food_production = food_production
    @food_storage = 0
    @@fertility_rate = 0.8
  end

  # Every turn each country changes it's stats
  def turn
    # start with simplest model of food consumption and creation
    if @food_production >= @population
      food_surplus = @food_production - @population
    else
      food_deficit = @population - @food_production
    end

    if food_surplus
      @food_storage += food_surplus
    elsif food_deficit
      if @food_storage >= food_deficit
        @food_storage -= food_deficit
      else
        shortage = food_deficit - @food_storage
        @food_storage = 0
        @population -= shortage # that many people starve
      end
    end

    @population += (@population * @@fertility_rate).floor
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
  attr_reader :world_population
  def initialize
    @countries = []
    add_countries
    @world_population = get_world_population
  end

  def add_countries
    @countries.push(Country.new("USA", 300, 800))
    @countries.push(Country.new("Mexico", 200, 163))
    @countries.push(Country.new("India", 1300, 1100))
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
      country.to_s_pretty
    end
  end
end

class Game
  def initialize
    @world = World.new
    @turn = 0
    play
  end

  def play
    max_turns = 10
    while @turn < max_turns
      turn
      puts "Hit enter for next turn"
      gets
      @turn +=1
    end
  end

  def game_over
    puts "everone is dead"
    puts "you lasted #{@turn} turns"
    exit
  end

  def turn
    self.to_s
    @world.turn
    if @world.world_population <= 0
      game_over
    end
  end

  def to_s
    puts "Turn: #{@turn}"
    @world.to_s
  end
end

Game.new
