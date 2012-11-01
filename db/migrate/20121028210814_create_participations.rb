class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :championship_id
      t.integer :user_id
      t.integer :user_points
      t.timestamps
    end
  end
  def self.down
    drop_table :participations
  end
end
