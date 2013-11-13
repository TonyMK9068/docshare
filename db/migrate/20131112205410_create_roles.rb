class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, :id => false do |t|
      t.references :user
      t.references :page
      t.string :status
  
      t.timestamps
    end
    add_index :roles, [:page_id, :user_id]
  end
end
