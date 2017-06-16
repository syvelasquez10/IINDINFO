class MonitoriasPorEstudianteValidator < ActiveModel::Validator
  def validate(record)
    if Monitoria.where(estudiante_id:record.estudiante_id).size >= 2
      record.errors[:error] << 'Un estudiante no puede estar en más de 2 monitoria por semestre'
    end
  end
end
class Monitoria < ApplicationRecord
  validates_with MonitoriasPorEstudianteValidator

  belongs_to :estudiante
  belongs_to :curso

  ESTADOS = ['Solicitado',
             'Aprobado por el profesor',
             'Rechazado por el profesor',
             'Aprobado por Coordinacion',
             'Rechazado por Coordinación',
             'Aprobado por todo el mundo'].freeze

  validates :estado, inclusion: { in: ESTADOS,
                                message: "%{value} no es un estado valido" }
end