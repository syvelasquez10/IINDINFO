class Estudiante < ApplicationRecord
  has_many :monitorias, before_add: :validar_monitoria_limite

  validates :carnet, presence: true, uniqueness: true
  validates :cred_sem_actual, presence: true
  validates :email, presence: true

  private

  def validar_monitoria_limite(monitoria)
    raise Exception.new if monitorias.size >= 2
  end
end
