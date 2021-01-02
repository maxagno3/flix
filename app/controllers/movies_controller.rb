class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.upcoming
  end

  def show
    @movie = Movie.find(params[:id])
    @likers = @movie.likers
    if current_user
      @current_liker = current_user.favs.find_by(movie_id: @movie.id)
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(update_movie)
      redirect_to @movie, notice: "Successfully updated"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new    
  end

  def create
    @movie = Movie.new(update_movie)
    if @movie.save
      redirect_to @movie, notice: "Successfully created"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def update_movie
    params.require(:movie).permit(:name, :description, :rating, :released_at, :poster_image)
  end
end
