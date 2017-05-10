class LandmarksController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/landmarks") }

  get '/landmarks' do
    @landmark = Landmark.all
    erb :index
  end

  get '/landmarks/new' do
    erb :new
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:landmark_name], year_completed: params[:landmark][:year_completed])
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :show
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :edit
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    if !params[:landmark][:name].nil?
      @landmark.name = params[:landmark][:name]
    end
    if !params[:landmark][:year_completed].nil?
      @landmark.year_completed = params[:landmark][:year_completed]
    end
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end
end
