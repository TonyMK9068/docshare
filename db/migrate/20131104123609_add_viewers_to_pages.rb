class AddViewersToPages < ActiveRecord::Migration
  def change
    add_column :pages, :viewers, :integer
  end
end
