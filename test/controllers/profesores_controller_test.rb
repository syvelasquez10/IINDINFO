require 'test_helper'

class ProfesoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profesor = profesores(:one)
  end

  test "should get index" do
    get profesores_url, as: :json
    assert_response :success
  end

  test "should create profesor" do
    assert_difference('Profesor.count') do
      post profesores_url, params: { profesor: { apellidos: @profesor.apellidos, email: @profesor.email, nombres: @profesor.nombres, tipo: @profesor.tipo } }, as: :json
    end

    assert_response 201
  end

  test "should show profesor" do
    get profesor_url(@profesor), as: :json
    assert_response :success
  end

  test "should update profesor" do
    patch profesor_url(@profesor), params: { profesor: { apellidos: @profesor.apellidos, email: @profesor.email, nombres: @profesor.nombres, tipo: @profesor.tipo } }, as: :json
    assert_response 200
  end

  test "should destroy profesor" do
    assert_difference('Profesor.count', -1) do
      delete profesor_url(@profesor), as: :json
    end

    assert_response 204
  end
end
