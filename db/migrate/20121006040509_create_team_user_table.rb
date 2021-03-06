class CreateTeamUserTable < ActiveRecord::Migration
  def self.up
    create_table :teams_users, :id => false do |t|
      t.references :team
      t.references :user
    end
  add_index :teams_users, [:team_id, :user_id]
  add_index :teams_users, [:user_id, :team_id]  
  end  
  def self.down
    drop_table :teams_users
  end
end
