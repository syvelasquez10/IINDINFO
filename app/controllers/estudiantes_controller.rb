class EstudiantesController < ApplicationController
  acts_as_token_authentication_handler_for Administrador
  before_action :set_estudiante, only: [:show, :update, :destroy]

  # GET /estudiantes
  def index
    @estudiantes = Estudiante.all
    render json: @estudiantes
  end

  # GET /estudiantes/monitorias
  def estudiantes_monitorias
    @estudiantes = Estudiante.all
    estudiantes = []
    for estudiante in @estudiantes
      estudiantes.push(estudiante.as_json.merge('monitorias':estudiante.monitorias.as_json))
    end
    render json: estudiantes
  end

  # GET /estudiantes/practicas
  def estudiantes_practicas
    @estudiantes = Estudiante.all
    estudiantes = []
    for estudiante in @estudiantes
      estudiantes.push(estudiante.as_json.merge('practica':estudiante.practica.as_json))
    end
    render json: estudiantes
  end

  # GET /estudiantes/saberPro
  def estudiantes_saberpro
    @estudiantes = Estudiante.all
    estudiantes = []
    for estudiante in @estudiantes
      estudiantes.push(estudiante.as_json.merge('saberPro':estudiante.saberPro.as_json))
    end
    render json: estudiantes
  end

  # GET /estudiantes/citas
  def estudiantes_citas
    @estudiantes = Estudiante.all
    estudiantes = []
    for estudiante in @estudiantes
      estudiantes.push(estudiante.as_json.merge('citas':estudiante.citas.as_json))
    end
    render json: estudiantes
  end

  # GET /estudiantes/email?email={email}
  def find_by_email
    @estudiante = Estudiante.where(email: params[:email]).take

    render json: @estudiante.as_json.merge('monitorias':@estudiante.monitorias.as_json).merge('practica':@estudiante.practica.as_json).merge('saberPro':@estudiante.saberPro.as_json).merge('citas':@estudiante.citas.as_json)
  end

  # GET /estudiantes/1
  def show
    render json: @estudiante.as_json.merge('monitorias':@estudiante.monitorias.as_json).merge('practica':@estudiante.practica.as_json).merge('saberPro':@estudiante.saberPro.as_json).merge('citas':@estudiante.citas.as_json)
  end

  # POST /estudiantes
  def create
    @estudiante = Estudiante.new(estudiante_params)

    if @estudiante.save
      render json: @estudiante, status: :created, location: @estudiante
    else
      render json: @estudiante.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /estudiantes/1
  def update
    if @estudiante.update(estudiante_params)
      render json: @estudiante
    else
      render json: @estudiante.errors, status: :unprocessable_entity
    end
  end

  # DELETE /estudiantes/1
  def destroy
    @estudiante.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estudiante
      @estudiante = Estudiante.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def estudiante_params
      params.require(:estudiante).permit(:carnet, :apellidos, :nombres, :programa, :doble_programa, :doc_identidad, :fecha_nac, :sexo, :ciudad, :celular, :sit_academica, :cred_tomados, :cred_aprobados, :cred_pga, :prom_acum, :cred_transf, :ssc, :email, :cred_sem_actual, :reviso_informacion, :token_celular)
    end
end
