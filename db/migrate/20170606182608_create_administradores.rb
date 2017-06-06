class CreateAdministradores < ActiveRecord::Migration[5.0]
  def change
    create_table :administradores do |t|
      t.string :nombres
      t.string :apellidos
      t.string :email

      t.timestamps
    end
  end
end
