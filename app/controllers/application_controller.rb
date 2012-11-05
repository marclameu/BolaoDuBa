class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_championships
  
  
  def get_championships
    @championships = Championship.all
  end
end
