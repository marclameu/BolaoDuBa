class AddStartDateAndEndDateToChampionship < ActiveRecord::Migration
  def change
    add_column :championships, :start_date, :datetime
    add_column :championships, :end_date, :datetime
  end

  def self.down
    remove_column :championships, :start_date
    remove_column :championships, :end_date
  end
end
