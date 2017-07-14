class HorariosController < ApplicationController
  before_action :set_horario, only: [:show, :update, :destroy]

  # GET /horarios
  def index
    @horarios = Horario.all

    render json: @horarios
  end

  # GET /horarios/1
  def show
    render json: @horario
  end

  # POST /horarios
  def create
    @horario = Horario.new(horario_params)

    if @horario.save
      render json: @horario, status: :created, location: @horario
    else
      render json: @horario.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /horarios/1
  def update
    if @horario.update(horario_params)
      render json: @horario
    else
      render json: @horario.errors, status: :unprocessable_entity
    end
  end

  # DELETE /horarios/1
  def destroy
    @horario.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def horario_params
      params.require(:horario).permit(:fecha_inicio, :fecha_fin, :disponible, :administrador_id, :tipo_cita)
    end
end
