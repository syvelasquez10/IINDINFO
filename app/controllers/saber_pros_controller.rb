class SaberProsController < ApplicationController
  before_action :set_saber_pro, only: [:show, :update, :destroy]

  # GET /saber_pros
  def index
    @saber_pros = SaberPro.all

    render json: @saber_pros
  end

  # GET /saber_pros/1
  def show
    render json: @saber_pro
  end



  # POST /saber_pros/cargar_archivo_pagos
  def cargar_archivo_pagos
    render :json => SaberPro.cargar_archivo_pagos(params[:file])
  end

  # POST /saber_pros
  def create
    saberPro = SaberPro.where(estudiante_id: saber_pro_params['estudiante_id'])
    if !saberPro.present?
      @saber_pro = SaberPro.new(saber_pro_params)

      if @saber_pro.save
        render json: @saber_pro, status: :created, location: @saber_pro
      else
        render json: @saber_pro.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => 'Este estudiante ya tiene una aplicación a saber pro'}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /saber_pros/1
  def update
    if @saber_pro.update(saber_pro_params)
      render json: @saber_pro
    else
      render json: @saber_pro.errors, status: :unprocessable_entity
    end
  end

  # DELETE /saber_pros/1
  def destroy
    @saber_pro.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saber_pro
      @saber_pro = SaberPro.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def saber_pro_params
      params.require(:saber_pro).permit(:tipo_documento, :fecha_nacimiento, :pago, :observaciones, :inscrito, :estudiante_id)
    end
end
