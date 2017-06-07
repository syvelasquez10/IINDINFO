class Administrador < ApplicationRecord
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["semestre","carnet","apellidos","nombres","programa",	"doble_programa",	"doc_identidad","fecha_nac","sexo",	"DIRECCION ESTUD",	"ciudad",	"AREA_TEL", "TELEFONO",	"EXTENSION", "AREA_CELULAR","celular",	"sit_academica","cred_tomados","cred_aprobados", "cred_pga","prom_acum", "cred_transf",	"ULT SEM CURS",	"CRED SEM TOMADOS",	"CRED SEM APROB",	"CRED SEM PGA",	"PROM SEM","ssc","email",	"cred_sem_actual"]
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      estudiante = Estudiante.where(["carnet = :u", { u: row["carnet"] }]) || new
      estudiante.attributes = row.to_hash.slice(:carnet, :apellidos, :nombres, :programa, :doble_programa, :doc_identidad, :fecha_nac, :sexo, :ciudad, :celular,	:sit_academica, :cred_tomados, :cred_aprobados, :cred_pga, :prom_acum, :cred_transf, :ssc, :email, :cred_sem_actual)
      estudiante.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil && :ignore)
      else raise "Tipo de archivo no manejado: #{file.original_filename}"
    end
  end
end
