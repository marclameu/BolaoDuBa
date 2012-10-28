class Participation < ActiveRecord::Base
  attr_accessible :championship_id, :user_id, :user_points
  belongs_to :championship
  belongs_to :user
end
