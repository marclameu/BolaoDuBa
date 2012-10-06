class AddImageColumnsToTeam < ActiveRecord::Migration
  def self.up
    add_attachment :teams, :image
  end

  def self.down
    remove_attachment :teams, :image
  end
end
