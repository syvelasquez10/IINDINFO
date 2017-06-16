class ProfesoresController < ApplicationController
  before_action :set_profesor, only: [:show, :update, :destroy]

  # GET /profesores
  def index
    @profesores = Profesor.all

    render json: @profesores
  end

  # GET /profesores/1
  def show
    render json: @profesor
  end

  # POST /profesores
  def create
    @profesor = Profesor.new(profesor_params)

    if @profesor.save
      render json: @profesor, status: :created, location: @profesor
    else
      render json: @profesor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profesores/1
  def update
    if @profesor.update(profesor_params)
      render json: @profesor
    else
      render json: @profesor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /profesores/1
  def destroy
    @profesor.destroy
  end

  # POST /profesores/1/asignar_curso/
  # Los parametros son el id del curso curso_id
  def asignar_curso
    render :json => Profesor.asignar_curso(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profesor
      @profesor = Profesor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def profesor_params
      params.require(:profesor).permit(:nombres, :apellidos, :email, :tipo)
    end
end
