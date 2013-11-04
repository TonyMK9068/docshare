class AddDefaultValueToPageAttribute < ActiveRecord::Migration
  def up
      change_column :pages, :public, :boolean, :default => true
  end

  def down
      change_column :pages, :public, :boolean, :default => false
  end
end
