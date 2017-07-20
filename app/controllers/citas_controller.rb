class CitasController < ApplicationController
  before_action :set_cita, only: [:show, :update, :destroy]

  # GET /citas
  def index
    @citas = Cita.all

    render json: @citas
  end

  # GET /citas/1
  def show
    render json: @cita
  end

  # POST /citas
  def create
    @cita = Cita.new(cita_params)

    if @cita.save
      render json: @cita, status: :created, location: @cita
    else
      render json: @cita.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /citas/1
  def update
    if @cita.update(cita_params)
      render json: @cita
    else
      render json: @cita.errors, status: :unprocessable_entity
    end
  end

  # DELETE /citas/1
  def destroy
    @cita.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cita
      @cita = Cita.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cita_params
      params.require(:cita).permit(:tipo_cita, :asistio, :comentarios, :cancelada, :cancelada_por, :cancelada_por_id, :fecha_cancelacion, :informacion_para_cita, :fecha_inicio, :fecha_fin, :estudiante_id, :administrador_id)
    end
end
