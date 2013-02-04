class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_championships
  before_filter :ranking_of_side
  before_filter :admin_user

  $current_championship = "Campeonato Mineiro 2013" #avaliar furutamente se é uma boa opção utilizar variaveis globais    
  def ranking_of_side
    championship = Championship.find_by_desc($current_championship)
    @users_by_championship_classification = User.ranking(championship)#.limit(10)
  end
  
  def get_championships
    @championships = Championship.all
  end

  protected
  
  def admin_user
    unless params[:controller] == 'devise/sessions' 
      if user_signed_in?
        emails_permitidos = %(marclameu@gmail.com flavioapolinario1@gmail.com)
        unless emails_permitidos.include?(current_user.email)
          redirect_to root_path
        end
      end
    end
  end
end
