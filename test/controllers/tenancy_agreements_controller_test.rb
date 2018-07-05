require 'test_helper'

class TenancyAgreementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenancy_agreement = tenancy_agreements(:one)
  end

  test "should get index" do
    get tenancy_agreements_url
    assert_response :success
  end

  test "should get new" do
    get new_tenancy_agreement_url
    assert_response :success
  end

  test "should create tenancy_agreement" do
    assert_difference('TenancyAgreement.count') do
      post tenancy_agreements_url, params: { tenancy_agreement: {  } }
    end

    assert_redirected_to tenancy_agreement_url(TenancyAgreement.last)
  end

  test "should show tenancy_agreement" do
    get tenancy_agreement_url(@tenancy_agreement)
    assert_response :success
  end

  test "should get edit" do
    get edit_tenancy_agreement_url(@tenancy_agreement)
    assert_response :success
  end

  test "should update tenancy_agreement" do
    patch tenancy_agreement_url(@tenancy_agreement), params: { tenancy_agreement: {  } }
    assert_redirected_to tenancy_agreement_url(@tenancy_agreement)
  end

  test "should destroy tenancy_agreement" do
    assert_difference('TenancyAgreement.count', -1) do
      delete tenancy_agreement_url(@tenancy_agreement)
    end

    assert_redirected_to tenancy_agreements_url
  end
end
