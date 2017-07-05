require 'test_helper'

class PracticasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @practica = practicas(:one)
  end

  test "should get index" do
    get practicas_url, as: :json
    assert_response :success
  end

  test "should create practica" do
    assert_difference('Practica.count') do
      post practicas_url, params: { practica: { charla: @practica.charla, comentarios: @practica.comentarios, estudiante_id: @practica.estudiante_id, semestre: @practica.semestre } }, as: :json
    end

    assert_response 201
  end

  test "should show practica" do
    get practica_url(@practica), as: :json
    assert_response :success
  end

  test "should update practica" do
    patch practica_url(@practica), params: { practica: { charla: @practica.charla, comentarios: @practica.comentarios, estudiante_id: @practica.estudiante_id, semestre: @practica.semestre } }, as: :json
    assert_response 200
  end

  test "should destroy practica" do
    assert_difference('Practica.count', -1) do
      delete practica_url(@practica), as: :json
    end

    assert_response 204
  end
end
