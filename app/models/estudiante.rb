class MonitoriasValidator < ActiveModel::Validator

  # Validación de que el número de monitorias de un estudiante no sea mayor a 2
  def validate(record)
    if record.monitorias.size >= 2
      record.errors[:error] << 'Un estudiante no puede estar en más de 2 monitoria por semestre'
    end
  end
end
class Estudiante < ApplicationRecord
  has_many :monitorias
  has_many :practicas
  has_one :saberPro

  validates :carnet, presence: true, uniqueness: true
  validates :cred_sem_actual, presence: true
  validates :email, presence: true, uniqueness: true
  validates_with MonitoriasValidator, :on => :create

end