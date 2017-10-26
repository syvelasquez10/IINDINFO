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
      # Se revisa si se quiere crear una monitoria para un estudiante que no existe
      # Si el parametro estudiante_id no se encuentra en el body se asume que se quiere crear una monitoria para un estudiante que no existe
      if !params['estudiante_id'].present?
        # Se revisa si ya existe un estudiante con el carnet enviado
        # Este caso es aquel en el que el estudiante ya existe, pero por algun motivo no puede aplicar el mismo a la monitoria
        estudiante = Estudiante.where(carnet:params['estudiante']['carnet']).take
        if !estudiante.present?
          # Si no existe un estudiante con ese carnet entonces se crea uno
          estudiante = Estudiante.create(estudiante_params)
        end
        # Se agrega el id del estudiante a la monitoria para que se prosiga con normalidad
        params['monitoria']['estudiante_id'] = estudiante['id']
      end

      # El estudiante se necesita para dos revisiones mas adelante
      # Con el if nos aseguramos que tenemos algo en la variable estudiante
      if !estudiante.present?
        estudiante = Estudiante.find(params['estudiante_id'])
      end

      # Se revisa si el promedio del estudiante cumple para la monitoria
      # Dependiendo del promedio se le asigna un estado a la monitoria
      if estudiante['prom_acum'] < 3.5
        # Los estados son de la lista de estados que se encuentra en monitoria.rb
        params['monitoria']['estado'] = Monitoria::ESTADOS[2]
      else
        params['monitoria']['estado'] = Monitoria::ESTADOS[1]
      end

      # Esta revision buscar ver si el estudiante ya tiene otra monitoria aprobada
      segunda_monitoria = estudiante.monitorias[0]
      if segunda_monitoria.present?
        segunda_monitoria['segundo_curso'] = params['monitoria']['nombre_curso']
        segunda_monitoria['estado_segundo_curso'] = params['monitoria']['estado']
        # monitoria_estudiante['doble_monitor'] = true
        segunda_monitoria.update(segunda_monitoria.attributes)

        # params['monitoria']['doble_monitor'] = true
        params['monitoria']['segundo_curso'] = Curso.find(segunda_monitoria['curso_id'])['nombre_curso']
        params['monitoria']['estado_segundo_curso'] = segunda_monitoria['estado']
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
    estado = -1
    # Si el estado al que se cambia la monitoria es a seleccionado por el profesor
    if params['estado'] == Monitoria::ESTADOS[1]
      @monitoria['doble_monitor'] != ''
      @monitoria['nombre_profesor'] = ''
      estado = 1
    elsif params['estado'] == Monitoria::ESTADOS[2]
      estado = 2
    elsif params['estado'] == Monitoria::ESTADOS[3]
      @monitoria['doble_monitor'] = ''
      @monitoria['nombre_profesor'] = ''
      estado = 3
    elsif params['estado'] == Monitoria::ESTADOS[4]
      @monitoria['doble_monitor'] = true
      estado = 4
    elsif params['estado'] == Monitoria::ESTADOS[5]
      @monitoria['doble_monitor'] != ''
      estado = 5
    elsif params['estado'] == Monitoria::ESTADOS[6]
      estado = 6
    elsif params['estado'] == Monitoria::ESTADOS[7]
      estado = 7
    elsif params['estado'] == Monitoria::ESTADOS[8]
      estado = 8
    end

    if estado != -1
      Monitoria.actualizar_estado_segundo_curso(@monitoria,Monitoria::ESTADOS[estado])
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

  # GET /monitorias/estado?estado=''
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
      params.require(:monitoria).permit(:estado, :notificaciones, :nota_curso, :estudiante_id, :curso_id, :semestre_curso, :comentarios, :semestre, :doble_monitor, :nombre_profesor, :segundo_curso, :monitoria_otro_departamento, :nota_monitoria, :entrego_documentos, :firmo_convenio, :estado, :estado_segundo_curso)
    end

    # Only allow a trusted parameter "white list" through.
    def estudiante_params
      params.require(:estudiante).permit(:carnet, :nombres, :programa, :celular, :prom_acum, :email, :cred_sem_actual)
    end
end
