require 'sinatra'
require "sinatra/reloader" if development?
require './lib/Pandemic.rb'
require './gui/Renderer.rb'

also_reload './lib/Pandemic.rb'
also_reload './gui/Renderer.rb'

get '/start' do
  game = Pandemic.new
  HTMLRenderer.new(game).render
end
