class My::FiltersController < ApplicationController
  def create
    session[:filters] = {engine: params[:engine]}
    redirect_to :back
  end
  def destroy
    session[:filters] = nil
    redirect_to :back
  end
end