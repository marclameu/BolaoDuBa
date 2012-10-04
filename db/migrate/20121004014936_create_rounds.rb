class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.integer :num_round
      t.string :desc
      t.references :championship

      t.timestamps
    end
  end
  def self.down
    drop_table :rounds
  end
end
