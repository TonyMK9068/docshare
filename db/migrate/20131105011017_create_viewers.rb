class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.references :user
      t.references :page

      t.timestamps
    end
    add_index :viewers, :user_id
    add_index :viewers, :page_id
  end
end
