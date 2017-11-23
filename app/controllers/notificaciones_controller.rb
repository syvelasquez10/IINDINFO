class NotificacionesController < ApplicationController
  before_action :set_notificacion, only: [:show, :update, :destroy]

  # GET /notificaciones
  def index
    @notificaciones = Notificacion.all

    render json: @notificaciones
  end

  # GET /notificaciones/1
  def show
    render json: @notificacion
  end

  # POST /notificaciones
  def create
    @notificacion = Notificacion.new(notificacion_params)
    Notificacion.enviar_mensaje(params)
    if @notificacion.save
      render json: @notificacion, status: :created, location: @notificacion
    else
      render json: @notificacion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notificaciones/1
  def update
    if @notificacion.update(notificacion_params)
      render json: @notificacion
    else
      render json: @notificacion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notificaciones/1
  def destroy
    @notificacion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notificacion
      @notificacion = Notificacion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notificacion_params
      params.require(:notificacion).permit(:asunto, :contenido, :filtro_categoria, :filtro_estado)
    end
end
