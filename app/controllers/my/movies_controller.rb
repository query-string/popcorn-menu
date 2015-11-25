class My::MoviesController < ApplicationController

  before_filter :has_auth?, only: [:wait, :hate, :watch]

  def index
    scope =  case params[:group]
      when 'waited'
        :waits
      when 'watched'
        :watches
      when 'hated'
        :hates
      else
        :unmarked
    end
    movies = current_user ? current_user.send(scope).all : Movie.all
    @movies = movies.by_date.paginate(page: params[:page], per_page: 27)
    @movies_count = movies.size
  end

  # @TODO – Should remove other associations before creating new

  def checked
    @movie = Movie.find(params[:movie_id])
    current_user.send(params[:scope]) << @movie
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

private

  def has_auth?
    redirect_to user_omniauth_authorize_path(:facebook) unless current_user
  end

end
