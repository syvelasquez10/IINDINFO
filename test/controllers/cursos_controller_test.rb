require 'test_helper'

class CursosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @curso = cursos(:one)
  end

  test "should get index" do
    get cursos_url, as: :json
    assert_response :success
  end

  test "should create curso" do
    assert_difference('Curso.count') do
      post cursos_url, params: { curso: { codigo_curso: @curso.codigo_curso, estado: @curso.estado, inscritos: @curso.inscritos, monitores_requeridos: @curso.monitores_requeridos, monitores_solicitados: @curso.monitores_solicitados, nombre_curso: @curso.nombre_curso } }, as: :json
    end

    assert_response 201
  end

  test "should show curso" do
    get curso_url(@curso), as: :json
    assert_response :success
  end

  test "should update curso" do
    patch curso_url(@curso), params: { curso: { codigo_curso: @curso.codigo_curso, estado: @curso.estado, inscritos: @curso.inscritos, monitores_requeridos: @curso.monitores_requeridos, monitores_solicitados: @curso.monitores_solicitados, nombre_curso: @curso.nombre_curso } }, as: :json
    assert_response 200
  end

  test "should destroy curso" do
    assert_difference('Curso.count', -1) do
      delete curso_url(@curso), as: :json
    end

    assert_response 204
  end
end
