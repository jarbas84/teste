require 'test_helper'

class ExtratosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extrato = extratos(:one)
  end

  test "should get index" do
    get extratos_url
    assert_response :success
  end

  test "should get new" do
    get new_extrato_url
    assert_response :success
  end

  test "should create extrato" do
    assert_difference('Extrato.count') do
      post extratos_url, params: { extrato: { historico: @extrato.historico, id_user: @extrato.id_user } }
    end

    assert_redirected_to extrato_url(Extrato.last)
  end

  test "should show extrato" do
    get extrato_url(@extrato)
    assert_response :success
  end

  test "should get edit" do
    get edit_extrato_url(@extrato)
    assert_response :success
  end

  test "should update extrato" do
    patch extrato_url(@extrato), params: { extrato: { historico: @extrato.historico, id_user: @extrato.id_user } }
    assert_redirected_to extrato_url(@extrato)
  end

  test "should destroy extrato" do
    assert_difference('Extrato.count', -1) do
      delete extrato_url(@extrato)
    end

    assert_redirected_to extratos_url
  end
end
