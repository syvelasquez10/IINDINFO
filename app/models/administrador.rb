class Administrador < ApplicationRecord
  #Metodo encargado de tomar un archivo de estudiantes y crear una entidad Estudiante pro cada fila del archivo, el archivo debe tener el formato indicado en el array header
  def self.import_estudiantes(file)
    # Se abre el archivo
    spreadsheet = open_spreadsheet(file)

    # Se definen los nombres que se utilizaran en la aplicacion para las columnas del archivo
    # Los nombres de las columnas no deben ser iguales pero la cantidad de columnas si. Una columna es un elemente del array header
    header = ["SEMESTRE","carnet","apellidos","nombres","programa",	"doble_programa",	"doc_identidad","fecha_nac","sexo",	"DIRECCION ESTUD",	"ciudad",	"AREA_TEL", "TELEFONO",	"EXTENSION", "AREA_CELULAR","celular",	"sit_academica","cred_tomados","cred_aprobados", "cred_pga","prom_acum", "cred_transf",	"ULT SEM CURS",	"CRED SEM TOMADOS",	"CRED SEM APROB",	"CRED SEM PGA",	"PROM SEM","ssc","email",	"cred_sem_actual"]
    # Se leen las filas de la 2 en adelante
    (2..spreadsheet.last_row).each do |i|
      # Al leer una fila se carga en un hash en el que el key es el nombre de la columna y el value es el valor de la columna en esa fila.
      # El key se toma del array de header y el value del archivo
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # Se eliminan las columans que no se quieren usar.
      # Se podría también hacer un slice y tomar solo las columanas que se quieren
      row.delete "SEMESTRE"
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

      # Se busca si existe un estudiante con el valor de la columna carnet de la fila que se lee
      estudiante = Estudiante.where(carnet: row["carnet"]).take
      # Si existe un estudiante con ese carnet entonces se actualiza, sino entonces se crea uno nuevo en la base de datos
      if estudiante.present?
        estudiante.update(row)
      else
        Estudiante.new(row).save
      end
    end
    return :status => "OK"
  end

  #Metodo encargado de tomar un archivo de cursos y crear una entidad Curso pro cada fila del archivo, el archivo debe tener el formato indicado en el array header
  def self.import_cursos(file)
    # Se abre el archivo
    spreadsheet = open_spreadsheet(file)

    # Se definen los nombres que se utilizaran en la aplicacion para las columnas del archivo
    # Los nombres de las columnas no deben ser iguales pero la cantidad de columnas si. Una columna es un elemente del array header
    header = ["N","crn","codigo_curso","secc","cred",	"nombre_curso",	"cupo","inscritos","disponibilidad",	"hora_inicio",	"hora_fin",	"salon", "capacidad_salon",	"L", "M","I",	"J","V","S", "hora_inicio2","hora_fin2","salon2","capacidad_salon2","L", "M","I",	"J","V","S","hora_inicio3","hora_fin3","salon3","capacidad_salon3","L", "M","I",	"J","V","S","profesor1","profesor2","profesor3"]

    # PELIGRO Se reinicia todos los inscritos de todos los cursos
    Curso.update_all(inscritos: 0)

    # Se leen las filas de la 2 en adelante
    (2..spreadsheet.last_row).each do |i|

      # Al leer una fila se carga en un hash en el que el key es el nombre de la columna y el value es el valor de la columna en esa fila.
      # El key se toma del array de header y el value del archivo
      row_file = Hash[[header, spreadsheet.row(i)].transpose]

      # Se eligen solo las filas que se quieren usar
      row = row_file.slice('nombre_curso','codigo_curso')

      # Se limpian los valores tomados para que no tengan espacios que generen problemas despues
      row.each_value(&:strip!)

      # Se carga por ultimo el numero de inscritos debido a que si se hacia antes se generaria error al aplicar strip sobre un número
      row['inscritos']= row_file.slice('inscritos')['inscritos']

      # se inicializa el atributo
      row['monitores_solicitados']= 0

      # Se busca si existe un curso con el valor de la columna codigo de la fila que se lee
      curso = Curso.where(codigo_curso: row['codigo_curso']).take

      # Si existe un Curso con ese carnet se actuliza, sino se crea uno nuevo en la base de datos
      if curso.present?
        row['inscritos'] = row['inscritos'] + curso['inscritos']
        # Se calculan los monitores requeridos para el curso
        monitores_requeridos = (row['inscritos']/25.to_f).ceil
        row['monitores_requeridos'] = monitores_requeridos

        if monitores_requeridos > curso['monitores_solicitados']
          estado = "Faltan Monitores por seleccionar"
        elsif monitores_requeridos < curso['monitores_solicitados']
          estado = "Hay mas monitores solicitados de los que se requieren"
        else
          estado = "Cantidad adecuada de monitores"
        end
        row['estado']= estado

        curso.update(row)
      else
        # Se calculan los monitores requeridos para el curso
        monitores_requeridos = (row['inscritos']/25.to_f).ceil
        row['monitores_requeridos'] = monitores_requeridos

        estado= "Faltan Monitores por seleccionar"
        row['estado']= estado
        Curso.new(row).save
      end
    end

    return :status => "OK"
  end

  #Metodo encargado de preparar un archvio CSV o EXCEL para poder usarse en el sistema
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Tipo de archivo no manejado: #{file.original_filename}"
    end
  end
end
