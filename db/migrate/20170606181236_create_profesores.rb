class CreateProfesores < ActiveRecord::Migration[5.0]
  def change
    create_table :profesores do |t|
      t.string :nombres
      t.string :apellidos
      t.string :email
      t.string :tipo

      t.timestamps
    end
  end
end
