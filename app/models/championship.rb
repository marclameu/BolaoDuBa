class Championship < ActiveRecord::Base
  attr_accessible :desc, :start_date, :end_date
  has_many :rounds
  has_many :participations
  has_many :users, :through => :participations
end
