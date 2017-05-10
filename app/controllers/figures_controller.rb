class FiguresController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/figures") }

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    erb :new
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :show
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])

    #create landmarks for figures
    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end

    #create titles for figures
    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title|
        @figure.titles << Title.find(title)
      end
    end
    #create new landmarks/titles
    @figure.landmarks <<  Landmark.create(name: params[:landmark][:name])
    @figure.titles << Title.create(name: params[:title][:name])
    @figure.save

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :edit
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])

    if !params[:figure][:name].empty?
      @figure.name = params[:figure][:name]
    end
    #create landmarks for figures
    if !params[:figure][:landmark_ids].nil?
      @figure.landmarks.clear
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end

    #create titles for figures
    if !params[:figure][:title_ids].nil?
      @figure.titles.clear

      params[:figure][:title_ids].each do |title|
        @figure.titles << Title.find(title)
      end
    end
    #create new landmarks/titles
    if !params[:landmark][:name].empty?
      @figure.landmarks <<  Landmark.create(name: params[:landmark][:name])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end
end
