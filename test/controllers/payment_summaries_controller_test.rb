require 'test_helper'

class PaymentSummariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment_summary = payment_summaries(:one)
  end

  test "should get index" do
    get payment_summaries_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_summary_url
    assert_response :success
  end

  test "should create payment_summary" do
    assert_difference('PaymentSummary.count') do
      post payment_summaries_url, params: { payment_summary: {  } }
    end

    assert_redirected_to payment_summary_url(PaymentSummary.last)
  end

  test "should show payment_summary" do
    get payment_summary_url(@payment_summary)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_summary_url(@payment_summary)
    assert_response :success
  end

  test "should update payment_summary" do
    patch payment_summary_url(@payment_summary), params: { payment_summary: {  } }
    assert_redirected_to payment_summary_url(@payment_summary)
  end

  test "should destroy payment_summary" do
    assert_difference('PaymentSummary.count', -1) do
      delete payment_summary_url(@payment_summary)
    end

    assert_redirected_to payment_summaries_url
  end
end
