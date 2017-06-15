class Profesor < ApplicationRecord
  has_many :cursos, through: :cartelera_cursos

end
