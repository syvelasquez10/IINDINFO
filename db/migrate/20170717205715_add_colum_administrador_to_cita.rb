class AddColumAdministradorToCita < ActiveRecord::Migration[5.0]
  def change
    add_column :citas, :administrador_id, :integer
  end
end
