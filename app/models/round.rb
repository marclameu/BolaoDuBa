class Round < ActiveRecord::Base
  belongs_to :championship
  attr_accessible :desc, :num_round
end
