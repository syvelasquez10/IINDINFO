class MonitoriasPorEstudianteValidator < ActiveModel::Validator

  # Validación de que el número de monitorias de un estudiante no sea mayor a 2
  def validate(record)
    if Monitoria.where(estudiante_id:record.estudiante_id).size >= 2
      record.errors[:error] << 'Un estudiante no puede estar en más de 2 monitoria por semestre'
    end
  end
end
class Monitoria < ApplicationRecord
  belongs_to :estudiante
  belongs_to :curso

  # Lista de posibles estados que puede tomar la monitoria
  ESTADOS = ['Aplico',
             'Aprobado por Promedio',
             'Rechazado por Promedio',
             'Seleccionado por el Profesor Monitor Sencillo',
             'Seleccionado por el Profesor Monitor Doble',
             'No Seleccionado por el Profesor',
             'Aceptado por el Estudiante',
             'Monitoria Aprobada',
             'Entrego Documentos',
             'Firmo Convenio'].freeze

  validates :estado, inclusion: { in: ESTADOS,
                                message: "%{value} no es un estado valido" }
  validates_with MonitoriasPorEstudianteValidator, :on => :create

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