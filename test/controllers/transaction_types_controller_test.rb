require 'test_helper'

class TransactionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction_type = transaction_types(:one)
  end

  test "should get index" do
    get transaction_types_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_type_url
    assert_response :success
  end

  test "should create transaction_type" do
    assert_difference('TransactionType.count') do
      post transaction_types_url, params: { transaction_type: {  } }
    end

    assert_redirected_to transaction_type_url(TransactionType.last)
  end

  test "should show transaction_type" do
    get transaction_type_url(@transaction_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_type_url(@transaction_type)
    assert_response :success
  end

  test "should update transaction_type" do
    patch transaction_type_url(@transaction_type), params: { transaction_type: {  } }
    assert_redirected_to transaction_type_url(@transaction_type)
  end

  test "should destroy transaction_type" do
    assert_difference('TransactionType.count', -1) do
      delete transaction_type_url(@transaction_type)
    end

    assert_redirected_to transaction_types_url
  end
end
