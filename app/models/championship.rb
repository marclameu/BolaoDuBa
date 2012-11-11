class Championship < ActiveRecord::Base
  attr_accessible :desc, :start_date, :end_date
  has_many :rounds
  has_many :participations
  has_many :users, :through => :participations

  #campos requeridos
  validates_presence_of :desc, :start_date, :end_date

end
