class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :born_date, :email, :name, :image, :Cpf, :teams
 
  #campos requeridos
  validates_presence_of :name, :Cpf
  validates_associated :teams
  
  #associações
  has_many :gambles
  has_and_belongs_to_many :teams
  has_many :participations
  has_many :championships, :through => :participations
  #accepts_nested_attributes_for :teams

  # atributo imagem
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "300x180>"}
  
  #gamble ranking
  def self.round_classification(round = nil)
    unless round == nil
      joins(:gambles => [:match => :round]).where("num_round = ?", [round.num_round]).order("user_points DESC")
    else
      joins(:gambles => [:match => :round]).where("num_round = ?", [Round.maximum(:num_round)]).order("user_points DESC")
    end
  end
  
  #Championship Classification
  def self.ranking(championship = nil)
    if championship == nil
      championship = Championship.where("championships.desc = '#{$current_championship}'")
      championship = championship.first unless championship == nil
    end
    unless championship == nil
      joins(:participations => :championship).where("championship_id = ?", [championship.id]).order("user_points DESC")
    else
      nil
    end
  end 
  
  #Caso o usuário não tenha feito aposta "gamble", será criada uma aposta default
  #Este método será chamado no encerramento da rodada
  def self.create_default_gamble4_match(round)
    
  end
end
