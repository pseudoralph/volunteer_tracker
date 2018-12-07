require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload './lib/**/*.rb'
require_relative 'lib/volunteer.rb'
require_relative 'lib/project.rb'

DB = PG.connect({dbname: 'volunteer_tracker'})
# DB = PG.connect({dbname: 'volunteer_tracker_test'})


get '/' do
  @all_projects = Project.all
  @all_volunteers = Volunteer.all
  erb :index
end

post '/add-project' do
  if params["title"] != ''
    project = Project.new({title: params['title']})
    project.save
  end
  redirect '/'
end

post '/add-volunteer' do
  if params["name"] != ''

    volunteer = Volunteer.new({name: params['name']})
    volunteer.save
  end
  redirect '/'
end

get '/projects/:id' do
  @project = Project.find(params[:id].to_i)

  erb :project_details
end

patch '/projects/:id/rename' do
  @project = Project.find(params[:id].to_i)
  @project.update({title: params[:title]})

  redirect "/projects/#{params[:id].to_i}"
end
