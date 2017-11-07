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

    # Se revisa si se puede crear la monitoria
    @monitoria = Monitoria.new(monitoria_params)

    # Si hay errores al crearla se informa, de lo contrario se procede a crearla
    if !@monitoria.errors.present?
      @monitoria.destroy
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

      # Esta revision buscar ver si el estudiante ya tiene otra solicitud de monitoria
      segunda_monitoria = estudiante.monitorias[0]

      # Se revisa si el promedio del estudiante cumple para la monitoria
      # Dependiendo del promedio se le asigna un estado a la monitoria
      # Se revisa si el número de créditos inscritos le permite tener una monitoria. Si ya tiene otra solicitud de monitoria entonces el número de créditos disponibles debe ser mayor
      if estudiante['prom_acum'] >= Monitoria::PROMEDIO && ((segunda_monitoria.present? && estudiante['cred_sem_actual'] <= Monitoria::CREDITOS_DOS) || (!segunda_monitoria.present? && estudiante['cred_sem_actual'] <= Monitoria::CREDITOS_UNA))
        # Los estados son de la lista de estados que se encuentra en monitoria.rb
        params['monitoria']['estado'] = Monitoria::ESTADOS[1]
      else
        params['monitoria']['estado'] = Monitoria::ESTADOS[2]
      end

      # Si tiene otra monitoria se actualiza para esa el valor de estado segunda monitoria
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
    else
      render json: @monitoria.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /monitorias/1
  def update
    estado = -1
    # Si la monitoria se cambia a estado Aprobado por Promedio
    if params['estado'] == Monitoria::ESTADOS[1]
      @monitoria['doble_monitor'] != ''
      @monitoria['nombre_profesor'] = ''
      estado = 1
    elsif params['estado'] == Monitoria::ESTADOS[2]
      estado = 2
    elsif params['estado'] == Monitoria::ESTADOS[3]
      estado = 3
    elsif params['estado'] == Monitoria::ESTADOS[4]
      estado = 4
    elsif params['estado'] == Monitoria::ESTADOS[5]
      estado = 5
    elsif params['estado'] == Monitoria::ESTADOS[6]
      estado = 6
    elsif params['estado'] == Monitoria::ESTADOS[7]
      estado = 7
    elsif params['estado'] == Monitoria::ESTADOS[8]
      estado = 8
    elsif params['estado'] == Monitoria::ESTADOS[9]
      estado = 9
    elsif params['estado'] == Monitoria::ESTADOS[10]
      estado = 10
    elsif params['estado'] == Monitoria::ESTADOS[11]
      estado = 11
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

  # POST /monitorias/aceptar
  def aceptar_monitorias
    mensaje = 'Modificación de estado de monitorias no valida, debido a falta de parametros necesarios para hacerla'
    if params['estado_uno'].present? && params['estado_dos'].present? && params['estado_uno'] == Monitoria::ESTADOS[4] && params['estado_dos'] == Monitoria::ESTADOS[4]
      mensaje = 'No se pueden aceptar 2 monitorias dobles'
    elsif params['estado_uno'].present? && params['estado_dos'].present? && ((params['estado_uno'] == Monitoria::ESTADOS[4] && params['estado_dos'] == Monitoria::ESTADOS[3]) || (params['estado_uno'] == Monitoria::ESTADOS[3] && params['estado_dos'] == Monitoria::ESTADOS[4]))
      mensaje = 'No se pueden aceptar una monitoria doble y una sencilla'
    elsif params['estado_uno'].present? && params['estudiante_id'].present? && params['monitoria_uno_id'].present?
      estudiante = Estudiante.find(params['estudiante_id'])

      monitorias = estudiante.monitorias

      # Se revisa si el estudiante tiene monitorias
      if monitorias.present? && monitorias.size > 1
        # Si tiene solo 1 monitoria se cambia el estado, pero si tiene 2 se debe hacer más procesos
        if monitorias.size > 2 && params['monitoria_dos_id'].present? && (monitorias[0]['id'] == params['monitoria_uno_id'] && monitorias[1]['id'] == params['monitoria_dos_id'])
          monitorias[0]['estado'] = params['estado_uno']
          monitorias[0].update(monitorias[0].attributes)
          monitorias[1]['estado'] = params['estado_uno']
          monitorias[1].update(monitorias[1].attributes)
          mensaje = 'Cambio exitoso en el estado de las monitorias'
        elsif monitorias[0]['id'] == params['monitoria_uno_id']
          monitorias[0]['estado'] = params['estado_uno']
          monitorias[0].update(monitorias[0].attributes)
          mensaje = 'Cambio exitoso en el estado de la monitoria'
        else
          mensaje = 'Alguno de los parametros enviados no corresponde. Vuelva a intentarlo'
        end
      end
    end

    render json: {mensaje:mensaje}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monitoria
      @monitoria = Monitoria.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def monitoria_params
      params.require(:monitoria).permit(:estado, :notificaciones, :nota_curso, :estudiante_id, :curso_id, :semestre_curso, :comentarios, :semestre, :doble_monitor, :nombre_profesor, :segundo_curso, :monitoria_otro_departamento, :nota_monitoria, :entrego_documentos, :firmo_convenio, :estado_segundo_curso)
    end

    # Only allow a trusted parameter "white list" through.
    def estudiante_params
      params.require(:estudiante).permit(:carnet, :apellidos, :nombres, :programa, :doble_programa, :doc_identidad, :fecha_nac, :sexo, :ciudad, :celular, :sit_academica, :cred_tomados, :cred_aprobados, :cred_pga, :prom_acum, :cred_transf, :ssc, :email, :cred_sem_actual, :reviso_informacion,:token_celular)
    end
end
