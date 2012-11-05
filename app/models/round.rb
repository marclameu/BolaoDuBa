class Round < ActiveRecord::Base
  belongs_to :championship
  has_many :matches
  attr_accessible :desc, :num_round
  def self.current_round(championship_id) 
    where("championship_id = ?",[championship_id]).order("num_round DESC").last
  end
  
  def finish_round_and_pontuate_users(championship_id = nil)
    if championship_id == nil
      championship_id = Championship.where("championships.desc = 'Campeonato Brasileiro'").first.id
    end
    matches.each do|m|
      m.gambles.each do |g|
        g.user_points = g.points4_user
        g.save
        if g.user.participations != nil
           p = g.user.participations.find_by_championship_id(championship_id)
           p.user_points = (p.user_points == nil)? g.user_points : p.user_points + g.points4_user
           p.save
        end
      end
    m.save
    end        
  end  
  #scope :last_round, where("num_round = ? and championship_id = ? ",[Round.maximum(:num_round)], [championship.id])
end
