require 'test_helper'

class AdministradoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrador = administradores(:one)
  end

  test "should get index" do
    get administradores_url, as: :json
    assert_response :success
  end

  test "should create administrador" do
    assert_difference('Administrador.count') do
      post administradores_url, params: { administrador: { apellidos: @administrador.apellidos, email: @administrador.email, nombres: @administrador.nombres } }, as: :json
    end

    assert_response 201
  end

  test "should show administrador" do
    get administrador_url(@administrador), as: :json
    assert_response :success
  end

  test "should update administrador" do
    patch administrador_url(@administrador), params: { administrador: { apellidos: @administrador.apellidos, email: @administrador.email, nombres: @administrador.nombres } }, as: :json
    assert_response 200
  end

  test "should destroy administrador" do
    assert_difference('Administrador.count', -1) do
      delete administrador_url(@administrador), as: :json
    end

    assert_response 204
  end
end
