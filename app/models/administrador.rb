class Administrador < ApplicationRecord
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["SEMESTRE","carnet","apellidos","nombres","programa",	"doble_programa",	"doc_identidad","fecha_nac","sexo",	"DIRECCION ESTUD",	"ciudad",	"AREA_TEL", "TELEFONO",	"EXTENSION", "AREA_CELULAR","celular",	"sit_academica","cred_tomados","cred_aprobados", "cred_pga","prom_acum", "cred_transf",	"ULT SEM CURS",	"CRED SEM TOMADOS",	"CRED SEM APROB",	"CRED SEM PGA",	"PROM SEM","ssc","email",	"cred_sem_actual"]
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.delete "DIRECCION ESTUD"
      row.delete "AREA_TEL"
      row.delete "TELEFONO"
      row.delete "EXTENSION"
      row.delete "AREA_CELULAR"
      row.delete "ULT SEM CURS"
      row.delete "CRED SEM TOMADOS"
      row.delete "CRED SEM APROB"
      row.delete "CRED SEM PGA"
      row.delete "PROM SEM"
      row.delete "SEMESTRE"
      estudiante = Estudiante.where(carnet: row["carnet"])
      if estudiante.present?
        estudiante.update(row)
      else
        Estudiante.new(row).save
      end

    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Tipo de archivo no manejado: #{file.original_filename}"
    end
  end
end