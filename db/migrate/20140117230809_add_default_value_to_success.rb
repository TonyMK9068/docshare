class AddDefaultValueToSuccess < ActiveRecord::Migration
  def change
    change_column :charges, :success, :boolean, default: false
  end
end
