require 'test_helper'

class MonitoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monitoria = monitorias(:one)
  end

  test "should get index" do
    get monitorias_url, as: :json
    assert_response :success
  end

  test "should create monitoria" do
    assert_difference('Monitoria.count') do
      post monitorias_url, params: { monitoria: { estado: @monitoria.estado, estudiante_id: @monitoria.estudiante_id, nota_curso: @monitoria.nota_curso, notificaciones: @monitoria.notificaciones } }, as: :json
    end

    assert_response 201
  end

  test "should show monitoria" do
    get monitoria_url(@monitoria), as: :json
    assert_response :success
  end

  test "should update monitoria" do
    patch monitoria_url(@monitoria), params: { monitoria: { estado: @monitoria.estado, estudiante_id: @monitoria.estudiante_id, nota_curso: @monitoria.nota_curso, notificaciones: @monitoria.notificaciones } }, as: :json
    assert_response 200
  end

  test "should destroy monitoria" do
    assert_difference('Monitoria.count', -1) do
      delete monitoria_url(@monitoria), as: :json
    end

    assert_response 204
  end
end
