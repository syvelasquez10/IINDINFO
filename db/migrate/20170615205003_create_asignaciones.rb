class CreateAsignaciones < ActiveRecord::Migration[5.0]
  def change
    create_table :asignaciones do |t|
      t.integer :profesor_id
      t.integer :curso_id

      t.timestamps
    end
  end
end
