class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.references :user
      t.boolean :public


      t.timestamps
    end
    add_index :pages, :user_id
  end
end
