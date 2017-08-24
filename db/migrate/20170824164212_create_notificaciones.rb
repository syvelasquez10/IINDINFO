class CreateNotificaciones < ActiveRecord::Migration[5.0]
  def change
    create_table :notificaciones do |t|
      t.string :asunto
      t.text :contenido
      t.string :filtro_categoria
      t.string :filtro_estado

      t.timestamps
    end
  end
end
