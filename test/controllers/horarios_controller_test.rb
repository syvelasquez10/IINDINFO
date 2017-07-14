require 'test_helper'

class HorariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @horario = horarios(:one)
  end

  test "should get index" do
    get horarios_url, as: :json
    assert_response :success
  end

  test "should create horario" do
    assert_difference('Horario.count') do
      post horarios_url, params: { horario: { administrador_id: @horario.administrador_id, disponible: @horario.disponible, fecha_fin: @horario.fecha_fin, fecha_inicio: @horario.fecha_inicio } }, as: :json
    end

    assert_response 201
  end

  test "should show horario" do
    get horario_url(@horario), as: :json
    assert_response :success
  end

  test "should update horario" do
    patch horario_url(@horario), params: { horario: { administrador_id: @horario.administrador_id, disponible: @horario.disponible, fecha_fin: @horario.fecha_fin, fecha_inicio: @horario.fecha_inicio } }, as: :json
    assert_response 200
  end

  test "should destroy horario" do
    assert_difference('Horario.count', -1) do
      delete horario_url(@horario), as: :json
    end

    assert_response 204
  end
end
