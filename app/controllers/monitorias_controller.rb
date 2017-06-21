class MonitoriasController < ApplicationController
  before_action :set_monitoria, only: [:show, :update, :destroy]

  # GET /monitorias
  def index
    @monitorias = Monitoria.all
    monitorias = []
    for monitoria in @monitorias
      monitorias.push(monitoria.as_json.merge('estudiante':monitoria.estudiante.as_json).merge('curso':monitoria.curso.as_json))
    end
    render json: monitorias
  end

  # GET /monitorias/1
  def show
    render json: @monitoria.as_json.merge('estudiante':@monitoria.estudiante.as_json)
  end

  # POST /monitorias
  def create
      @monitoria = Monitoria.new(monitoria_params)
      if @monitoria.save
        render json: @monitoria, status: :created, location: @monitoria
      else
        render json: @monitoria.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /monitorias/1
  def update
    if @monitoria.update(monitoria_params)
      render json: @monitoria
    else
      render json: @monitoria.errors, status: :unprocessable_entity
    end
  end

  # DELETE /monitorias/1
  def destroy
    @monitoria.destroy
    render json: { mensaje:"La monitoria ha sido eliminada"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monitoria
      @monitoria = Monitoria.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def monitoria_params
      params.require(:monitoria).permit(:estado, :notificaciones, :nota_curso, :estudiante_id, :curso_id, :semestre_curso)
    end
end
