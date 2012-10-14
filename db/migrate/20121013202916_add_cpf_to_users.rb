class AddCpfToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Cpf, :string
  end

  def self.down
    remove_column :users, :Cpf
  end
end
