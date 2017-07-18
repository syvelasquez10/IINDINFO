class AddColumEstudianteToCita < ActiveRecord::Migration[5.0]
  def change
    add_column :citas, :estudiante_id, :integer
  end
end
