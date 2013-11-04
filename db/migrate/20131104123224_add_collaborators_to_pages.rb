class AddCollaboratorsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :collaborators, :integer
  end
end
