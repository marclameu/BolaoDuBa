class Championship < ActiveRecord::Base
  attr_accessible :desc
  has_many:rounds
end
