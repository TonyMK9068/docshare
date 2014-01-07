class EditPageIdAndUserIdInRoles < ActiveRecord::Migration
  def change
    change_column :roles, :user_id, :integer, :null => false
    change_column :roles, :page_id, :integer, :null => false
  end
end
