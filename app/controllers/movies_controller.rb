class MoviesController < ApplicationController

  def index
    @movies = Movie.by_date.paginate(page: params[:page])
  end

  def show
    @movie = Movie.find(params[:id])
  end

end
