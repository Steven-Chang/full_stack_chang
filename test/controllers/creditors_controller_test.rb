require 'test_helper'

class CreditorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @creditor = creditors(:one)
  end

  test "should get index" do
    get creditors_url
    assert_response :success
  end

  test "should get new" do
    get new_creditor_url
    assert_response :success
  end

  test "should create creditor" do
    assert_difference('Creditor.count') do
      post creditors_url, params: { creditor: {  } }
    end

    assert_redirected_to creditor_url(Creditor.last)
  end

  test "should show creditor" do
    get creditor_url(@creditor)
    assert_response :success
  end

  test "should get edit" do
    get edit_creditor_url(@creditor)
    assert_response :success
  end

  test "should update creditor" do
    patch creditor_url(@creditor), params: { creditor: {  } }
    assert_redirected_to creditor_url(@creditor)
  end

  test "should destroy creditor" do
    assert_difference('Creditor.count', -1) do
      delete creditor_url(@creditor)
    end

    assert_redirected_to creditors_url
  end
end
