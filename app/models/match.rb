class Match < ActiveRecord::Base
  belongs_to :round
  attr_accessible :date_match, :goals_team_1, :goals_team_2, :team1, :team2
  belongs_to :team1, :class_name => Team, :foreign_key => 'team_1_id'
  belongs_to :team2, :class_name => "Team", :foreign_key => 'team_2_id'
  has_many :gambles
end