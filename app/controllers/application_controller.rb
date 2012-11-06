class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_championships
  before_filter :ranking
  $current_championship = "Campeonato Brasileiro" #avaliar furutamente se é uma boa opção utilizar variaveis globais
  def ranking
    #championship = Championship.where("championships.desc = '#{$current_championship}'")
    #championship = championship.first unless championship == nil
    @users_by_championship_classification = User.ranking
  end
  
  def get_championships
    @championships = Championship.all
  end
end
