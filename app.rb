require 'pg'
require 'sinatra'
require 'sinatra/reloader'
also_reload './lib/**/*.rb'
require_relative 'lib/volunteers.rb'
require_relative 'lib/projects.rb'


# DB = PG.connect({dbname: 'volunteer_tracker'})

get '/' do

  erb :index
end
