class StaticController < ApplicationController

  def index
    @movies = Popcorn.new(group_by_name: true, output_name: :international_name).get_all
  end

end
