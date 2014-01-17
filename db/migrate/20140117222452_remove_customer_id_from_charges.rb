class RemoveCustomerIdFromCharges < ActiveRecord::Migration
  def up
    remove_column :charges, :customer_id
  end

  def down
    add_column :charges, :customer_id, :string
  end
end
