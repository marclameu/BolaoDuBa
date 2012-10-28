class AddUserPointsColumnToGamble < ActiveRecord::Migration
  def change
    add_column :gambles, :user_points, :integer
  end

  def self.down
    remove_column :gambles, :user_points
  end
end
