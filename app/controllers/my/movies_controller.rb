class My::MoviesController < ApplicationController

  def index
    @movies = current_user.unmarked
  end

  # @TODO – Should remove other associations before creating new

  def wait
    current_user.waits << Movie.find(params[:movie_id])
    redirect_to :back
  end

  def hate
    current_user.hates << Movie.find(params[:movie_id])
    redirect_to :back
  end

  def watch
    current_user.watches << Movie.find(params[:movie_id])
    redirect_to :back
  end

end
