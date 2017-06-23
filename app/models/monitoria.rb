class MonitoriasPorEstudianteValidator < ActiveModel::Validator
  def validate(record)
    if Monitoria.where(estudiante_id:record.estudiante_id).size >= 2
      record.errors[:error] << 'Un estudiante no puede estar en más de 2 monitoria por semestre'
    end
  end
end
class Monitoria < ApplicationRecord
  belongs_to :estudiante
  belongs_to :curso

  ESTADOS = ['Aplico',
             'Aprobado por Coordinacion',
             'Rechazado por Coordinacion',
             'Seleccionado por el Profesor',
             'Monitoria Aprobada',
             'Entrego Documentos',
             'Firmo Convenio'].freeze

  validates :estado, inclusion: { in: ESTADOS,
                                message: "%{value} no es un estado valido" }
  validates_with MonitoriasPorEstudianteValidator, :on => :create

end