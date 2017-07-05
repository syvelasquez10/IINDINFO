class Practica < ApplicationRecord
  belongs_to :estudiante

  def to_s
    semestre
  end
end
