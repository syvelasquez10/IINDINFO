class Estudiante < ApplicationRecord
  has_one :monitoria1, class_name: 'Monitoria', foreign_key: 'monitoria1'
  has_one :monitoria2, class_name: 'Monitoria', foreign_key: 'monitoria2'
end
