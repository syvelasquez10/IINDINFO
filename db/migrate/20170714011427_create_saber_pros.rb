class CreateSaberPros < ActiveRecord::Migration[5.0]
  def change
    create_table :saber_pros do |t|
      t.string :tipo_documento
      t.string :fecha_nacimiento
      t.boolean :pago
      t.text :observaciones
      t.boolean :inscrito
      t.integer :estudiante_id

      t.timestamps
    end
  end
end
