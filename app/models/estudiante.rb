class Estudiante < ApplicationRecord
  has_many :monitorias

  validates :carnet, presence: true, uniqueness: true
  validates :cred_sem_actual, presence: true
  validates :email, presence: true

end
