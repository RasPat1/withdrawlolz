require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require './lib/Pandemic.rb'

game = Pandemic.new
game.play
