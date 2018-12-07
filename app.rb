require 'pg'
require 'sinatra'
require 'sinatra/reloader'
also_reload './lib/**/*.rb'
require_relative 'lib/volunteer.rb'
require_relative 'lib/project.rb'

DB = PG.connect({dbname: 'volunteer_tracker'})

get '/' do
  erb :index
end
