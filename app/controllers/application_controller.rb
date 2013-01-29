class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_championships
  before_filter :ranking
  $current_championship = "Campeonato Brasileiro" #avaliar furutamente se é uma boa opção utilizar variaveis globais    
  def ranking
    championship = Championship.find_by_desc($current_championship)
    @users_by_championship_classification = User.ranking(championship).limit(10)
  end
  
  def get_championships
    @championships = Championship.all
  end
end
