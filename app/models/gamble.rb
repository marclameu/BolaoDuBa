class Gamble < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  attr_accessible :active, :goals_team_1, :goals_team_2, :team_2_id
  #belongs_to :team1, :class_name => "Team", :foreign_key => 'team_1_id'
  #belongs_to :team2, :class_name => "Team", :foreign_key => 'team_2_id'
end
