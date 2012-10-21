class Match < ActiveRecord::Base
  belongs_to :round
  attr_accessible :date_match, :goals_team_1, :goals_team_2, :team1, :team2
  belongs_to :team1, :class_name => Team, :foreign_key => 'team_1_id'
  belongs_to :team2, :class_name => "Team", :foreign_key => 'team_2_id'
  has_many :gambles
  
  def self.matches_after_date (date, page)
    where("date_match > ?", [date]).paginate(:page => page, :per_page => 4 ).order('date_match ASC')
  end
  
  def self.user_matches(user_team)
    Match.where("team_1_id = #{user_team} or team_2_id = #{user_team} and date_match > '#{ApplicationHelper.get_utc_time}'")
  end
end
