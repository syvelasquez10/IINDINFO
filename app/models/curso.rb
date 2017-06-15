class Curso < ApplicationRecord
  belongs_to :monitoria

  validates :codigo_curso, presence: true, uniqueness: true
  validates :inscritos, presence: true, numericality: { only_integer: true }

  def to_s
    codigo_curso
  end
end
