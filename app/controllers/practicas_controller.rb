class PracticasController < ApplicationController
  before_action :set_practica, only: [:show, :update, :destroy]

  # GET /practicas
  def index
    @practicas = Practica.all

    render json: @practicas
  end

  # GET /practicas/1
  def show
    render json: @practica
  end

  # POST /practicas
  def create
    @practica = Practica.new(practica_params)

    if @practica.save
      render json: @practica, status: :created, location: @practica
    else
      render json: @practica.errors, status: :unprocessable_entity
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
      params.require(:practica).permit(:semestre, :charla, :comentarios, :estudiante_id)
    end
end
