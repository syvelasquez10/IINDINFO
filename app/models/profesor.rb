class Profesor < ApplicationRecord
  has_many :asignaciones
  has_many :cursos, through: :asignaciones

  def self.asignar_curso(params)
    Asignacion.create({curso_id:params[:curso_id],profesor_id:params[:profesor_id]})
  end
end
