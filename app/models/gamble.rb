class Gamble < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  attr_accessible :active, :goals_team_1, :goals_team_2, :team_2_id
  validates_presence_of :goals_team_1, :message => "Por favor, informe o numero de gols do time 1"
  validates_presence_of :goals_team_1, :message => "Por favor, informe o numero de gols do time 1"
  validates_numericality_of :goals_team_1, :greather_than => 0, :message => "Numero de gols do time 1 deve ser maior ou igual a 0"
  validates_presence_of :goals_team_2, :message => "Numero de gols do time 2 deve ser maior ou igual a 0"
  
  scope :active_gambles, where(:active => 1).joins(:user).joins(:match).order("date_match DESC")
  #scope :active_inactive_gambles, lambda{|active| where(:active => active).joins(:user).joins(:match).order("date_match DESC")}
  
  def self.create_gamble4_user(gamble,user)
    @gamble = gamble
    @gamble.user = user   
    @gambles =  find_all_user_gambles(user)
    unless(@gambles == nil)
      @gambles.each do |g|
        g.active = false
        g.save
      end
    end
    @gamble.active = true
    @gamble
    #@gamble.save
  end
    
  def self.find_all_user_gambles(user,page = nil)
    #if page == nil
     # @gambles = Gamble.where("user_id = ?",[user.id])
    #else
      @gambles = Gamble.where("user_id = ?",[user.id]).paginate(:page => page, :per_page => 4)
    #end
    @gambles
  end
  #belongs_to :team1, :class_name => "Team", :foreign_key => 'team_1_id'
  #belongs_to :team2, :class_name => "Team", :foreign_key => 'team_2_id'
end
