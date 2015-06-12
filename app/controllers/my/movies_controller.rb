class My::MoviesController < ApplicationController

  before_filter :has_auth?, only: [:wait, :hate, :watch]

  def index
    case params[:group]
      when 'waited'
        scope = :waits
      when 'watched'
        scope = :watches
      when 'hated'
        scope = :hates
      else
        scope = :unmarked
      end
    movies = current_user ? current_user.send(scope) : Movie.all
    @movies = movies.by_date.paginate(page: params[:page], per_page: 9)
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
