class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :page, :null => false
      t.timestamps
    end
    
      add_index(:collaborators, [:user_id, :page_id])    
  end
end
