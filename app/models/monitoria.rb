class Monitoria < ApplicationRecord
  belongs_to :estudiante, foreign_key: true
end
