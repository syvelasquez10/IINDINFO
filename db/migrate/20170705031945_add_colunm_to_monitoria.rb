class AddColunmToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :nota_monitoria, :decimal
  end
end
