class MoviesController < ApplicationController

  def index
    @movies = Movie.by_date
  end

  def show
    @movie = Movie.find(params[:id])
  end

end
