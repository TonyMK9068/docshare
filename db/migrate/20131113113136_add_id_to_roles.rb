class AddIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :id, :primary_key
    add_column :users, :id, :primary_key
  end
end
