require 'test_helper'

class EstudiantesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estudiante = estudiantes(:one)
  end

  test "should get index" do
    get estudiantes_url, as: :json
    assert_response :success
  end

  test "should create estudiante" do
    assert_difference('Estudiante.count') do
      post estudiantes_url, params: { estudiante: { apellidos: @estudiante.apellidos, carnet: @estudiante.carnet, celular: @estudiante.celular, ciudad: @estudiante.ciudad, cred_aprobados: @estudiante.cred_aprobados, cred_pga: @estudiante.cred_pga, cred_sem_actual: @estudiante.cred_sem_actual, cred_tomados: @estudiante.cred_tomados, cred_transf: @estudiante.cred_transf, doble_programa: @estudiante.doble_programa, doc_identidad: @estudiante.doc_identidad, email: @estudiante.email, fecha_nac: @estudiante.fecha_nac, nombres: @estudiante.nombres, programa: @estudiante.programa, prom_acum: @estudiante.prom_acum, sexo: @estudiante.sexo, sit_academica: @estudiante.sit_academica, ssc: @estudiante.ssc } }, as: :json
    end

    assert_response 201
  end

  test "should show estudiante" do
    get estudiante_url(@estudiante), as: :json
    assert_response :success
  end

  test "should update estudiante" do
    patch estudiante_url(@estudiante), params: { estudiante: { apellidos: @estudiante.apellidos, carnet: @estudiante.carnet, celular: @estudiante.celular, ciudad: @estudiante.ciudad, cred_aprobados: @estudiante.cred_aprobados, cred_pga: @estudiante.cred_pga, cred_sem_actual: @estudiante.cred_sem_actual, cred_tomados: @estudiante.cred_tomados, cred_transf: @estudiante.cred_transf, doble_programa: @estudiante.doble_programa, doc_identidad: @estudiante.doc_identidad, email: @estudiante.email, fecha_nac: @estudiante.fecha_nac, nombres: @estudiante.nombres, programa: @estudiante.programa, prom_acum: @estudiante.prom_acum, sexo: @estudiante.sexo, sit_academica: @estudiante.sit_academica, ssc: @estudiante.ssc } }, as: :json
    assert_response 200
  end

  test "should destroy estudiante" do
    assert_difference('Estudiante.count', -1) do
      delete estudiante_url(@estudiante), as: :json
    end

    assert_response 204
  end
end
