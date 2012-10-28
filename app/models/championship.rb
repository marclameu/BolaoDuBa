class Championship < ActiveRecord::Base
  attr_accessible :desc
  has_many :rounds
  has_many :participations
  has_many :users, :through => :participations
end
