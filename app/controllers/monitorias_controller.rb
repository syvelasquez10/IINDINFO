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
    render json: @monitoria.as_json.merge('estudiante':@monitoria.estudiante.as_json).merge('curso':@monitoria.curso.as_json)
  end

  # POST /monitorias
  def create
      if !params['estudiante_id'].present?
        estudiante = Estudiante.where(carnet:params['estudiante']['carnet']).take
        if !estudiante.present?
          puts json: params['estudiante']
          estudiante = Estudiante.create(estudiante_params)
        end
        params['monitoria']['estudiante_id'] = estudiante['id']
      else
        estudiante = Estudiante.find(params['estudiante_id'])
        monitoria_estudiante = estudiante.monitorias[0]
        if monitoria_estudiante.present?
          monitoria_estudiante['segundo_curso'] = params['nombre_curso']
          Monitoria.find(monitoria_estudiante['id']).update(monitoria_estudiante)
        end
      end
      @monitoria = Monitoria.new(monitoria_params)
      if @monitoria.save
        render json: @monitoria, status: :created, location: @monitoria
      else
        render json: @monitoria.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /monitorias/1
  def update
    if params['estado'] == Monitoria::ESTADOS[4]
      @monitoria['doble_monitor'] = true
      # @monitoria['segundo_curso'] = Curso.find(@monitoria['curso_id'])['nombre_curso']
    elsif params['estado'] == Monitoria::ESTADOS[3]
      @monitoria['doble_monitor'] = false
      # @monitoria['segundo_curso'] = ''
    elsif params['estado'] == Monitoria::ESTADOS[5]

    end
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

  # GET /estudiantes/estado?estado=''
  def find_by_estado
    monitorias = Monitoria.where(estado: params[:estado])

    render json: monitorias
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monitoria
      @monitoria = Monitoria.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def monitoria_params
      params.require(:monitoria).permit(:estado, :notificaciones, :nota_curso, :estudiante_id, :curso_id, :semestre_curso, :doble_monitor, :nombre_profesor, :segundo_curso)
    end

    # Only allow a trusted parameter "white list" through.
    def estudiante_params
      params.require(:estudiante).permit(:carnet, :nombres, :programa, :celular, :prom_acum, :email, :cred_sem_actual)
    end
end
