class Estudiante < ApplicationRecord
  has_one :monitoria, foreign_key: 'monitoria_id1'
  has_one :monitoria, foreign_key: 'monitoria_id2'

  validates :carnet, presence: true, uniqueness: true
  validates :cred_sem_actual, presence: true
  validates :email, presence: true

end
