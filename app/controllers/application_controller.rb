class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_engines

  def get_engines
    @engines = MovieLink.engines
  end

  def current_user
    Rails.env == "development" ? User.first : current_user
  end
end
