class AddColumnsToEstudiante < ActiveRecord::Migration[5.0]
  def change
    add_column :estudiantes, :reviso_informacion, :boolean
    add_column :estudiantes, :token_celular, :string
  end
end
