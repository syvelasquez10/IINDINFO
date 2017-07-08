class Profesor < ApplicationRecord
  has_many :asignaciones
  has_many :cursos, through: :asignaciones

  # Lista de posibles estados que puede tomar el tipo de profesor
  ESTADOS = ['Profesor',
             'Asistente',
             'Profesor Asignador',
             'Asistente Asignador'].freeze

  validates :tipo, inclusion: { in: ESTADOS,
                                  message: "%{value} no es un estado valido" }

  validates :email, presence: true, uniqueness: true

  # Metodo creado para crear una relación entre un curso y un profesor
  # Se crea un registro en la tabla Asignacion que representa la relación curso-profesor
  def self.asignar_curso(params)
    Asignacion.create({curso_id:params[:curso_id],profesor_id:params[:id]})
  end
end
