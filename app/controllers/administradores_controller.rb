class AdministradoresController < ApplicationController
  before_action :set_administrador, only: [:show, :update, :destroy]

  # GET /administradores
  def index
    @administradores = Administrador.all

    render json: @administradores
  end

  # GET /administradores/1
  def show
    render json: @administrador
  end

  # POST /administradores
  def create
    @administrador = Administrador.new(administrador_params)

    if @administrador.save
      render json: @administrador, status: :created, location: @administrador
    else
      render json: @administrador.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /administradores/1
  def update
    if @administrador.update(administrador_params)
      render json: @administrador
    else
      render json: @administrador.errors, status: :unprocessable_entity
    end
  end

  # DELETE /administradores/1
  def destroy
    @administrador.destroy
  end

  # GET /administradores/cargar_archivo_estudiantes
  def cargar_archivo_estudiantes
    render :json => Administrador.import_estudiantes(params[:file])
  end

  # GET /administradores/cargar_archivo_cursos
  def cargar_archivo_cursos
    render :json => Administrador.import_cursos(params[:file])
  end

  # GET /administradores/cargar_archivo_profesores
  def cargar_archivo_profesores
    render :json => Administrador.import_profesores(params[:file])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrador
      @administrador = Administrador.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def administrador_params
      params.require(:administrador).permit(:nombres, :apellidos, :email)
    end
end
