require 'test_helper'

class NoticiasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @noticia = noticias(:one)
  end

  test "should get index" do
    get noticias_url, as: :json
    assert_response :success
  end

  test "should create noticia" do
    assert_difference('Noticia.count') do
      post noticias_url, params: { noticia: { fecha: @noticia.fecha, semestre: @noticia.semestre, texto: @noticia.texto, titulo: @noticia.titulo } }, as: :json
    end

    assert_response 201
  end

  test "should show noticia" do
    get noticia_url(@noticia), as: :json
    assert_response :success
  end

  test "should update noticia" do
    patch noticia_url(@noticia), params: { noticia: { fecha: @noticia.fecha, semestre: @noticia.semestre, texto: @noticia.texto, titulo: @noticia.titulo } }, as: :json
    assert_response 200
  end

  test "should destroy noticia" do
    assert_difference('Noticia.count', -1) do
      delete noticia_url(@noticia), as: :json
    end

    assert_response 204
  end
end
