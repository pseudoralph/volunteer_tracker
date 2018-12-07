require 'pg'
require 'sinatra'
require 'sinatra/reloader'
also_reload './lib/**/*.rb'
require_relative 'lib/volunteer.rb'
require_relative 'lib/project.rb'

# DB = PG.connect({dbname: 'volunteer_tracker'})

get '/' do
  @all_projects = Project.all
  @all_volunteers = Volunteer.all
  erb :index
end

patch '/add-proj' do
  project = Project.new({title: params['title']})
  project.save

  redirect '/'
end
