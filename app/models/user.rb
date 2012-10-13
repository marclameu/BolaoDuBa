class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :born_date, :email, :name, :image
  has_many :gambles
  has_and_belongs_to_many :teams
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "300x80>"}
end
