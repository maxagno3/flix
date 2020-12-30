class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(update_movie)
    redirect_to @movie
  end

  def new
    @movie = Movie.new    
  end

  def create
    @movie = Movie.new(update_movie)
    @movie.save
    redirect_to @movie
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private
  def update_movie
    params.require(:movie).permit(:name, :description, :rating, :released_at)
  end
end
