class EnginesController < ApplicationController
  def show
    movies        = Movie.from_engine(params[:id])
    @movies       = movies.by_date.paginate(page: params[:page], per_page: 30)
    @movies_count = movies.size
  end
end
