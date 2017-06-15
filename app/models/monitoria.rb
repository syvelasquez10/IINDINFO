class Monitoria < ApplicationRecord
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