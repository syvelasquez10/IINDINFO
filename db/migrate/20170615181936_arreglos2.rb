class Arreglos2 < ActiveRecord::Migration[5.0]
  def change
    remove_column :cursos, :profesor_id
  end
end
