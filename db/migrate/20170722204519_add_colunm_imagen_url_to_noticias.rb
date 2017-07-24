class AddColunmImagenUrlToNoticias < ActiveRecord::Migration[5.0]
  def change
    add_column :noticias, :imagen_url, :string
  end
end
