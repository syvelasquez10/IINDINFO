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
  has_one :practica
  has_one :saberPro
  has_many :citas

  validates :carnet, presence: true, uniqueness: true
  validates :carnet, length: { is: 9 ,
                               message: "No es un número de carnet valido" }
  validates :fecha_nac, format: { with: /(19|20)\d{2}[-](0?[1-9]|[12]\d|3[01])[-](0?[1-9]|1[0-2])/,
                                    message: "No es un formato de fecha permitido" }
  validates :cred_sem_actual, presence: true
  validates :email, presence: true, uniqueness: true
  validates_with MonitoriasValidator, :on => :create

end