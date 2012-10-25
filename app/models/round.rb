class Round < ActiveRecord::Base
  belongs_to :championship
  attr_accessible :desc, :num_round
  def self.current_round(championship_id) 
    where("championship_id = ?",[championship_id]).order("num_round DESC").last
  end
end
