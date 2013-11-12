class AddCollaboratorsAndViewersToPage < ActiveRecord::Migration
  def change
    add_column :pages, :collaborator_id, :integer
    add_column :pages, :viewer_id, :integer
  end
end
