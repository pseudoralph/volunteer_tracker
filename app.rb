require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload './lib/**/*.rb'
require_relative 'lib/volunteer.rb'
require_relative 'lib/project.rb'

# DB = PG.connect({dbname: 'volunteer_tracker'})
DB = PG.connect({dbname: 'volunteer_tracker_test'})

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
  @volunteers = Volunteer.all

  erb :project_details
end

patch '/projects/:id/rename' do
  project = Project.find(params[:id].to_i)
  project.update({title: params[:title]})

  redirect "/projects/#{params[:id].to_i}"
end

get '/volunteer/:id/' do
  @volunteer = Volunteer.find(params[:id].to_i)
  erb :volunteer_details
end

patch '/volunteer/:id/assign' do
  params["volunteer_ids"].each do |volunteer_id|
    volunteer = Volunteer.find(volunteer_id.to_i)
    volunteer.update(project_id: params["id"].to_i)
  end
  redirect "/projects/#{params[:id].to_i}"
end

patch '/volunteer/:id/rename' do
  if params["name"] != ""
    volunteer = Volunteer.find(params["id"].to_i)
    volunteer.update({
      name: params["name"]
      })
  end
  redirect "/projects/#{volunteer.project_id}"

end

delete '/projects/:id/delete' do
  project = Project.find(params[:id].to_i)
  project.delete

  redirect "/"
end

get '/volunteers/:id/delete' do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete

  redirect '/'
end
