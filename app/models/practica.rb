class Practica < ApplicationRecord
  belongs_to :estudiante

  # Lista de posibles estados que puede tomar la practica
  ESTADOS = ['Aplico',
             'Autorizado',
             'No autorizado',
             'Puede ingresar a la plataforma del CTP',
             'Realizó Práctica',
             'No Realizó Práctica'].freeze

  validates :estado, inclusion: { in: ESTADOS,
                                  message: "%{value} no es un estado valido" }

  def to_s
    semestre
  end
end
