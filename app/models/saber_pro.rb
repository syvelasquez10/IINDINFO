class SaberPro < ApplicationRecord

  belongs_to :estudiante

  # Metodo encargado de tomar un archivo de estudiantes que pagaron el saber pro y actualizar ese valor en cada entidad
  def self.cargar_archivo_pagos(file)
    # Se abre el archivo
    spreadsheet = Administrador.open_spreadsheet(file)

    # Se definen los nombres que se utilizaran en la aplicacion para las columnas del archivo
    # Los nombres de las columnas no deben ser iguales pero la cantidad de columnas si. Una columna es un elemente del array header
    header = ["documento_identidad","email"]
    # Se leen las filas de la 2 en adelante
    (2..spreadsheet.last_row).each do |i|
      # Al leer una fila se carga en un hash en el que el key es el nombre de la columna y el value es el valor de la columna en esa fila.
      # El key se toma del array de header y el value del archivo
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # Se busca si existe un estudiante con el valor de la columna email de la fila que se lee
      estudiante = Estudiante.where(email: row['email']).take
      # Si el estudiante con ese email se inscribio entonces se actualiza, sino entonces se crea uno nuevo en la base de datos
      if estudiante.saberPro.present?
        estudiante.saberPro.update(pago: true)
      else
        SaberPro.new({pago: true,estudiante_id:estudiante['id'],inscrito:false}).save
      end
    end
    return :status => "OK"
  end
end
