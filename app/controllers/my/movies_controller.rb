class My::MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def wait
    current_user.user_waits << Movie.find(params[:movie_id])
    redirect :back
  end

  def hate
    current_user.user_hates << Movie.find(params[:movie_id])
    redirect :back
  end

  def watch
    current_user.user_watches << Movie.find(params[:movie_id])
    redirect :back
  end

end
