class My::MoviesController < ApplicationController

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
    @movies = current_user.send(scope)
  end

  # @TODO – Should remove other associations before creating new

  def wait
    current_user.waits << Movie.find(params[:movie_id])
    redirect_to root_path
  end

  def hate
    current_user.hates << Movie.find(params[:movie_id])
    redirect_to root_path
  end

  def watch
    current_user.watches << Movie.find(params[:movie_id])
    redirect_to root_path
  end

end
