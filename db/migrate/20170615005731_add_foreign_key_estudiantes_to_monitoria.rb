class AddForeignKeyEstudiantesToMonitoria < ActiveRecord::Migration[5.0]
  def change
    remove_column :monitorias, :curso_id, :integer
    add_reference :monitorias, :curso, foreign_key: true
  end
end
