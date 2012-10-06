class CreateGambles < ActiveRecord::Migration
  def self.up
    create_table :gambles do |t|
      t.integer :active
      t.references :user
      #t.references :team_1
      #t.integer :team_2_id
      t.integer :goals_team_1
      t.integer :goals_team_2
      t.references :match

      t.timestamps
    end
    add_index :gambles, :user_id
   # add_index :gambles, :team_1_id
    add_index :gambles, :match_id
  end
  def self.down
    drop_table :gambles    
  end
end
