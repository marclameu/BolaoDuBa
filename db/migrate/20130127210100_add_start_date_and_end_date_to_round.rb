class AddStartDateAndEndDateToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :start_date, :datetime
    add_column :rounds, :end_date, :datetime
  end

  def self.down
    remove_column :rounds, :start_date
    remove_column :rounds, :end_date
  end
end
