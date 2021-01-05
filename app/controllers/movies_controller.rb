class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:edit, :update, :destroy, :show]

  def index
    case params[:filter]
    when "upcoming"
      @movies = Movie.upcoming
    when "flop"
      @movies = Movie.flop
    when "hit"
      @movies = Movie.hit
    else
      @movies = Movie.past
    end
  end

  def show
    @likers = @movie.likers
    @genres = @movie.genres
    if current_user
      @current_liker = current_user.favs.find_by(movie_id: @movie.id)
    end
  end

  def edit
  end

  def update
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
    @movie.destroy
    redirect_to movies_path
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def update_movie
    params.require(:movie).permit(:name, :description, :rating, :released_at, :poster_image, genre_ids: [])
  end
end
