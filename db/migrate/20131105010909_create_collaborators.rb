class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :user
      t.references :page

      t.timestamps
    end
    add_index :collaborators, :user_id
    add_index :collaborators, :page_id
  end
end
