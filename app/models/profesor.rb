class Profesor < ApplicationRecord
  has_many :asignaciones
  has_many :cursos, through: :asignaciones

  def self.asignar_curso(params)

  end
end
