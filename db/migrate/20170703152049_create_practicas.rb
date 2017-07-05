class CreatePracticas < ActiveRecord::Migration[5.0]
  def change
    create_table :practicas do |t|
      t.string :semestre
      t.boolean :charla
      t.text :comentarios
      t.integer :estudiante_id
      t.string :estado
      t.timestamps
    end
  end
end
