class Team < ActiveRecord::Base
  attr_accessible :description, :name
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>"}
  has_many :matches
  has_and_belongs_to_many :users
#  has_many :gambles
  #belongs_to :team1, :class_name => 'Match', :foreign_key => 'team1_id'
  #belongs_to :team2, :class_name => 'Match', :foreign_key => 'team2_id'
end
