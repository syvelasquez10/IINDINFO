class AddForeignKeyEstudianteMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :estudiantes, :monitoria_id1, :integer
    add_column :estudiantes, :monitoria_id2, :integer
  end
end
