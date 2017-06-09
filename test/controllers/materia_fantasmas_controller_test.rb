require 'test_helper'

class MateriaFantasmasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @materia_fantasma = materia_fantasmas(:one)
  end

  test "should get index" do
    get materia_fantasmas_url, as: :json
    assert_response :success
  end

  test "should create materia_fantasma" do
    assert_difference('MateriaFantasma.count') do
      post materia_fantasmas_url, params: { materia_fantasma: { codigo: @materia_fantasma.codigo } }, as: :json
    end

    assert_response 201
  end

  test "should show materia_fantasma" do
    get materia_fantasma_url(@materia_fantasma), as: :json
    assert_response :success
  end

  test "should update materia_fantasma" do
    patch materia_fantasma_url(@materia_fantasma), params: { materia_fantasma: { codigo: @materia_fantasma.codigo } }, as: :json
    assert_response 200
  end

  test "should destroy materia_fantasma" do
    assert_difference('MateriaFantasma.count', -1) do
      delete materia_fantasma_url(@materia_fantasma), as: :json
    end

    assert_response 204
  end
end
