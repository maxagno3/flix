class ReviewsController < ApplicationController

    before_action :movie

    def index
      @review = @movie.reviews
    end

    def new
      @review = @movie.reviews.new
    end

    def create
      @review = @movie.reviews.new(review)
      if @review.save
        redirect_to movie_reviews_path(@movie)
      else
        render :new
      end
    end

    private

    def review
      params.require(:review).permit(:name, :review)
    end

    def movie
      @movie = Movie.find(params[:movie_id])
    end
end
