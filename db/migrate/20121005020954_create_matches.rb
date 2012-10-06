class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.references :team_1
      t.integer :team_2_id
      t.integer :goals_team1
      t.integer :goals_team2
      t.datetime :date_match
      t.references :round

      t.timestamps
    end
    add_index :matches, :round_id
  end
  def self.down
    drop_table :matches
  end
end
