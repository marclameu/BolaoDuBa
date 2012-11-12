class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_championships
  before_filter :ranking
  $current_championship = "Campeonato Brasileiro" #avaliar furutamente se é uma boa opção utilizar variaveis globais
  def ranking
    @users_by_championship_classification = nil
    #@users_by_championship_classification = User.ranking.limit(10)
  end
  
  def get_championships
    @championships = Championship.all
  end
end
