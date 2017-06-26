class AddColumnComentariosToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :comentarios, :text
  end
end
