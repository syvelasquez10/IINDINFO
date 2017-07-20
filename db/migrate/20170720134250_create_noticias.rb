class CreateNoticias < ActiveRecord::Migration[5.0]
  def change
    create_table :noticias do |t|
      t.string :titulo
      t.text :texto
      t.string :semestre
      t.string :fecha

      t.timestamps
    end
  end
end
