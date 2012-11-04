class Round < ActiveRecord::Base
  belongs_to :championship
  has_many :matches
  attr_accessible :desc, :num_round
  def self.current_round(championship_id) 
    where("championship_id = ?",[championship_id]).order("num_round DESC").last
  end
  
  def finish_round_and_pontuate_users
    matches.each do|m|
      m.gambles.each do |g|
        g.user_points = g.points4_user
        g.save
      end
    m.save
    end        
  end  
  #scope :last_round, where("num_round = ? and championship_id = ? ",[Round.maximum(:num_round)], [championship.id])
end
