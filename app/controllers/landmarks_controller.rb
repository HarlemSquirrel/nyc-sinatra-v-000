class LandmarksController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/landmarks") }

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :index
  end

  get '/landmarks/new' do
    erb :new
  end

  post '/landmarks' do
    landmark = Landmark.create(
      name: params[:landmark["name"]],
      year_completed: params[:landmark["year_completed"]]
    )

    redirect to "/landmarks/#{landmark.id}"
  end

  patch '/landmarks/:id' do
    landmark = Landmark.find_by_id(params[:id])
    landmark.name = params[:landmark]["name"]
    landmark.year_completed = params[:landmark]["year_completed"]
    landmark.save
    redirect to "/landmarks/#{landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :show
  end


  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :edit
  end
end
