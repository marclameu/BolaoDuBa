class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only =>['index']

  def index
    if !user_signed_in?
       redirect_to new_user_session_path
    end
    @championships = Championship.all
    #session[:championship_id] = !@championships.empty? ?  @championships.first.id : nil
  end

  def rules

  end

  def toGambles
    
  end    

end
