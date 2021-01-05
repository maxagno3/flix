class ReviewsController < ApplicationController
    before_action :require_signin
    before_action :movie

    def index
      @review = @movie.reviews
    end

    def new
      @review = @movie.reviews.new
    end

    def create
      @review = @movie.reviews.new(review)
      @review.user = current_user
      if @review.save
        redirect_to movie_reviews_path(@movie)
      else
        render :new
      end
    end

    private

    def review
      params.require(:review).permit(:review)
    end

    def movie
      @movie = Movie.find_by!(slug: params[:movie_id])
    end
end
