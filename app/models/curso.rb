class Curso < ApplicationRecord
  has_many :monitorias
  has_many :asignaciones
  has_many :profesores, through: :asignaciones

  validates :codigo_curso, presence: true, uniqueness: true
  validates :inscritos, presence: true, numericality: { only_integer: true }

  def to_s
    codigo_curso
  end
end
