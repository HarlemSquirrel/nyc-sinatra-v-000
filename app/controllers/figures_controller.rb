class FiguresController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/figures") }

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :new
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure]["name"])

    # add checked titles
    params[:figure]["title_ids"].each {
      |id| figure.titles << Title.find_by_id(id.to_i)
    } unless params[:figure]["title_ids"] == nil

    # add checked landmarks
    params[:figure]["landmark_ids"].each {
      |id| figure.landmarks << Landmark.find_by_id(id.to_i)
    } unless params[:figure]["landmark_ids"] == nil

    # create new title and add it to figures
    if params[:title]["name"] != ""
      new_title = Title.find_or_create_by(name: params[:title]["name"])
      figure.titles << new_title
    end

    # create new landmark and add it to figures
    if params[:landmark]["name"] != ""
      new_landmark = Landmark.find_or_create_by(name: params[:landmark]["name"])
      new_landmark.year_completed = params[:landmark]["year_completed"]
      figure.landmarks << new_landmark
    end

    figure.save

    redirect to "/figures/#{figure.id}"
  end

  patch '/figures/:id' do
    figure = Figure.find_by_id(params[:id])
    figure.name = params[:figure]["name"]
    figure.titles = []
    figure.landmarks = []

    # add checked titles
    params[:figure]["title_ids"].each {
      |id| figure.titles << Title.find_by_id(id.to_i)
    } unless params[:figure]["title_ids"] == nil

    # add checked landmarks
    params[:figure]["landmark_ids"].each {
      |id| figure.landmarks << Landmark.find_by_id(id.to_i)
    } unless params[:figure]["landmark_ids"] == nil

    # create new title and add it to figures
    if params[:title]["name"] != ""
      new_title = Title.find_or_create_by(name: params[:title]["name"])
      figure.titles << new_title
    end

    # create new landmark and add it to figures
    if params[:landmark]["name"] != ""
      new_landmark = Landmark.find_or_create_by(name: params[:landmark]["name"])
      new_landmark.year_completed = params[:landmark]["year_completed"]
      figure.landmarks << new_landmark
    end

    figure.save

    redirect to "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :show
  end


  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :edit
  end
end
