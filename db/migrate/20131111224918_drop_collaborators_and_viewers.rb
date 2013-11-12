class DropCollaboratorsAndViewers < ActiveRecord::Migration
  def up
    drop_table :viewers
    drop_table :collaborators
  end

  def down
    create_table "collaborators", :force => true do |t|
      t.integer  "user_id",    :null => false
      t.integer  "page_id",    :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "collaborators", ["user_id", "page_id"], :name => "index_collaborators_on_user_id_and_page_id"
  
    create_table "viewers", :force => true do |t|
      t.integer  "user_id",    :null => false
      t.integer  "page_id",    :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

   add_index "viewers", ["user_id", "page_id"], :name => "index_viewers_on_user_id_and_page_id"
   
  end
end
