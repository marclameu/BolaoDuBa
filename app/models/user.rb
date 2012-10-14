class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #campos requeridos
  validates_presence_of :name, :Cpf
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :born_date, :email, :name, :image, :Cpf
  has_many :gambles
  has_and_belongs_to_many :teams
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "300x180>"}
end
