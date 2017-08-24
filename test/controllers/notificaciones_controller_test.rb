require 'test_helper'

class NotificacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notificacion = notificaciones(:one)
  end

  test "should get index" do
    get notificaciones_url, as: :json
    assert_response :success
  end

  test "should create notificacion" do
    assert_difference('Notificacion.count') do
      post notificaciones_url, params: { notificacion: { asunto: @notificacion.asunto, contenido: @notificacion.contenido, filtro_categoria: @notificacion.filtro_categoria, filtro_estado: @notificacion.filtro_estado } }, as: :json
    end

    assert_response 201
  end

  test "should show notificacion" do
    get notificacion_url(@notificacion), as: :json
    assert_response :success
  end

  test "should update notificacion" do
    patch notificacion_url(@notificacion), params: { notificacion: { asunto: @notificacion.asunto, contenido: @notificacion.contenido, filtro_categoria: @notificacion.filtro_categoria, filtro_estado: @notificacion.filtro_estado } }, as: :json
    assert_response 200
  end

  test "should destroy notificacion" do
    assert_difference('Notificacion.count', -1) do
      delete notificacion_url(@notificacion), as: :json
    end

    assert_response 204
  end
end
