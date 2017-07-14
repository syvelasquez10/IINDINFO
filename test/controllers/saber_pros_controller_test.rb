require 'test_helper'

class SaberProsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saber_pro = saber_pros(:one)
  end

  test "should get index" do
    get saber_pros_url, as: :json
    assert_response :success
  end

  test "should create saber_pro" do
    assert_difference('SaberPro.count') do
      post saber_pros_url, params: { saber_pro: { estudiante_id: @saber_pro.estudiante_id, fecha_nacimiento: @saber_pro.fecha_nacimiento, inscrito: @saber_pro.inscrito, observaciones: @saber_pro.observaciones, pago: @saber_pro.pago, tipo_documento: @saber_pro.tipo_documento } }, as: :json
    end

    assert_response 201
  end

  test "should show saber_pro" do
    get saber_pro_url(@saber_pro), as: :json
    assert_response :success
  end

  test "should update saber_pro" do
    patch saber_pro_url(@saber_pro), params: { saber_pro: { estudiante_id: @saber_pro.estudiante_id, fecha_nacimiento: @saber_pro.fecha_nacimiento, inscrito: @saber_pro.inscrito, observaciones: @saber_pro.observaciones, pago: @saber_pro.pago, tipo_documento: @saber_pro.tipo_documento } }, as: :json
    assert_response 200
  end

  test "should destroy saber_pro" do
    assert_difference('SaberPro.count', -1) do
      delete saber_pro_url(@saber_pro), as: :json
    end

    assert_response 204
  end
end
