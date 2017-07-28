class NoticiasController < ApplicationController
  before_action :set_noticia, only: [:show, :update, :destroy]

  # GET /noticias
  def index
    @noticias = Noticia.all

    render json: @noticias
  end

  # GET /noticias/1
  def show
    render json: @noticia
  end

  # POST /noticias
  def create
    @noticia = Noticia.new(noticia_params)

    if @noticia.save
      render json: @noticia, status: :created, location: @noticia
    else
      render json: @noticia.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /noticias/1
  def update
    if @noticia.update(noticia_params)
      render json: @noticia
    else
      render json: @noticia.errors, status: :unprocessable_entity
    end
  end

  # DELETE /noticias/1
  def destroy
    @noticia.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_noticia
      @noticia = Noticia.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def noticia_params
      params.require(:noticia).permit(:titulo, :texto, :semestre, :fecha, :imagen_url)
    end
end
