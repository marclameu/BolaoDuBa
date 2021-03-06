class Match < ActiveRecord::Base
  belongs_to :round
  attr_accessible :date_match, :goals_team1, :goals_team2, :team1, :team2
  belongs_to :team1, :class_name => Team, :foreign_key => 'team_1_id'
  belongs_to :team2, :class_name => "Team", :foreign_key => 'team_2_id'
  has_many :gambles
  
  #obtem todas as partidas da última rodada
  def self.last_round_matches(page = nil)
    joins(:round).where("num_round = ?",[Round.maximum(:num_round)]).order('date_match ASC').paginate(:page => page, :per_page => 4 ) 
  end
  #obtém as partidas após determinada data
  def self.matches_after_date (date, page = nil)
    where("date_match >= ?", [date]).paginate(:page => page, :per_page => 4 )
    #where("date_match >= ?", [date]).paginate(:page => page, :per_page => 4 ).order('date_match ASC')
  end
  #obtém as partidas da última rodada associadas a um time
  #def self.user_matches4_last_round(user_team)
  #  joins(:round).where("(team_1_id = #{user_team} or team_2_id = #{user_team}) and num_round = #{Round.maximum(:num_round)}")
  #end
  def self.user_matches4_last_round(user_team)
    unless Round.maximum(:num_round) == nil
      joins(:round).where("(team_1_id = #{user_team} or team_2_id = #{user_team}) and num_round = #{Round.maximum(:num_round)}")
    else
      nil
    end
  end
  def self.user_matches(user_team)
    where("(team_1_id = #{user_team} or team_2_id = #{user_team}) and date_match >= '#{ApplicationHelper.get_utc_time}'").order("date_match DESC")
  end  
  #Atualiza todas as apostas (Matches) vindas da tela ""round4_finish".
  def self.update_all_matches(matches)
    matches.each do |m|
      match4_update = Match.find(m[0].to_i)      
      match4_update.goals_team1 = (m[1]["goals_team1"].to_s.eql? "")? nil : m[1]["goals_team1"].to_i
      match4_update.goals_team2 = (m[1]["goals_team2"].to_s.eql? "")? nil : m[1]["goals_team2"].to_i
      match4_update.save
    end
  end
end
