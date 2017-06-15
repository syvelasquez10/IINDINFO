class Cartelera_cursos < ApplicationRecord
  belongs_to :curso
  belongs_to :profesor
end
