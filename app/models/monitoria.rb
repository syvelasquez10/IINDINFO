class Monitoria < ApplicationRecord
  belongs_to :estudiante
  has_one :curso
end
