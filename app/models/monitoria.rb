class MonitoriasPorEstudianteValidator < ActiveModel::Validator
  # Validación de que el número de monitorias de un estudiante no sea mayor a 2
  def validate(record)
    monitoria = Monitoria.where(estudiante_id:record.estudiante_id)
    if monitoria.size >= 2
      record.errors[:error] << 'Un estudiante no puede estar en más de 2 monitoria por semestre'
      # Una posible rrevisión
      # elsif monitoria.size == 1 && Monitoria::ESTADOS_APROBADOS.include?([0]['estado'])
      #  record.errors[:error] << 'El estudiante ya esta por terminar un proceso de monitorias. No se aceptan más cambios este semestre'
    end
  end
end
class Monitoria < ApplicationRecord
  belongs_to :estudiante
  belongs_to :curso

  validates :estado, presence: true
  validates :nota_curso, presence: true
  validates :semestre_curso, presence: true

  # Lista de posibles estados que puede tomar la monitoria
  ESTADOS = ['Aplico',
             'Aprobado por Promedio',
             'Rechazado por Promedio',
             'Seleccionado por el Profesor Monitor Sencillo',
             'Seleccionado por el Profesor Monitor Doble',
             'No Seleccionado por el Profesor',
             'Aceptado por el Estudiante Doble',
             'Aceptado por el Estudiante Sencillo',
             'Rechazado por el Estudiante',
             'Entrego Documentos',
             'Firmo Convenio'].freeze

  # Lista de estados en los cuales no se aceptan mas cambios en la monitoria. Cambios como que un monitor quiera escoger al estudiante
  ESTADOS_APROBADOS = ['Aceptado por el Estudiante',
                       'Rechazado por el Estudiante',
                       'Monitoria Aprobada',
                       'Entrego Documentos',
                       'Firmo Convenio'].freeze


  # Promedio necesario para la monitoria
  PROMEDIO = 3.5

  PROMEDIO_EXTRACREDITAR = 4

  # Créditos para una monitoria
  CREDITOS_UNA = 23

  # Créditos para dos monitorias
  CREDITOS_DOS = 21

  # Créditos para una monitoria
  CREDITOS_UNA_EXTRACREDITAR = 18

  # Créditos para dos monitorias
  CREDITOS_DOS_EXTRACREDITAR = 16

  validates :estado, inclusion: { in: ESTADOS,
                                message: "%{value} no es un estado valido" }

  validates :nota_curso, numericality: { less_than_or_equal_to: 5.0, greater_than_or_equal_to: 1.0}

  validates_with MonitoriasPorEstudianteValidator

  def self.actualizar_estado_segundo_curso(monitoria, estado)
    estudiante = Estudiante.find(monitoria['estudiante_id'])
    monitorias = estudiante.monitorias
    if monitorias.present? && monitorias.size > 1
      if monitorias[0]['id'] != monitoria['id']
        monitorias[0].update(:estado_segundo_curso => estado)
      else
        monitorias[1].update(:estado_segundo_curso => estado)
      end
    end
  end

  def to_s
    estado
  end
end