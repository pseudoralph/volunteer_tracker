require 'pg'
require 'sinatra'
require 'sinatra/reloader'
also_reload './lib/**/*.rb'
require_relative 'lib/volunteer.rb'
require_relative 'lib/project.rb'

DB = ENV['DATABASE_URL'] ? PG.connect(ENV['DATABASE_URL']) : PG.connect({dbname: 'volunteer_tracker'})

get '/' do
  @all_projects = Project.all
  @all_volunteers = Volunteer.all

  erb :index
end

get '/volunteer' do
  redirect '/'
end

get '/projects' do
  redirect '/'
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

get '/projects/:id/edit' do
  @project = Project.find(params[:id].to_i)
  erb :project_update
end

patch '/projects/:id/rename' do
  project = Project.find(params[:id].to_i)
  project.update({title: params[:title]})

  redirect "/projects/#{params[:id].to_i}"
end

get '/volunteer/:id/' do
  @volunteer = Volunteer.find(params[:id].to_i)
  erb :volunteer_update
end

patch '/volunteer/:id/assign' do
  unless params["volunteer_ids"]
    redirect "/projects/#{params[:id].to_i}"
  end
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

delete '/volunteers/:id/delete' do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete

  redirect '/'
end
