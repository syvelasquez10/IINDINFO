class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.date :fecha
      t.string :usuario
      t.string :action
      t.string :controller
      t.boolean :token

      t.timestamps
    end
  end
end
