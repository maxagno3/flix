class FavsController < ApplicationController
  before_action :require_signin

  def create
    @movie = Movie.find_by!(slug: params[:movie_id])
    @movie.likers << current_user
    redirect_to @movie
  end

  def destroy
    favs = current_user.favs.find(params[:id])
    favs.destroy

    movie = Movie.find_by(slug: params[:movie_id])
    redirect_to movie
  end
end
