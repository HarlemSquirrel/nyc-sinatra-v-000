class FiguresController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/figures") }

  get '/figures' do
    erb :index
  end

  get '/figures/new' do

  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :show
  end
end
