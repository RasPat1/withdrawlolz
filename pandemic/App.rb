require 'sinatra'
require "sinatra/reloader" if development?
require './lib/Pandemic.rb'

get '/start' do
  game = Pandemic.new
end
