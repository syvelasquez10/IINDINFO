class MonitoriasValidator < ActiveModel::Validator
  def validate(record)
    if record.monitorias.size >= 2
      record.errors[:error] << 'Un estudiante no puede estar en más de 2 monitoria por semestre'
    end
  end
end
class Estudiante < ApplicationRecord
  has_many :monitorias

  validates :carnet, presence: true, uniqueness: true
  validates :cred_sem_actual, presence: true
  validates :email, presence: true

end