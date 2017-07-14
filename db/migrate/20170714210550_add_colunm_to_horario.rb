class AddColunmToHorario < ActiveRecord::Migration[5.0]
  def change
    add_column :horarios, :tipo_cita, :string
  end
end
