class Estudiante < ApplicationRecord
  has_one :monitoria1, class_name: 'Monitoria', foreign_key: 'monitoria1'
  has_one :monitoria2, class_name: 'Monitoria', foreign_key: 'monitoria2'

  validates :carnet, presence: true, uniqueness: true
  validates :cred_sem_actual, presence: true
  validates :email, presence: true

end
