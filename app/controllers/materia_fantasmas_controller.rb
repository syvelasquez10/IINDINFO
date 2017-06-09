class MateriaFantasmasController < ApplicationController
  before_action :set_materia_fantasma, only: [:show, :update, :destroy]

  # GET /materia_fantasmas
  def index
    @materia_fantasmas = MateriaFantasma.all

    render json: @materia_fantasmas
  end

  # GET /materia_fantasmas/1
  def show
    render json: @materia_fantasma
  end

  # POST /materia_fantasmas
  def create
    @materia_fantasma = MateriaFantasma.new(materia_fantasma_params)

    if @materia_fantasma.save
      render json: @materia_fantasma, status: :created, location: @materia_fantasma
    else
      render json: @materia_fantasma.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /materia_fantasmas/1
  def update
    if @materia_fantasma.update(materia_fantasma_params)
      render json: @materia_fantasma
    else
      render json: @materia_fantasma.errors, status: :unprocessable_entity
    end
  end

  # DELETE /materia_fantasmas/1
  def destroy
    @materia_fantasma.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia_fantasma
      @materia_fantasma = MateriaFantasma.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def materia_fantasma_params
      params.require(:materia_fantasma).permit(:codigo)
    end
end
