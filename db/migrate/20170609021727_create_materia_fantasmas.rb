class CreateMateriaFantasmas < ActiveRecord::Migration[5.0]
  def change
    create_table :materia_fantasmas do |t|
      t.string :codigo

      t.timestamps
    end
  end
end
