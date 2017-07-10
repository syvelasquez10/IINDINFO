class PracticasController < ApplicationController
  before_action :set_practica, only: [:show, :update, :destroy]

  PROMEDIO_PRACTICA = 3.3
  SEMESTRE_MINIMO_PRACTICA = 4

  # GET /practicas
  def index
    @practicas = Practica.all
    practicas = []
    for practica in @practicas
      practicas.push(practica.as_json.merge('estudiante':practica.estudiante.as_json))
    end
    render json: practicas
  end

  # GET /practicas/1
  def show
    render json: @practica.as_json.merge('estudiante':@monitoria.estudiante.as_json)
  end

  # POST /practicas
  def create
    estudiante = Estudiante.find(practica_params['estudiante_id'])
    if estudiante['promedio'] < PROMEDIO_PRACTICA
      respuesta = 'El promedio para aplicar a práctica debe ser mayor a %s' % [PROMEDIO_PRACTICA]
      render json: {:error => respuesta}
    elsif estudiante['ssc'] < SEMESTRE_MINIMO_PRACTICA
      respuesta = 'Para hacer práctica se debe estar en un semestre mayor o igual a %s' % [SEMESTRE_MINIMO_PRACTICA]
      render json: {:error => respuesta}
    else
      @practica = Practica.new(practica_params)

      if @practica.save
        render json: @practica, status: :created, location: @practica
      else
        render json: @practica.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /practicas/1
  def update
    if @practica.update(practica_params)
      render json: @practica
    else
      render json: @practica.errors, status: :unprocessable_entity
    end
  end

  # DELETE /practicas/1
  def destroy
    @practica.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practica
      @practica = Practica.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def practica_params
      params.require(:practica).permit(:semestre, :charla, :comentarios, :estudiante_id, :estado)
    end
end
