class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :user
      t.string :customer_id
      t.boolean :success, default: true

      t.timestamps
    end
    add_index :charges, :user_id
  end
end
