class FiguresController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/figures") }

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    #binding.pry
    erb :new
  end

  post '/figures' do

    figure = Figure.create(name: params[:figure]["name"])

    #if params[:figure]["title_ids"] != nil
      #title_ids = params[:figure]["title_ids"].collect {|id| id.to_i}
      #title_ids.each { |id| figure.titles << Title.find_by_id(id)}
    #  params[:figure]["title_ids"].each { |id| figure.titles << Title.find_by_id(id.to_i)}
    #end
    params[:figure]["title_ids"].each {
      |id| figure.titles << Title.find_by_id(id.to_i)
    } unless params[:figure]["title_ids"] == nil

    #if params[:figure]["landmark_ids"] != nil
    params[:figure]["landmark_ids"].each {
      |id| figure.landmarks << Landmark.find_by_id(id.to_i)
    } unless params[:figure]["landmark_ids"] == nil
      #landmark_ids = params[:figure]["landmark_ids"].collect {|id| id.to_i}
      #landmark_ids.each { |id| figure.landmarks << Landmark.find_by_id(id)}
      #figure.landmarks = landmark_ids
    #end
    #binding.pry
    #figure.landmarks = params[:figure]["landmark_ids"] unless params[:figure]["landmark_ids"] == nil

    if params[:title]["name"] != ""
      #binding.pry
      new_title = Title.find_or_create_by(name: params[:title]["name"])
      figure.titles << new_title

    end

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
    figure.year_completed = params[:figure]["year_completed"]
    figure.save
    redirect to "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :show
  end


  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :edit
  end
end
