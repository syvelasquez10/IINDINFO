require 'test_helper'

class CitasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cita = citas(:one)
  end

  test "should get index" do
    get citas_url, as: :json
    assert_response :success
  end

  test "should create cita" do
    assert_difference('Cita.count') do
      post citas_url, params: { cita: { asistio: @cita.asistio, cancelada: @cita.cancelada, cancelada_por: @cita.cancelada_por, cancelada_por_id: @cita.cancelada_por_id, comentarios: @cita.comentarios, fecha_cancelacion: @cita.fecha_cancelacion, hora_fin: @cita.hora_fin, hora_inicio: @cita.hora_inicio, informacion_para_cita: @cita.informacion_para_cita, tipo_cita: @cita.tipo_cita } }, as: :json
    end

    assert_response 201
  end

  test "should show cita" do
    get cita_url(@cita), as: :json
    assert_response :success
  end

  test "should update cita" do
    patch cita_url(@cita), params: { cita: { asistio: @cita.asistio, cancelada: @cita.cancelada, cancelada_por: @cita.cancelada_por, cancelada_por_id: @cita.cancelada_por_id, comentarios: @cita.comentarios, fecha_cancelacion: @cita.fecha_cancelacion, hora_fin: @cita.hora_fin, hora_inicio: @cita.hora_inicio, informacion_para_cita: @cita.informacion_para_cita, tipo_cita: @cita.tipo_cita } }, as: :json
    assert_response 200
  end

  test "should destroy cita" do
    assert_difference('Cita.count', -1) do
      delete cita_url(@cita), as: :json
    end

    assert_response 204
  end
end
