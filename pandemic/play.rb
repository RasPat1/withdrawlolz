# This is how we play the game from the cli.

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require './lib/Pandemic.rb'

game = Pandemic.new
game.play
